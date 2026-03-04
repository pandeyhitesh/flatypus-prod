class Member {
  final String? id;
  final String? userId;
  final String? name;
  final String? email;
  final String? role;
  final String? photoURL;
  final int? order;

  const Member({
    this.id,
    this.name,
    this.email,
    this.role,
    this.userId,
    this.photoURL,
    this.order,
  });

  @override
  String toString() =>
      'Member{id: $id, name: $name, email: $email, role: $role, userId: $userId, photoURL: $photoURL, order: $order}';
}
