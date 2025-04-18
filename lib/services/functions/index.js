const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

//Function to Send Notification on New Tenant
exports.onNewTenant = functions.firestore
  .document('houses/{houseId}/tenants/{tenantId}')
  .onCreate(async (snap, context) => {
    const newTenant = snap.data();
    const houseId = context.params.houseId;

    // Get all other tenants in the house
    const tenantsSnapshot = await admin.firestore()
      .collection('houses')
      .doc(houseId)
      .collection('tenants')
      .get();

    const tokens = [];
    tenantsSnapshot.forEach(doc => {
      if (doc.id !== snap.id && doc.data().fcmToken) {
        tokens.push(doc.data().fcmToken);
      }
    });

    if (tokens.length === 0) return null;

    const message = {
      notification: {
        title: 'New Flatmate!',
        body: `${newTenant.name} has joined your house!`,
      },
      tokens: tokens,
    };

    return admin.messaging().sendMulticast(message);
  });

//Function for Task Reminder
exports.taskReminder = functions.pubsub
  .schedule('every 24 hours')
  .onRun(async (context) => {
    const today = new Date().toISOString().split('T')[0];

    const tasksSnapshot = await admin.firestore()
      .collectionGroup('tasks')
      .where('date', '==', today)
      .get();

    const messages = [];
    tasksSnapshot.forEach(doc => {
      const task = doc.data();
      if (task.assignedTo && task.assignedTo.fcmToken) {
        messages.push({
          token: task.assignedTo.fcmToken,
          notification: {
            title: 'Task Reminder',
            body: `Don't forget: ${task.name} is due today!`,
          },
        });
      }
    });

    return Promise.all(messages.map(msg => admin.messaging().send(msg)));
  });


// Trigger on new chat message
exports.onNewChatMessage = functions.firestore
  .document("houses/{houseId}/chatroom/{messageId}")
  .onCreate(async (snap, context) => {
    const message = snap.data();
    const houseId = context.params.houseId;

    // Get house data to identify tenants
    const houseDoc = await admin
      .firestore()
      .collection("houses")
      .doc(houseId)
      .get();

    if (!houseDoc.exists) {
      console.log("House not found.");
      return null;
    }

    const houseData = houseDoc.data();
    const tenantUserIds = houseData.users || []; // Array of user IDs from the users field

    // Get FCM tokens for all tenants except the sender
    const tokens = [];
    for (const userId of tenantUserIds) {
      const userDoc = await admin.firestore().collection("users").doc(userId).get();
      if (userDoc.exists && userId !== message.senderId && userDoc.data().fcmToken) {
        tokens.push(userDoc.data().fcmToken);
      }
    }

    if (tokens.length === 0) {
      console.log("No valid tokens found for notification.");
      return null;
    }

    // Use encrypted text directly (app will decrypt)
    const messagePreview = message.encryptedText.length > 100
      ? message.encryptedText.substring(0, 97) + "..."
      : message.encryptedText;

    // Fetch sender's displayName for a better notification
    const senderDoc = await admin.firestore().collection("users").doc(message.senderId).get();
    const senderName = senderDoc.exists ? senderDoc.data().displayName : message.senderId;

    const notification = {
      notification: {
        title: `New Message in ${houseData.displayName}`, // Use house displayName as chatroom name
        body: `${senderName}: ${messagePreview}`,
      },
      data: {
        houseId: houseId,
        chatroomId: "general", // Hardcoded since only one chatroom; adjust if dynamic
        messageId: context.params.messageId,
        type: "chat_message",
      },
      tokens: tokens,
    };

    try {
      const response = await admin.messaging().sendMulticast(notification);
      console.log(`Successfully sent ${response.successCount} notifications.`);
      if (response.failureCount > 0) {
        console.log(`Failed to send ${response.failureCount} notifications.`);
      }
    } catch (error) {
      console.error("Error sending chat notification:", error);
    }

    return null;
  });