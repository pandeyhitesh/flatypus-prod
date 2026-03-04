class FlatypusUser {
  final String id;
  final String? name;
  final String? email;
  final String? photoURL;
  final String? phoneNumber;
  final DateTime? dobMonthDate;

  FlatypusUser({
    required this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.photoURL,
    this.dobMonthDate,
  });

  FlatypusUser copyWith({
    String? id,
    String? name,
    String? email,
    String? photoURL,
    String? phoneNumber,
    DateTime? dobMonthDate,
  }) {
    return FlatypusUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dobMonthDate: dobMonthDate ?? this.dobMonthDate,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlatypusUser &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          photoURL == other.photoURL &&
          phoneNumber == other.phoneNumber &&
          dobMonthDate == other.dobMonthDate;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      photoURL.hashCode ^
      phoneNumber.hashCode ^
      dobMonthDate.hashCode ^
      dobMonthDate.hashCode;
}
