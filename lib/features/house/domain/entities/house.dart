import 'package:flatypus/features/house/domain/entities/user_order.dart';

class House {
  final String? id;
  final String? displayName;
  final String? houseKey;
  final String? address;
  List<UserOrder>? userOrder;
  List<String>? users;

  House({
    required this.id,
    required this.displayName,
    required this.houseKey,
    required this.address,
    required this.userOrder,
    required this.users,
  });
}
