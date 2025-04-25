# Welcome to Cloud Functions for Firebase for Python!
# To get started, simply uncomment the below code or create your own.
# Deploy with `firebase deploy`
from firebase_admin import initialize_app

from modules.chatroom.send_group_notification import send_group_notification
from modules.tasks.new_task_notification import new_task_notification
from  modules.events.birth_day_notification import  birthday_notification
from modules.events.new_user_added_to_house import new_user_added_to_house

initialize_app()



