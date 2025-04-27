// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/chat_message.dart';

// class ChatService {
//   CollectionReference<Map<String, dynamic>> getChatRef(String courseId) {
//     return FirebaseFirestore.instance.collection('courses').doc(courseId).collection('chat');
//   }

//   Stream<List<Message>> getMessages(String courseId) {
//     return getChatRef(courseId)
//         .orderBy('timestamp', descending: true)
//         .snapshots()
//         .map((snap) =>
//             snap.docs.map((doc) => Message.fromMap(doc.id, doc.data())).toList());
//   }

//   Future<void> sendMessage(String courseId, Message message) async {
//     await getChatRef(courseId).add(message.toMap());
//   }
// }




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/message.dart';


class ChatService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getTeachers() {
    return _db.collection('users')
      .where('role', isEqualTo: 'teacher')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<String> createChatIfNotExists(String teacherId) async {
    final currentUser = _auth.currentUser!;
    final snapshot = await _db.collection('chats')
      .where('userIds', arrayContains: currentUser.uid)
      .get();

    for (var doc in snapshot.docs) {
      final userIds = List<String>.from(doc['userIds']);
      if (userIds.contains(teacherId)) return doc.id;
    }

    final newChat = await _db.collection('chats').add({
      'userIds': [currentUser.uid, teacherId],
      'lastMessage': '',
      'lastTimestamp': FieldValue.serverTimestamp(),
    });
    return newChat.id;
  }

  Stream<List<Map<String, dynamic>>> getMessages(String chatId) {
    return _db.collection('chats').doc(chatId).collection('messages')
      .orderBy('timestamp')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<void> sendMessage(String chatId, String text) async {
    final user = _auth.currentUser!;
    await _db.collection('chats').doc(chatId).collection('messages').add({
      'senderId': user.uid,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    await _db.collection('chats').doc(chatId).update({
      'lastMessage': text,
      'lastTimestamp': FieldValue.serverTimestamp(),
    });
  }
}


// class ChatService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Stream<List<Message>> getMessages(String chatId) {
//     return _db.collection('chats')
//       .doc(chatId)
//       .collection('messages')
//       .orderBy('timestamp')
//       .snapshots()
//       .map((snapshot) => snapshot.docs.map((doc) => Message.fromMap(doc.data())).toList());
//   }

//   Future<void> sendMessage(String chatId, String text) async {
//     final user = _auth.currentUser;
//     if (user == null) return;

//     final message = Message(
//       senderId: user.uid,
//       text: text,
//       timestamp: DateTime.now(),
//     );

//     await _db.collection('chats')
//       .doc(chatId)
//       .collection('messages')
//       .add(message.toMap());

//     await _db.collection('chats').doc(chatId).set({
//       'lastMessage': text,
//       'lastUpdated': DateTime.now(),
//       'participants': FieldValue.arrayUnion([user.uid]),
//     }, SetOptions(merge: true));
//   }
// }
