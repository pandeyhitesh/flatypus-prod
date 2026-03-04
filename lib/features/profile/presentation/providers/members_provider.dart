import 'package:flatypus/features/house/domain/entities/member.dart';
import 'package:flatypus/features/house/presentation/providers/house_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Derives the member list from the currently active house state.
/// No API call — reactively computed from [houseProvider].
///
/// Returns:
///   - [] when house is loading, null, or has no members
///   - List<Member> when the active house has members populated
final membersProvider = Provider<List<Member>>((ref) {
  final houseAsync = ref.watch(houseProvider);

  return houseAsync.when(
    data: (house) => house?.members ?? [],
    loading: () => [],
    error: (_, __) => [],
  );
});

/// Derives a single member by ID from the active house's member list.
/// Usage: ref.watch(memberByIdProvider('user-id'))
final memberByIdProvider = Provider.family<Member?, String>((ref, memberId) {
  final members = ref.watch(membersProvider);
  try {
    return members.firstWhere((m) => m.id == memberId);
  } catch (_) {
    return null;
  }
});