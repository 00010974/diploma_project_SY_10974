// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class ChatScreen extends StatefulWidget {
//   final String chatId;
//   final String teacherName;

//   const ChatScreen({super.key, required this.chatId, required this.teacherName});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final user = FirebaseAuth.instance.currentUser;

//   void _sendMessage() async {
//     if (_messageController.text.trim().isEmpty) return;

//     await FirebaseFirestore.instance.collection('chats').add({
//       'senderId': user!.uid,
//       'receiverId': widget.chatId,
//       'text': _messageController.text.trim(),
//       'timestamp': FieldValue.serverTimestamp(),
//     });

//     _messageController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.teacherName),
//         backgroundColor: const Color(0xFF6A5AE0),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('chats')
//                   .orderBy('timestamp', descending: true)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

//                 var messages = snapshot.data!.docs.where((doc) =>
//                     (doc['senderId'] == user!.uid && doc['receiverId'] == widget.chatId) ||
//                     (doc['senderId'] == widget.chatId && doc['receiverId'] == user!.uid)).toList();

//                 return ListView.builder(
//                   reverse: true,
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     var msg = messages[index];
//                     bool isMe = msg['senderId'] == user!.uid;

//                     return Align(
//                       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: isMe ? const Color(0xFF6A5AE0) : Colors.grey.shade200,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(
//                           msg['text'],
//                           style: TextStyle(
//                             color: isMe ? Colors.white : Colors.black87,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           _buildInputArea(),
//         ],
//       ),
//     );
//   }

//   Widget _buildInputArea() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       color: Colors.grey[100],
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _messageController,
//               decoration: const InputDecoration(
//                 hintText: "Write a message...",
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.send, color: Color(0xFF6A5AE0)),
//             onPressed: _sendMessage,
//           ),
//         ],
//       ),
//     );
//   }
// }
