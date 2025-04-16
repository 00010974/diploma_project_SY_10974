import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_message.dart';

class ChatService {
  CollectionReference<Map<String, dynamic>> getChatRef(String courseId) {
    return FirebaseFirestore.instance.collection('courses').doc(courseId).collection('chat');
  }

  Stream<List<ChatMessage>> getMessages(String courseId) {
    return getChatRef(courseId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => ChatMessage.fromMap(doc.id, doc.data())).toList());
  }

  Future<void> sendMessage(String courseId, ChatMessage message) async {
    await getChatRef(courseId).add(message.toMap());
  }
}
