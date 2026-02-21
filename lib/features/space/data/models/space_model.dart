class SpaceModel {
  String id;
  String houseKey;
  String name;
  List<String>? entities;

  SpaceModel(
      {required this.id,
      required this.name,
      required this.houseKey,
      this.entities});

  @override
  String toString() {
    return 'SpaceModel{id: $id, name: $name, entities: $entities}';
  }

  factory SpaceModel.fromJson(Map<String, dynamic> json) => SpaceModel(
      id: json['id'],
      name: json['name'],
      entities: json['entities'],
      houseKey: json['houseKey']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'entities': entities,
        'houseKey': houseKey,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpaceModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
