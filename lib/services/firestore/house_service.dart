import 'dart:developer' as dev;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatypus/models/user_model.dart';
import 'package:flatypus/services/firestore/collentions.dart';
import 'package:flatypus/services/firestore/user_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/house_model.dart';

class HouseService {
  // HouseService._();
  final collection = FSCollections.houses;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Generate a unique roomId in the format "xxx-xxx-xxxx"
  String generateRoomId() {
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => chars.codeUnitAt(Random().nextInt(chars.length))));
    return 'FLTP-${getRandomString(3)}-${getRandomString(4)}';
  }

  // Create or get a room
  Future<HouseModel?> createOrGetHouse(
      {required String displayName, required String address}) async {
    String roomId = generateRoomId();
    HouseModel? existingRoom;

    do {
      final querySnapshot = await _db
          .collection(collection)
          .where('houseKey', isEqualTo: roomId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        existingRoom = HouseModel.fromJson(querySnapshot.docs.first.data());
      } else {
        existingRoom = null;
      }
    } while (existingRoom != null);

    final newRoomRef = _db.collection(collection).doc();
    final currentUserId =
        UserModel.fromFirebaseUser(FirebaseAuth.instance.currentUser!).uid;
    final newRoom = HouseModel(
      id: newRoomRef.id,
      displayName: displayName,
      houseKey: roomId,
      address: address,
      userOrder: [UserOrder(uid: currentUserId, order: 1)],
      users: [currentUserId],
    );

    await newRoomRef.set(newRoom.toJson());
    //check if user already exists in FS
    final user = UserModel.fromFirebaseUser(FirebaseAuth.instance.currentUser!);
    final existingUser = await UserServices().getUserByUid(user.uid);
    if (existingUser == null) {
      final userRef = _db.collection(FSCollections.users).doc(user.uid);
      await userRef.set(user.toJson());
    }
    return newRoom;
  }

  // Add a user to a room
  Future<bool> addUserToHouse(String houseKey, UserModel user) async {
    try {
      final querySnapshot = await _db
          .collection(collection)
          .where('houseKey', isEqualTo: houseKey)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final roomRef =
            _db.collection(collection).doc(querySnapshot.docs.first.id);

        // Fetch the current house data
        final houseSnapshot = await roomRef.get();
        final HouseModel house =
            HouseModel.fromJson(houseSnapshot.data() as Map<String, dynamic>);

        // Determine the new order for the user
        final int newOrder = (house.userOrder?.length ?? 0) + 1;

        // Update the users list
        await roomRef.update({
          'users': FieldValue.arrayUnion([user.uid]),
          'userOrder': FieldValue.arrayUnion([
            {
              'uid': user.uid,
              'order': newOrder,
            }
          ]),
        });

        //check if user already exists in FS
        final existingUser = await UserServices().getUserByUid(user.uid);
        if (existingUser == null) {
          final userRef = _db.collection(FSCollections.users).doc(user.uid);
          await userRef.set(user.toJson());
        }
        return true;
      }
    } catch (e) {
      dev.log('Error: {HouseService.addUserToHouse}, Failed to add user');
    }
    return false;
  }

  // Get users in a room
  Future<List<UserModel>> getUsersInRoom(
      {required WidgetRef ref, String? houseKey}) async {
    if (houseKey == null) {
      // get houseKey from current logged in user
      final house = await getHouseByUserId();
      houseKey = house?.houseKey;
    }
    final querySnapshot = await _db
        .collection(collection)
        .where('houseKey', isEqualTo: houseKey)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      final house = HouseModel.fromJson(querySnapshot.docs.first.data());
      List<UserModel> users = [];
      for (var uid in house.users ?? []) {
        final userQSS = await _db
            .collection(FSCollections.users)
            .where('uid', isEqualTo: uid)
            .get();
        if (userQSS.docs.isNotEmpty) {
          final userData = userQSS.docs.first.data();
          users.add(UserModel.fromJson(userData));
        }
      }
      return users;
    } else {
      return [];
    }
  }

  // Search room by roomId
  Future<HouseModel?> getHouseByHouseKey(String houseKey) async {
    final querySnapshot = await _db
        .collection(collection)
        .where('houseKey', isEqualTo: houseKey.toUpperCase().trim())
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      return HouseModel.fromJson(querySnapshot.docs.first.data());
    } else {
      return null;
    }
  }

  // search for associated house by current user
  Future<HouseModel?> getHouseByUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    final querySnapshot = await _db
        .collection(collection)
        .where('users', arrayContains: user?.uid)
        .get();
    final response = querySnapshot.docs
        .map((doc) => HouseModel.fromJson(doc.data()))
        .toList();
    // ref
    //     .read(houseProvider.notifier)
    //     .setInitialState(response.isNotEmpty ? response.last : null);
    if (response.isNotEmpty) return response.last;
    return null;
  }

  Future<bool> unlinkUserFromHouse({required String houseKey, String? userId}) async {
    try {
      if(userId == null) {
        // Get the current user's UID
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          print('\nNo user is currently logged in.');
          return false;
        }
        userId = user.uid;
      }
      // Reference to the house document
      final houseRef = _db.collection(collection).doc(houseKey);

      // Fetch the house document
      final houseSnapshot = await houseRef.get();

      if (houseSnapshot.exists) {
        // Remove the user's UID from the 'users' array
        await houseRef.update({
          'users': FieldValue.arrayRemove([userId])
        });
        // Fetch the current userOrder array
        List<dynamic>? userOrder = houseSnapshot.data()?['userOrder'];

        // Filter out the user from the userOrder array
        userOrder?.removeWhere((userMap) => userMap['uid'] == userId);

        // Update the userOrder array in Firestore
        await houseRef.update({'userOrder': userOrder});

        print('User $userId successfully unlinked from house $houseKey.');
        return true;
      } else {
        print('House with ID $houseKey does not exist.');
      }
    } catch (e) {
      print('Failed to unlink user from house: $e');
    }
    return false;
  }

  Future<HouseModel?> reorderUsers(
      HouseModel? house, int oldIndex, int newIndex) async {
    try {
      if (house == null ||
          house.userOrder == null ||
          house.userOrder!.isEmpty) {
        return null;
      }
      // Get the user order list
      List<UserOrder> userOrderList = house.userOrder ?? [];
      print('Old order = $userOrderList');

      // If newIndex is greater than oldIndex, we need to adjust it
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }

      // Move the item in the list
      final UserOrder movedUser = userOrderList.removeAt(oldIndex);
      userOrderList.insert(newIndex, movedUser);

      // Update the order values in the list
      for (int i = 0; i < userOrderList.length; i++) {
        userOrderList[i].order = i + 1; // Assuming order starts at 1
      }

      // Update the house document with the new order
      await _db.collection('houses').doc(house.id).update({
        'userOrder':
            userOrderList.map((userOrder) => userOrder.toJson()).toList(),
      });

      print('NEw order = $userOrderList');

      print('Users reordered successfully');
      house.userOrder = userOrderList;
      return house;
    } catch (e) {
      print('Failed to reorder users: $e');
    }
    return null;
  }

  Future<bool> updateHouseDetails(
      HouseModel? house, String displayName, String address) async {
    try {
      if (house == null) return false;
      // Reference to the house document
      final houseRef = _db.collection(collection).doc(house.id);
      // Fetch the house document
      final houseSnapshot = await houseRef.get();
      if (houseSnapshot.exists) {
        // Remove the user's UID from the 'users' array
        await houseRef.update({
          'displayName': displayName,
          'address': address,
        });

        return true;
      }
    } catch (e) {
      print(
          '{HouseService.updateHouseDetails} Failed to update user details: $e');
    }
    return false;
  }
}
