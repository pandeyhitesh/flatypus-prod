class UserOrder {
  String uid;
  int order;

  UserOrder({
    required this.uid,
    required this.order,
  });

  factory UserOrder.fromJson(Map<String, dynamic> json) {
    return UserOrder(
      uid: json['uid'],
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'order': order,
    };
  }

  @override
  String toString() {
    return 'UserOrder{uid: $uid, order: $order}';
  }
}

class HouseModel {
  String? id;
  String? displayName;
  String? houseKey;
  String? address;
  List<UserOrder>? userOrder;
  List<String>? users; // Add this field to store just the user IDs

  HouseModel({
    this.id,
    this.displayName,
    this.houseKey,
    this.userOrder,
    this.users, // Initialize this field
    this.address,
  });

  factory HouseModel.fromJson(Map<String, dynamic> json) {
    return HouseModel(
      id: json['id'],
      displayName: json['displayName'],
      houseKey: json['houseKey'],
      userOrder: json['userOrder'] == null
          ? null
          : (json['userOrder'] as List)
              .map((user) => UserOrder.fromJson(user))
              .toList(),
      users: List<String>.from(json['users'] ?? []), // Deserialize user IDs
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'houseKey': houseKey,
      'userOrder': userOrder?.map((uOrder) => uOrder.toJson()).toList(),
      'users': users, // Serialize user IDs
      'address': address,
    };
  }
}
