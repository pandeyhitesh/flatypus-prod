import 'dart:developer' as dev;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_log/color_log.dart';
import 'package:flatypus/common/snackbar.dart';
import 'package:flatypus/common/utils/logger.dart';
import 'package:flatypus/models/space_model.dart';
import 'package:flatypus/services/firestore/collentions.dart';

class SpaceService {
  final spaceCollection = FSCollections.spaces;

  final _db = FirebaseFirestore.instance;
  Future<SpaceModel?> addNewSpaceToDB({
    required String spaceName,
    required String? houseKey,
  }) async {
    try {
      if (houseKey == null) {
        showErrorSnackbar(label: 'Failed to add space. House not added.');
        return null;
      }
      final newSpaceRef = _db.collection(spaceCollection).doc();
      final newSpaceObject =
          SpaceModel(id: newSpaceRef.id, name: spaceName, houseKey: houseKey);
      await newSpaceRef.set(newSpaceObject.toJson());
      return newSpaceObject;
    } catch (e) {
      clog.error("Error! {SpaceService} Failed to add new Space");
    }
    return null;
  }

  Future<List<SpaceModel>> getSpacesByhouseKey(
      {required String? houseKey}) async {
    try {
      clog.info('\n\nHouse id = $houseKey');
      if (houseKey == null) return [];
      final qrySnapshot = await _db
          .collection(spaceCollection)
          .where('houseKey', isEqualTo: houseKey)
          .get();
      if (qrySnapshot.docs.isEmpty) return [];
      return qrySnapshot.docs
          .map((doc) => SpaceModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      clog.error('Error: Failed to get Spaces for the House');
      return [];
    }
  }

  Future<bool> deleteSpaceBySpaceId({required String? spaceId}) async {
    try {
      if (spaceId == null) return false;
      await _db.collection(spaceCollection).doc(spaceId).delete();
      return true;
    } catch (e) {
      clog.error('Error: Failed to delete the Space');
    }
    return false;
  }
}
