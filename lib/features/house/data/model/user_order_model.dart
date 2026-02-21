import 'package:flatypus/features/house/domain/entities/user_order.dart';

class UserOrderModel extends UserOrder {
  UserOrderModel({super.uid, super.order});

  factory UserOrderModel.fromJson(Map<String, dynamic> json) {
    return UserOrderModel(uid: json['uid'], order: json['order']);
  }

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'order': order};
  }

  @override
  String toString() {
    return 'UserOrder{uid: $uid, order: $order}';
  }
}
