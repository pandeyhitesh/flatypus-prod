import 'dart:developer' as dev;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flatypus/common/methods.dart';
import 'package:flatypus/models/task_model.dart';
import 'package:flatypus/services/auth_service.dart';
import 'package:flatypus/services/firestore/collentions.dart';

class TaskService {
  final taskCollection = FSCollections.tasks;

  final _db = FirebaseFirestore.instance;
  Future<bool> addNewTaskToDB({
    required TaskModel task,
  }) async {
    try {
      final newTaskRef = _db.collection(taskCollection).doc();
      task.id = newTaskRef.id;
      dev.log("task json = ${task.toJson()}");

      await newTaskRef.set(task.toJson());
      return true;
    } catch (e) {
      dev.log("Error! {TaskService} Failed to add new Task to DB");
    }
    return false;
  }

  Future<List<TaskModel>> getTasksByhouseKey(
      {required String? houseKey}) async {
    try {
      if (houseKey == null) return [];
      final qrySnapshot = await _db
          .collection(taskCollection)
          .where('houseKey', isEqualTo: houseKey)
          .orderBy('scheduledDate', descending: true)
          .get();
      if (qrySnapshot.docs.isEmpty) return [];
      qrySnapshot.docs.map((doc) => dev.log("Tasks from FS = ${doc.data()}"));
      return qrySnapshot.docs
          .map((doc) => TaskModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error: Failed to get Tasks for the House');
      return [];
    }
  }

  Future<List<TaskModel>> getTasksBySpaceId({required String? spaceId}) async {
    try {
      if (spaceId == null) return [];
      final qrySnapshot = await _db
          .collection(taskCollection)
          .where('spaceId', isEqualTo: spaceId)
          .orderBy('scheduledDate', descending: true)
          .get();
      if (qrySnapshot.docs.isEmpty) return [];
      return qrySnapshot.docs
          .map((doc) => TaskModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error: Failed to get Tasks for the space');
      return [];
    }
  }

  Future<List<TaskModel>> getTasksByUser({required String? userId}) async {
    try {
      userId ??= AuthService.loggedInUser()?.uid;
      if (userId == null) return [];
      final qrySnapshot = await _db
          .collection(taskCollection)
          .where('assignedTo', isEqualTo: userId)
          .orderBy('scheduledDate', descending: true)
          .get();
      if (qrySnapshot.docs.isEmpty) return [];
      return qrySnapshot.docs
          .map((doc) => TaskModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      dev.log('Error: Failed to get Tasks for the User, E:$e');
      return [];
    }
  }

  Future<List<TaskModel>> getFilteredTasks(
      {required bool selfTasks, required DateTime? date}) async {
    try {
      final userId = AuthService.loggedInUser()?.uid;
      if (userId == null) return [];
      Query<Map<String, dynamic>> query = _db
          .collection(taskCollection)
          .orderBy('scheduledDate', descending: true);

      date ??= today;

      query = query.where('scheduledDate',
          isEqualTo: getDate(date).toIso8601String());

      if (selfTasks) {
        query = query.where(
          'assignedTo',
          isEqualTo: userId,
        );
      }

      final qrySnapshot = await query.get();
      if (qrySnapshot.docs.isEmpty) return [];

      return qrySnapshot.docs
          .map((doc) => TaskModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      dev.log('Error: Failed to get Tasks for the User, E:$e');
      return [];
    }
  }

  Future<bool> disableAllTasksBySpaceId({required String? spaceId}) async {
    try {
      if (spaceId == null) return false;
      final qrySnapshot = await _db
          .collection(taskCollection)
          .where('spaceId', isEqualTo: spaceId)
          .get();
      if (qrySnapshot.docs.isEmpty) return true;
      for (QueryDocumentSnapshot document in qrySnapshot.docs) {
        await document.reference.update({'active': false});
      }
      return true;
    } catch (e) {
      print('Error: Failed to delete the Space');
    }
    return false;
  }

  Future<bool> updateTaskInDB({
    required TaskModel task,
  }) async {
    try {
      final document = _db.collection(taskCollection).doc(task.id);
      await document.update(task.toJson());
      return true;
    } catch (e) {
      dev.log("Error! {TaskService} Failed to Update Task in DB");
    }
    return false;
  }

  Future<bool> updateStatusTaskInDB({
    required String taskId,
    required bool status,
  }) async {
    try {
      final document = _db.collection(taskCollection).doc(taskId);
      await document.update({'active': status});
      return true;
    } catch (e) {
      dev.log("Error! {TaskService} Failed to Update Task in DB");
    }
    return false;
  }
}
