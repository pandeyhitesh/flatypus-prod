from firebase_functions import scheduler_fn, options, https_fn
from firebase_admin import firestore, messaging
import os
from datetime import datetime, timedelta
import pytz
from common.collections import Collections
from modules.common_methods.send_notifications_to_flatmates import send_bd_notifications_to_flatmates



@scheduler_fn.on_schedule(
    schedule="every day 00:00"
)
def birthday_notification(event) -> None:
    try:
        # Set timezone (e.g., UTC)
        tz = pytz.UTC
        today = datetime.now(tz).date()
        # Calculate date n days from now, considering only month and day
        n = 5
        nth_date_in_future = today + timedelta(days=n)
        today_md = today.strftime("%m-%d")
        nth_date_md = nth_date_in_future.strftime("%m-%d")
        print(f"📗Today: {today}, End Date: {nth_date_in_future}, Today MD: {today_md}, End MD: {nth_date_md}")
        # Query users with birthdays on (Today + n)th day
        db = firestore.client()
        users_ref = db.collection(Collections.USERS)
        # ------------------------------------
        # -- Get Users with upcoming Birthday
        # ------------------------------------
        upcoming_birthday_users_stream = users_ref.where("dobMonthDate", "==", nth_date_md).stream()
        upcoming_birthday_users= list(upcoming_birthday_users_stream)
        print(f"📗 Upcoming Birthday Users: {len(upcoming_birthday_users)}")
        for user_doc in upcoming_birthday_users:
            user_data = user_doc.to_dict()
            user_id = user_doc.id
            houses = user_data.get("houses", [])
            
            # Send birthDay notifications to Flatmates
            send_bd_notifications_to_flatmates(user_data=user_data, houseIds=houses, isBirthdayToday= False, birthDate=nth_date_in_future)
        
        # ------------------------------------
        # -- Get users who have birthDay today
        # ------------------------------------
        today_birthday_users_stream = users_ref.where("dobMonthDate", "==", today_md).stream()
        today_birthday_users = list(today_birthday_users_stream)
        print(f"📗Birthday Users Today: {len(today_birthday_users)}")
        for user_doc in today_birthday_users:
            user_data = user_doc.to_dict()
            user_id = user_doc.id
            houses = user_data.get("houses", [])
            birthday_user_name = user_data.get('displayName')
            # Send birthday greeting to the person
            user_fcm_token = user_data.get("fcmToken")
            if user_fcm_token:
                birthday_message = messaging.Message(
                    notification=messaging.Notification(
                        title="It's your birthday! 🎉🥳",
                        body=f"Happy Birthday, {birthday_user_name}! Hope you have a great day with your Flatmates!"
                    ),
                    token=user_fcm_token,
                    data={"route": "home"}
                )
                response = messaging.send(birthday_message)
                print(f"✅Sent birthday greeting to {birthday_user_name} (FCMToken): {user_fcm_token}")

            # Send birthDay notifications to Flatmates
            send_bd_notifications_to_flatmates(user_data=user_data, houseIds=houses, isBirthdayToday= True, birthDate=None)
        

            
        # return "Notifications processed successfully", 200
    except Exception as e:
        print(f'Error❌: inside birthday_notification')
        print(f'📕: {e}') 
        # return f"Error: {str(e)}", 500