import 'package:flatypus/core/utils/enums.dart';

class CreateHouseRequest {
  String houseName;
  String address;

  CreateHouseRequest({required this.houseName, required this.address});

  Map<String, dynamic> toJson() {
    return {'house_name': houseName, 'address': address};
  }
}

class UpdateMemberRoleRequest {
  String houseId;
  String userId;
  UserRole role;

  UpdateMemberRoleRequest({
    required this.houseId,
    required this.userId,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {'new_role': role.name};
  }
}
