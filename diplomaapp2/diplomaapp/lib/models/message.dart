//   import 'package:cloud_firestore/cloud_firestore.dart';

// class ChatMessage {
//   final String id;
//   final String senderId;
//   final String senderName;
//   final String text;
//   final DateTime timestamp;


//   ChatMessage({
//     required this.id,
//     required this.senderId,
//     required this.senderName,
//     required this.text,
//     required this.timestamp,
//   });

//   factory ChatMessage.fromMap(String id, Map<String, dynamic> data) => ChatMessage(
//         id: id,
//         senderId: data['senderId'],
//         senderName: data['senderName'],
//         text: data['text'],
//         timestamp: (data['timestamp'] as Timestamp).toDate(),
//       );

//   Map<String, dynamic> toMap() => {
//         'senderId': senderId,
//         'senderName': senderName,
//         'text': text,
//         'timestamp': timestamp,
//       };
// }



import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String text;
  final DateTime timestamp;

  Message({
    required this.senderId,
    required this.text,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  static Message fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'],
      text: map['text'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }
}
