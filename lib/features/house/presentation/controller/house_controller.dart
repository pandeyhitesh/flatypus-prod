import 'package:flatypus/core/utils/enums.dart';
import 'package:flatypus/features/house/data/dto/house_request_dto.dart';
import 'package:flatypus/features/house/presentation/providers/house_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HouseController {
  final Ref _ref;
  const HouseController(this._ref);

  /// Call after any mutation that changes the user's house membership list.
  /// Forces [associatedHousesProvider] to refetch fresh data from the API.
  void _invalidateAssociatedHouses() {
    _ref.invalidate(associatedHousesProvider);
  }

  // ─── CREATE ──────────────────────────────────────────────────────────────

  Future<void> createHouse({
    required String houseName,
    required String address,
    VoidCallback? onSuccess,
    void Function(String error)? onError,
  }) async {
    final request = CreateHouseRequest(
      houseName: houseName.trim(),
      address: address.trim(),
    );

    await _ref.read(houseProvider.notifier).create(request);

    final state = _ref.read(houseProvider);
    state.when(
      data: (house) {
        if (house != null) {
          _invalidateAssociatedHouses();
          onSuccess?.call();
        }
      },
      error: (e, _) => onError?.call(e.toString()),
      loading: () {},
    );
  }

  // ─── JOIN ─────────────────────────────────────────────────────────────────

  Future<void> joinHouse({
    required String houseKey,
    VoidCallback? onSuccess,
    void Function(String error)? onError,
  }) async {
    final trimmed = houseKey.trim();
    if (trimmed.isEmpty) {
      onError?.call('House key cannot be empty');
      return;
    }

    await _ref.read(houseProvider.notifier).join(trimmed);

    final state = _ref.read(houseProvider);
    state.when(
      data: (house) {
        if (house != null) {
          _invalidateAssociatedHouses();
          onSuccess?.call();
        }
      },
      error: (e, _) => onError?.call(e.toString()),
      loading: () {},
    );
  }

  // ─── DELETE ───────────────────────────────────────────────────────────────

  Future<void> deleteHouse({
    required String houseId,
    VoidCallback? onSuccess,
    void Function(String error)? onError,
  }) async {
    await _ref.read(houseProvider.notifier).delete(houseId);

    final state = _ref.read(houseProvider);
    state.when(
      data: (_) {
        _invalidateAssociatedHouses();
        onSuccess?.call();
      },
      error: (e, _) => onError?.call(e.toString()),
      loading: () {},
    );
  }

  // ─── UPDATE MEMBER ROLE ───────────────────────────────────────────────────

  Future<void> updateMemberRole({
    required String houseId,
    required String userId,
    required UserRole role,
    VoidCallback? onSuccess,
    void Function(String error)? onError,
  }) async {
    final request = UpdateMemberRoleRequest(
      houseId: houseId,
      userId: userId,
      role: role,
    );

    await _ref.read(updateMemberRoleProvider.notifier).update(request);

    final state = _ref.read(updateMemberRoleProvider);
    state.when(
      data: (house) {
        if (house != null) onSuccess?.call();
      },
      error: (e, _) => onError?.call(e.toString()),
      loading: () {},
    );
  }
}

// ─── PROVIDER ────────────────────────────────────────────────────────────────

final houseControllerProvider = Provider<HouseController>(
  (ref) => HouseController(ref),
);
