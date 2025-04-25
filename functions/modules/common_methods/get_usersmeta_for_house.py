

def get_usersmeta_for_house(houseId: houseId):
    fcm_tokens = []
    house_ref = db.collection("houses").document(house_id)
    house_data = house_ref.get().to_dict()
    users_meta = house_data.get("usersMeta", {})
    print(f"📗House ID: {house_id}, Users Meta: {users_meta}")

    for flatmate_id, meta in users_meta.items():
        if flatmate_id == user_id: continue
        fcm_token = meta.get("fcmToken")
        if fcm_token:
            fcm_tokens.append(fcm_token)