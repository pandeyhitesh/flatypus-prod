# Welcome to Cloud Functions for Firebase for Python!
# To get started, simply uncomment the below code or create your own.
# Deploy with `firebase deploy`

from firebase_functions import firestore_fn, options
from firebase_admin import initialize_app, messaging
from base64 import b64decode
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad

initialize_app()

@firestore_fn.on_document_created(document="houses/{houseId}/chatroom/{messageId}")
def send_group_notification(event: firestore_fn.Event[firestore_fn.DocumentSnapshot | None]) -> None:
    """Trigger a push notification when a new message is created in a group chat."""
    if event.data is None:
            return
    try:
        # Get the new message data
        message_data = event.data.to_dict()
        sender_id = message_data.get("senderId")
        message_text = message_data.get("encryptedText")
        iv_base64 = message_data.get("iv")
        houseId = event.params["houseId"]
        print(f'Variable: {sender_id}, {message_text}, {houseId}')

        # Get group details from Firestore
        from firebase_admin import firestore
        db = firestore.client()
        house_ref = db.collection("houses").document(houseId)
        house_doc = house_ref.get()
        print(f"House document: {house_doc.to_dict()}")

        if not house_doc.exists:
            print(f"House {houseId} does not exist")
            return

        house_data = house_doc.to_dict()
        members = house_data.get("users", [])

        # Get sender's name for notification
        sender_ref = db.collection("users").document(sender_id)
        sender_doc = sender_ref.get()
        sender_name = sender_doc.to_dict().get("displayName", "Someone") if sender_doc.exists else "Someone"
        sender_split = sender_name.split()
        sender_first_name = 'Your Flatmate'
        if len(sender_split) > 1:
            sender_first_name = sender_split[0]
        print(f"Sender name: {sender_name}")

        # Get FCM tokens for all members except the sender
        tokens = []
        for member_id in members:
            if member_id != sender_id:  # Exclude sender
                user_ref = db.collection("users").document(member_id)
                user_doc = user_ref.get()
                print(f"IN loop : User document: {user_doc.to_dict()}")
                if user_doc.exists and "fcmToken" in user_doc.to_dict():
                    tokens.append(user_doc.to_dict()["fcmToken"])

        if not tokens:
            print("No valid tokens found for notification")
            return

        for token in tokens:
            # Create notification payload
            notification = messaging.Notification(
                title=f"New Message from {sender_first_name}",
                body="Tap to view"
            )
            message = messaging.Message(
                notification=notification,
                token=token,
                data={
                    "route": "chat",
                    "encrypted": "1",
                    "text": message_text,
                    "iv": iv_base64,
                },  # Optional: Pass group ID for navigation
            )
            print(f"Notification payload: {vars(message)}")
            # Send notification
            response = messaging.send(message)
            print(f"Successfully sent notification to {token}")
            print(f"Response {str(response)}")

            # DELETE OLD MESSAGES
            messages_query = messages_ref.order_by("timestamp", direction=firestore.Query.ASCENDING)
            messages = messages_query.stream()
            messages_list = list(messages)


    except Exception as e:
        print(f'Error sending group notification: {str(e)}')