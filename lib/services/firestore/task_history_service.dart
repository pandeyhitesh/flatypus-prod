
import 'dart:developer' as dev;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flatypus/models/task_history_model.dart';
import 'package:flatypus/services/firestore/collentions.dart';

class TaskHistoryService {
  final _collection = FSCollections.taskHistory;

  final _db = FirebaseFirestore.instance;

  Future<List<TaskHistoryModel>> getTaskHistoryByHouseKey(
      {required String? houseKey}) async {
    try {
      if (houseKey == null) return [];
      final qrySnapshot = await _db
          .collection(_collection)
          .where('houseKey', isEqualTo: houseKey)
          .orderBy('completedDate', descending: true)
          .get();
      if (qrySnapshot.docs.isEmpty) return [];
      qrySnapshot.docs
          .map((doc) => dev.log("Task History from FS = ${doc.data()}"));
      return qrySnapshot.docs
          .map((doc) => TaskHistoryModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      dev.log('Error: Failed to get task history for the house');
      return [];
    }
  }

  Future<List<TaskHistoryModel>> getTaskHistoryBySpaceId(
      {required String? spaceId}) async {
    try {
      if (spaceId == null) return [];
      final qrySnapshot = await _db
          .collection(_collection)
          .where('spaceId', isEqualTo: spaceId)
          .get();
      if (qrySnapshot.docs.isEmpty) return [];
      qrySnapshot.docs
          .map((doc) => dev.log("Task History from FS = ${doc.data()}"));
      return qrySnapshot.docs
          .map((doc) => TaskHistoryModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      dev.log('Error: Failed to get task history for the house');
      return [];
    }
  }

  Future<bool> addNewTaskHistoryToDB(
      {required TaskHistoryModel taskHistory}) async {
    try {
      final newTaskHistoryRef = _db.collection(_collection).doc();
      taskHistory.id = newTaskHistoryRef.id;
      await newTaskHistoryRef.set(taskHistory.toJson());
      return true;
    } catch (e) {
      dev.log("Error! {TaskHistoryService} Failed to add new task to DB");
    }
    return false;
  }
}
