import 'package:flatypus/features/house/domain/entities/member.dart';
import 'package:flatypus/features/house/domain/entities/user_order.dart';

class House {
  final String? id;
  final String? displayName;
  final String? houseKey;
  final String? address;
  List<UserOrder>? userOrder;
  List<Member>? members;

  House({
    required this.id,
    required this.displayName,
    required this.houseKey,
    required this.address,
    required this.userOrder,
    required this.members,
  });

  @override
  String toString() =>
      'House{id: $id, displayName: $displayName, houseKey: $houseKey, '
      'address: $address, members: ${members?.length ?? 0}}';
}
