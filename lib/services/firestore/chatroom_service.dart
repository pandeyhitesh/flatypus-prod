import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_log/color_log.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flatypus/models/chat_message_model.dart';
import 'package:flatypus/screens/chatroom/widgets/show_message_list.dart';
import 'package:flatypus/services/firestore/collentions.dart';

class ChatRoomService {
  final _collection = FSCollections.chatRoom;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Encryption setup (use a secure key in production, possibly from a backend)
  final _key = encrypt.Key.fromUtf8('16CharKey1234567'); // 16, 24, or 32 chars

  Map<String, String> _encryptMessage(String text) {
    final iv = encrypt.IV.fromSecureRandom(16); // Random IV per message
    final encryptor = encrypt.Encrypter(encrypt.AES(_key));
    // return encryptor.encrypt(text, iv: iv).base64;
    return {
      'encryptedText': encryptor.encrypt(text, iv: iv).base64,
      'iv': iv.base64,
    };
  }

  String decryptMessage(String encryptedText, String ivBase64) {
    try {
      final iv = encrypt.IV.fromBase64(ivBase64); // Use the IV from the message
      final encryptor = encrypt.Encrypter(encrypt.AES(_key));
      return encryptor.decrypt64(encryptedText, iv: iv);
    } catch (e) {
      clog.error('Error: Failed to decrypt message, error: $e');
      return '';
    }
  }

  Future<void> sendMessage({
    required String messageText,
    required String? houseId,
  }) async {
    if (messageText.isEmpty) return;

    Map<String, String> encryptedMessage = _encryptMessage(messageText);
    String? encryptedText = encryptedMessage['encryptedText'];
    String? iv = encryptedMessage['iv'];
    String userId = _auth.currentUser!.uid;

    await _firestore
        .collection('houses')
        .doc(houseId)
        .collection(_collection)
        .add({
          'id': _firestore.collection(_collection).doc().id,
          'encryptedText': encryptedText,
          'senderId': userId,
          'timestamp': FieldValue.serverTimestamp(),
          'iv': iv, // Store IV with message
          'expireOn': Timestamp.fromDate(DateTime.now().add(Duration(days: 5))),
        });
  }

  Stream<MessagesWithLastDocument> getMessages({
    required String houseId,
    DocumentSnapshot? lastDocument,
    bool initialLoad = false,
  }) {
    try {
      var query = _firestore
          .collection('houses')
          .doc(houseId)
          .collection(_collection)
          .orderBy('timestamp', descending: true);

      if (lastDocument != null && !initialLoad) {
        query = query.startAfterDocument(lastDocument).limit(100);
      } else {
        query = query.limit(50); // Initial load
      }

      final messageStream = query.snapshots();

      // Convert Stream<QuerySnapshot> to Stream<List<ChatMessageModel>>
      return messageStream.map((QuerySnapshot<Map<String, dynamic>> snapshot) {
        final messages =
            snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              // Convert each document to a ChatMessageModel
              return ChatMessageModel.fromJson(data);
            }).toList();
        if (messages.isNotEmpty) {
          clog.warning(
            'Last Document from ChatRoomService = ${decryptMessage(messages.last.encryptedText, messages.last.iv)}',
          );
        }
        clog.warning(
          'Document count from ChatRoomService = ${messages.length}',
        );
        return MessagesWithLastDocument(messages, snapshot.docs.isNotEmpty ? snapshot.docs.last : null, initialLoad);
      });
    } catch (e) {
      clog.error('Error: Failed to get messages, error: $e');
      // Return an empty stream
      return Stream.value(MessagesWithLastDocument([], null, initialLoad));
    }
  }
}
