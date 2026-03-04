import 'package:flatypus/features/house/domain/entities/member.dart';

class MemberModel extends Member {
  const MemberModel({
     super.id,
     super.userId,
     super.name,
     super.email,
     super.role,
     super.photoURL,
     super.order,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        role: json['role'] as String,
        userId: json['userId'] as String,
        photoURL: json['photoURL'] as String,
        order: json['order'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'role': role,
        'userId': userId,
        'order': order,
      };
}