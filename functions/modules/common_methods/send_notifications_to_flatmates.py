# Send Birthday Group notifications to Flatmates Excluding the birthday user
from firebase_admin import firestore, messaging
from common.collections import Collections

def send_bd_notifications_to_flatmates(user_data, houseIds, isBirthdayToday, birthDate):
    print(f"▶️ Execution started for 'send_bd_notifications_to_flatmates'")
    print(f"📗User Data: {user_data}, houseId: {houseIds}, isBirthdayToday: {isBirthdayToday}")
    if not user_data or not houseIds: return
    try:
        db = firestore.client()
        user_id = user_data.get('uid')
        birthday_user_name = user_data.get('displayName')
        NT_TITLE = "It's a Birthday!" if isBirthdayToday else "Upcoming Birthday Alert!"
        NT_BODY = f"Today is {birthday_user_name}'s birthday! 🎂" if isBirthdayToday else f"{birthday_user_name}'s birthday is on {birthDate.strftime("%A, %B %d")}!"
        for house_id in houseIds:
            fcm_tokens = []
            house_ref = db.collection(Collections.HOUSES).document(house_id)
            house_data = house_ref.get().to_dict()
            users_meta = house_data.get("usersMeta", {})
            print(f"📗House ID: {house_id}, Users Meta: {users_meta}")

            for flatmate_id, meta in users_meta.items():
                if flatmate_id == user_id: continue
                fcm_token = meta.get("fcmToken")
                if fcm_token:
                    fcm_tokens.append(fcm_token)

            if not fcm_tokens: continue
            print(f"📗Flatmates in House (isBirthDayToday : {isBirthdayToday}): {len(fcm_tokens)}")
            notification = messaging.Notification(
                title=NT_TITLE,
                body=NT_BODY
            )
            for fcm_token in fcm_tokens:
                message = messaging.Message(
                    notification=notification,
                    token=fcm_token,
                    data={"route": "home"}
                )
                response = messaging.send(message)
                print(f"✅Sent birthday notification to Flatmate (FCMToken): {fcm_token} for {birthday_user_name}'s birthday! (isBirthdayToday:{isBirthdayToday})")
    except Exception as e:
        print('Error❌: inside send_bd_notifications_to_flatmates') 
        print(f'📕: {e}') 