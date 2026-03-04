
/// Mirrors the backend's MyHouseItem schema from /house/mine
class MyHouseItem {
  final String id;
  final String houseName;
  final String houseKey;
  final String address;
  final String joinedAt;
  final int memberCount;
  final String role;

  MyHouseItem({
    required this.id,
    required this.houseName,
    required this.houseKey,
    required this.address,
    required this.joinedAt,
    required this.memberCount,
    required this.role,
  });

  factory MyHouseItem.fromJson(Map<String, dynamic> json) => MyHouseItem(
        id: json['id'] as String,
        houseName: json['house_name'] as String,
        houseKey: json['house_key'] as String,
        address: json['address'] as String,
        joinedAt: json['joined_at'] as String,
        memberCount: json['member_count'] as int,
        role: json['role'] as String,
      );
}

class AssociatedHousesResponse {
  int total;
  int limit;
  int offset;
  List<MyHouseItem> houses;

  AssociatedHousesResponse({
    required this.total,
    required this.limit,
    required this.offset,
    required this.houses,
  });

  factory AssociatedHousesResponse.fromJson(Map<String, dynamic> json) {
    return AssociatedHousesResponse(
      total: json['total'] as int,
      limit: json['limit'] as int,
      offset: json['offset'] as int,
      houses:
          (json['houses'] as List<dynamic>)
              .map((e) => MyHouseItem.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }
}
