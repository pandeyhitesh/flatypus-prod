// To parse this JSON data, do
//
//     final chatMessageModel = chatMessageModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ChatMessageModel chatMessageModelFromJson(String str) =>
    ChatMessageModel.fromJson(json.decode(str));

String chatMessageModelToJson(ChatMessageModel data) =>
    json.encode(data.toJson());

class ChatMessageModel {
  final String encryptedText;
  final String senderId;
  final DateTime timestamp;
  final String iv;
  final String id;

  ChatMessageModel({
    required this.id,
    required this.encryptedText,
    required this.senderId,
    required this.timestamp,
    required this.iv,
  });

  ChatMessageModel copyWith({
    String? id,
    String? encryptedText,
    String? senderId,
    DateTime? timestamp,
    String? iv,
  }) => ChatMessageModel(
    id: id ?? this.id,
    encryptedText: encryptedText ?? this.encryptedText,
    senderId: senderId ?? this.senderId,
    timestamp: timestamp ?? this.timestamp,
    iv: iv ?? this.iv,
  );

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      ChatMessageModel(
        id: json["id"],
        encryptedText: json["encryptedText"],
        senderId: json["senderId"],
        timestamp:
            json["timestamp"] != null
                ? (json["timestamp"] as Timestamp).toDate()
                : DateTime.now(),
        iv: json["iv"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "encryptedText": encryptedText,
    "senderId": senderId,
    "timestamp": timestamp,
    "iv": iv,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessageModel &&
          runtimeType == other.runtimeType &&
          encryptedText == other.encryptedText &&
          senderId == other.senderId &&
          timestamp == other.timestamp &&
          iv == other.iv &&
          id == other.id;

  @override
  int get hashCode =>
      encryptedText.hashCode ^
      senderId.hashCode ^
      timestamp.hashCode ^
      iv.hashCode ^
      id.hashCode;

  @override
  String toString() {
    return 'ChatMessageModel{id: $id, encryptedText: $encryptedText, senderId: $senderId, timestamp: $timestamp, iv: $iv}';
  }
}
