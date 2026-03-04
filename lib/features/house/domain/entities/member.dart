
class Member {
  final String id;
  final String name;
  final String email;
  final String role;

  const Member({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  @override
  String toString() =>
      'Member{id: $id, name: $name, email: $email, role: $role}';
}