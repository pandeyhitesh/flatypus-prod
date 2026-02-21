import 'package:flatypus/features/house/data/model/user_order_model.dart';
import 'package:flatypus/features/house/domain/entities/house.dart';

class HouseModel extends House {
  HouseModel({
    super.id,
    super.displayName,
    super.houseKey,
    super.userOrder,
    super.users, // Initialize super field
    super.address,
  });

  factory HouseModel.fromJson(Map<String, dynamic> json) {
    return HouseModel(
      id: json['id'],
      displayName: json['displayName'],
      houseKey: json['houseKey'],
      userOrder:
          json['userOrder'] == null
              ? null
              : (json['userOrder'] as List)
                  .map((user) => UserOrderModel.fromJson(user))
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
      'userOrder': userOrder?.map((uOrder) => (uOrder as UserOrderModel).toJson()).toList(),
      'users': users, // Serialize user IDs
      'address': address,
    };
  }
}
