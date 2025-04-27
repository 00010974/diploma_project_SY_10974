// import 'package:flutter/material.dart';

// class LocalChatPage extends StatefulWidget {
//   final String teacherName;

//   const LocalChatPage({super.key, required this.teacherName});

//   @override
//   State<LocalChatPage> createState() => _LocalChatPageState();
// }

// class _LocalChatPageState extends State<LocalChatPage> {
//   final TextEditingController _messageController = TextEditingController();

//   final List<Map<String, dynamic>> _messages = [];

//   void _sendMessage() {
//     final text = _messageController.text.trim();
//     if (text.isEmpty) return;

//     setState(() {
//       _messages.insert(0, {
//         'text': text,
//         'isMe': true,
//         'timestamp': DateTime.now(),
//       });
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
//             child: ListView.builder(
//               reverse: true,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final msg = _messages[index];
//                 final isMe = msg['isMe'];

//                 return Align(
//                   alignment:
//                       isMe ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(vertical: 6),
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color:
//                           isMe ? const Color(0xFF6A5AE0) : Colors.grey.shade300,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       msg['text'],
//                       style: TextStyle(
//                         color: isMe ? Colors.white : Colors.black87,
//                       ),
//                     ),
//                   ),
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
//       padding: const EdgeInsets.symmetric(horizontal: 12),
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
