import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flatypus/models/house_model.dart';
import 'package:flatypus/state/providers/users_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/firestore/house_service.dart';

class HouseNotifier extends StateNotifier<HouseModel?> {
  HouseNotifier(this.ref) : super(null) {
    getHouseFromFS();
    _listenToHouseUpdates();
  }

  final StateNotifierProviderRef ref;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription<DocumentSnapshot>? _houseSubscription;

  void _listenToHouseUpdates() {
    if(state == null && state?.id==null) return;
    try {
      final houseId = state!.id!;
      _houseSubscription = _firestore
          .collection('houses')
          .doc(houseId)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.exists) {
          final data = snapshot.data();
          if (data != null) {
            // Convert Firestore data into your model
            final house = HouseModel.fromJson(data);
            // Check if new users joined
            if (state != null && house.users!.length > state!.users!.length) {
              // sendPushNotificationToHouseMembers(house);
            }
            state = house; // Update state to trigger UI changes
          }
        }
      });
    }catch(e){}
  }

  @override
  void dispose() {
    _houseSubscription?.cancel(); // Clean up when the provider is disposed
    super.dispose();
  }

  getHouseFromFS() async {
    final HouseModel? house = await HouseService().getHouseByUserId();
    state = house;
  }

  setInitialState(HouseModel? house) => state = house;

  deleteHouse() => state = null;

  String? get houseKey => state?.houseKey;
  String? get id => state?.id;

  Future<bool> reorderUsers(int oldIndex, int newIndex) async {
    final house = state;
    await ref.read(usersProvider.notifier).getUsersFromFireStore();
    final updatedHouse =
        await HouseService().reorderUsers(house, oldIndex, newIndex);
    if (updatedHouse == null) return false;
    state = updatedHouse;
    return true;
  }

  Future<bool> updateDetails({
    required String displayName,
    required String address,
  }) async {
    HouseModel? house = state;
    final updateResult =
        await HouseService().updateHouseDetails(house, displayName, address);
    if (!updateResult) return false;
    house?.displayName = displayName;
    house?.address = address;
    state = house;
    return true;
  }
}
