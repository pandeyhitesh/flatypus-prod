/// Centralized API route definitions.
/// Usage:
///   ApiRoutes.house.create
///   ApiRoutes.house.getById('abc-123')
///   ApiRoutes.house.updateMemberRole('houseId', 'userId')
abstract class ApiRoutes {
  static const auth = _AuthRoutes();
  static const house = _HouseRoutes();
}

// ─── AUTH ───────────────────────────────────────────────────────────────────

class _AuthRoutes {
  const _AuthRoutes();

  String get login => '/auth/login';
  String get callback => '/auth/callback';
  String get googleMobile => '/auth/google-mobile';
}

// ─── HOUSE ──────────────────────────────────────────────────────────────────

class _HouseRoutes {
  const _HouseRoutes();

  String get create => '/house/create';
  String get join => '/house/join';
  String get mine => '/house/mine';

  String getById(String houseId) => '/house/$houseId';
  String delete(String houseId) => '/house/delete/$houseId';
  String updateMemberRole(String houseId, String userId) =>
      '/house/update-member-role/$houseId/$userId';
}