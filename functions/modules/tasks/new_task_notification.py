from firebase_functions import firestore_fn, options
from firebase_admin import initialize_app, messaging, firestore
from datetime import datetime

from common.collections import Collections


@firestore_fn.on_document_created(document="tasks/{taskId}")
def new_task_notification(event: firestore_fn.Event[firestore_fn.DocumentSnapshot | None]) -> None:
    if event.data is None:
        return
    try:
        taskId = event.params["taskId"]
        task_data = event.data.to_dict()
        assigned_to = task_data["assignedTo"]
        task_name = task_data["name"]
        sch_date = task_data["scheduledDate"]
        space_id = task_data["spaceId"]
        print(f'👉 New Task added: Name: {task_name}')

        # Parse and format scheduledDate
        formatted_date = ""
        if sch_date and isinstance(sch_date, str):
            try:
                dt = datetime.strptime(sch_date, "%Y-%m-%dT%H:%M:%S.%f")
                formatted_date = dt.strftime("%d/%m/%Y")  # e.g., 22/04/2025
            except ValueError as e:
                print(f"Error❗parsing scheduledDate: {str(e)}")

        db = firestore.client()

        # get Assigned User details
        assignee_ref = db.collection(Collections.USERS).document(assigned_to)
        assignee_doc = assignee_ref.get()
        if not assignee_doc.exists:
            print(f'Error❗Assigned User Not found for UserId: {assigned_to}')
            return
        assignee_data = assignee_doc.to_dict()
        assignee_name = assignee_data["displayName"]
        if not 'fcmToken' in assignee_data:
            print(f'Error❗FCM TOKEN not found for UserId: {assigned_to}, Name: {assignee_name}')
            return
        fcm_token = assignee_data['fcmToken']    

        # get space details by spaceID
        space_ref = db.collection(Collections.SPACES).document(space_id)
        space_doc = space_ref.get()
        space_name = 'a space'
        if not space_doc.exists:
            print(f'Warning⚠️ Space {space_id} does not exist')
        print(f'Space: {space_doc.to_dict()}')
        space_data = space_doc.to_dict()
        space_name = space_data["name"]

        # Prepare the notification object
        notification = messaging.Notification(
            title=f"New task added for you in {space_name}",
            body=f'Task: {task_name}\nOn: {formatted_date}'
        )
        message = messaging.Message(
            notification=notification,
            token=fcm_token,
            data={
                "route": "task",
                "taskId": f'{taskId}'
            },  
        )
        print(f"Notification payload: {vars(message)}")
        # Send notification
        response = messaging.send(message)
        print(f"✅Successfully sent notification to {assignee_name} for task: {task_name}({taskId})")
        print(f"📗Response {str(response)}")

    except Exception as e:
        print(f'Error❌: new_task_notification: {str(e)}')