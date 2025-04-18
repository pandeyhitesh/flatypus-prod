class TaskHistoryModel {
  String id;
  String userId;
  String spaceId;
  String taskId;
  String houseKey;
  DateTime completedDate;
  bool isSkipped;
  bool isDeleted;

  TaskHistoryModel({
    required this.id,
    required this.userId,
    required this.spaceId,
    required this.taskId,
    required this.houseKey,
    required this.completedDate,
    required this.isSkipped,
    required this.isDeleted,
  });

  factory TaskHistoryModel.fromJson(Map<String, dynamic> json) =>
      TaskHistoryModel(
        id: json['id'],
        userId: json['userId'],
        taskId: json['taskId'],
        completedDate: DateTime.parse(json['completedDate']),
        spaceId: json['spaceId'],
        houseKey: json['houseKey'],
        isSkipped: json['isSkipped'] ?? false,
        isDeleted: json['isDeleted'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'spaceId': spaceId,
        'taskId': taskId,
        'houseKey': houseKey,
        'completedDate': completedDate.toIso8601String(),
        'isSkipped': isSkipped,
        'isDeleted': isDeleted,
      };
}
