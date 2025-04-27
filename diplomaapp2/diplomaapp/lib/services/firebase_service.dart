import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Stream<QuerySnapshot> getTeachersStream() {
    return _firestore.collection('users').snapshots();
    // .where('role', isEqualTo: 'teacher').snapshots();
  }

  Stream<QuerySnapshot> getMessagesStream(String chatId) {
    return _firestore
        .collection('messages')
        .doc(chatId)
        .collection('chats')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> sendMessage(
    String chatId,
    String text,
    String receiverId,
  ) async {
    if (text.trim().isEmpty) return;

    await _firestore
        .collection('messages')
        .doc(chatId)
        .collection('chats')
        .add({
          'text': text,
          'senderId': currentUser!.uid,
          'receiverId': receiverId,
          'timestamp': FieldValue.serverTimestamp(),
        });
  }

  String getChatId(String userId1, String userId2) {
    return userId1.hashCode <= userId2.hashCode
        ? '$userId1\_$userId2'
        : '$userId2\_$userId1';
  }
}
