# -- Send notification when a user is added to house
from firebase_functions import https_fn
from firebase_admin import firestore, messaging

from common.collections import Collections

def get_first_name_from_display_name(display_name, isSelf) -> str:
    if display_name:
            splt_name = display_name.split(' ')
            if splt_name:
                display_name = splt_name[0].capitalize()
                return display_name
    return '' if isSelf else 'New User'



@https_fn.on_request()
def new_user_added_to_house(req) -> None:
    print(f"▶️ Execution started for 'new_user_added_to_house'")
    try:
        if req.method != "POST":
            print(f'Error‼️: 📕Method not allowed. Use POST.')
            return {"error": "Method not allowed. Use POST."}, 405
        # Parse the request body as JSON
        request_body = req.get_json(silent=True)
        if not request_body:
            print(f'Error‼️: 📕No request body provided.')
            return {"error": "No request body provided"}, 400

        # Extract parameters from the body
        house_id = request_body.get("houseId")
        new_user_id = request_body.get("userId")
        if not new_user_id or not house_id:
            print(f'Error‼️: 📕houseId and userId parameters are required. houseId : {house_id}, newUserId: {new_user_id}')
            return {"error": "houseId and userId parameters are required"}, 400

        # get house information using houseId
        fcm_tokens = []
        flatmate_names = []
        db = firestore.client()
        house_ref = db.collection(Collections.HOUSES).document(house_id)
        house_data = house_ref.get().to_dict()
        house_name = house_data.get("displayName")
        users_meta = house_data.get("usersMeta", {})
        print(f"📗House ID: {house_id}, Users Meta: {users_meta}")
        new_user_name = ''
        new_user_token = ''

        # get flatmates' fcmToken from the house
        for flatmate_id, meta in users_meta.items():
            if flatmate_id == new_user_id: 
                new_user_name = meta.get("displayName")
                new_user_token = meta.get("fcmToken")
                continue
            fcm_token = meta.get("fcmToken")
            fl_name = meta.get("displayName")
            if fcm_token:
                fcm_tokens.append(fcm_token)
                flatmate_names.append(fl_name)
        
        # get First name from the user displayName
        new_user_name = get_first_name_from_display_name(display_name=new_user_name, isSelf=False)

        
        print(f"📗Flatmates in House : {len(fcm_tokens)}")
        
        # Send notifications to each flatmate
        for index, fcm_token in enumerate(fcm_tokens):
            fl_name = flatmate_names[index]
            # get firstName of the flatmate
            fl_name = get_first_name_from_display_name(display_name=fl_name, isSelf=True)
            # Prepare the notification for Flatmates
            notification = messaging.Notification(
                title=f"Let's welcome {new_user_name}!🎉",
                body=f"Hi {fl_name}! {new_user_name} has been added to {house_name}."
            )
            message = messaging.Message(
                notification=notification,
                token=fcm_token,
                data={"route": "home"}
            )
            response = messaging.send(message)
            print(f"✅Sent New User added notification to Flatmate (FCMToken): {fcm_token} for {new_user_name}'s Addition to the House!")

        #send welcome Message to the new user
        if new_user_token:
            new_user_notification = messaging.Notification(
                title=f"Welcome to {house_name}! 🎉",
                body=f"Hi {new_user_name}, you are now a member of {house_name}."
            )
            new_user_message = messaging.Message(
                notification=new_user_notification,
                token=new_user_token,
                data={"route": "home"}
            )
            response = messaging.send(new_user_message)
        print(f"✅Sent Welcome greeting to {new_user_name}")
        return "Notifications processed successfully", 200
    except Exception as e:
        print(f'Error❌: inside new_user_added_to_house')
        print(f'📕: {e}') 
        return f"Error: {str(e)}", 500