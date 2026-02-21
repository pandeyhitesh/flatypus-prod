import 'package:flatypus/features/house/data/model/house_model.dart';
import 'package:flatypus/features/house/domain/entities/house.dart';

class AssociatedHousesResponse {
  int total;
  int limit;
  int offset;
  List<House> houses;

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
              .map((e) => HouseModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }
}
