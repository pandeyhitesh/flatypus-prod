import 'package:flatypus/features/house/data/model/member_model.dart';
import 'package:flatypus/features/house/domain/entities/house.dart';

class HouseModel extends House {
  HouseModel({
    super.id,
    super.displayName,
    super.houseKey,
    super.userOrder,
    super.members, // Initialize super field
    super.address,
  });

  factory HouseModel.fromJson(Map<String, dynamic> json) {
    return HouseModel(
      id: json['id'],
      displayName: json['house_name'],
      houseKey: json['house_key'],
      userOrder: null,
          // json['userOrder'] == null
          //     ? null
          //     : (json['userOrder'] as List)
          //         .map((user) => UserOrderModel.fromJson(user))
          //         .toList(),
      members: null,
      address: json['address'],
    );
  }

  factory HouseModel.fromDetailJson(Map<String, dynamic> json){
    final houseData = json['house'] as Map<String, dynamic>;
    final membersData = json['members'] as List<dynamic>? ?? [];
    return HouseModel(
      id: houseData['id'] as String?,
      displayName: houseData['house_name'] as String?,
      houseKey: houseData['house_key'] as String?,
      address: houseData['address'] as String?,
      userOrder: null,
      members: membersData
          .map((m) => MemberModel.fromJson(m as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'house_name': displayName,
      'house_key': houseKey,
      'address': address,
    };
  }
}
