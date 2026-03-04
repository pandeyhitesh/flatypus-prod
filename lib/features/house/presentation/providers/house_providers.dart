import 'package:flatypus/core/di/injector.dart';
import 'package:flatypus/features/house/data/dto/house_response_dto.dart';
import 'package:flatypus/features/house/domain/entities/house.dart';
import 'package:flatypus/features/house/presentation/providers/notifiers/house_notifier.dart';
import 'package:flatypus/features/house/presentation/providers/notifiers/update_member_role_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ─── MUTATIONS (StateNotifier — triggered by user action) ───────────────────

/// handles house operations.
/// Usage: ref.read(HouseProvider.notifier).create(request)
/// Usage: ref.read(HouseProvider.notifier).join(request)
/// Usage: ref.read(HouseProvider.notifier).delete(request)
final houseProvider = StateNotifierProvider<HouseNotifier, AsyncValue<House?>>(
  (ref) => HouseNotifier(
    ref.read(createHouseUsecaseProvider),
    ref.read(joinHouseUsecaseProvider),
    ref.read(deleteHouseUsecaseProvider),
    ref.read(getHouseUsecaseProvider),
  ),
);

/// Update a member's role within a house.
/// Usage: ref.read(updateMemberRoleProvider.notifier).update(request)
final updateMemberRoleProvider = StateNotifierProvider<
  UpdateMemberRoleNotifier,
  AsyncValue<House?>
>((ref) => UpdateMemberRoleNotifier(ref.read(updateMemberRoleUsecaseProvider)));

// ─── QUERIES (FutureProvider — auto-fetched, reactive) ──────────────────────

/// Fetch a single house by ID.
/// Usage: ref.watch(getHouseProvider('house-id'))
final getHouseProvider = FutureProvider.family<House, String>(
  (ref, houseId) => ref.read(getHouseUsecaseProvider)(houseId),
);

/// Fetch all houses associated with the current user.
/// Usage: ref.watch(associatedHousesProvider)
final associatedHousesProvider = FutureProvider<AssociatedHousesResponse>(
  (ref) => ref.read(getAssociatedHousesUsecaseProvider)(),
);
