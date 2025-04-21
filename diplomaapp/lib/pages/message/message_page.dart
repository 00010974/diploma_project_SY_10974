// import 'package:flutter/material.dart';
// import 'package:diplomaapp/pages/widgets/sidebar.dart';
// import 'package:diplomaapp/pages/widgets/topbar.dart';

// class MessagePage extends StatelessWidget {
//   const MessagePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9F9),
//       body: Row(
//         children: [
//           const Sidebar(selectedMenu: "Message"),
//           Expanded(
//             child: Column(
//               children: [
//                 const SizedBox(height: 24),
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 24),
//                   child: TopBar(pageTitle: "My Message"),
//                 ),
//                 const SizedBox(height: 24),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 24),
//                     child: Row(
//                       children: [
//                         // Список чатов слева
//                         Container(
//                           width: 320,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           child: Column(
//                             children: [
//                               _buildHeader(),
//                               _buildSearchBox(),
//                               Expanded(child: _buildChatList()),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 24),

//                         // Открытый чат справа
//                         Expanded(
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: Column(
//                               children: [
//                                 _buildChatHeader(),
//                                 Expanded(child: _buildChatMessages()),
//                                 _buildMessageInput(),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return const Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Text(
//         "All Messages",
//         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//       ),
//     );
//   }

//   Widget _buildSearchBox() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: TextField(
//         decoration: InputDecoration(
//           hintText: "Search message...",
//           prefixIcon: const Icon(Icons.search),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
//         ),
//       ),
//     );
//   }

//   Widget _buildChatList() {
//     return ListView(
//       padding: const EdgeInsets.all(8),
//       children: [
//         _chatTile("Envato Mastery", "Karen is typing...", "05:01 PM", isActive: true),
//         _chatTile("Mastering Git", "You: Thanks everyone!", "04:35 PM"),
//         _chatTile("Ms. Nina", "Okay, I already understand...", "05:01 PM"),
//         _chatTile("Marteen Gowl", "Thanks bro!", "Yesterday"),
//         _chatTile("Puke Tresse", "Summary Evaluation.pdf", "Yesterday"),
//         _chatTile("Britney Wale", "I know right!", "19/11/2023"),
//         _chatTile("Jeffery Junior", "Hello there", "15/11/2023"),
//       ],
//     );
//   }

//   Widget _chatTile(String name, String lastMessage, String time, {bool isActive = false}) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: isActive ? const Color(0xFFE7E6FB) : Colors.white,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           const CircleAvatar(radius: 20, backgroundColor: Colors.grey),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 4),
//                 Text(
//                   lastMessage,
//                   style: const TextStyle(color: Colors.grey, fontSize: 12),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 8),
//           Text(
//             time,
//             style: const TextStyle(fontSize: 10, color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildChatHeader() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         children: [
//           const CircleAvatar(radius: 20, backgroundColor: Colors.green),
//           const SizedBox(width: 12),
//           const Text("Envato Mastery", style: TextStyle(fontWeight: FontWeight.bold)),
//           const Spacer(),
//           IconButton(icon: const Icon(Icons.call), onPressed: () {}),
//           IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
//           IconButton(icon: const Icon(Icons.info_outline), onPressed: () {}),
//         ],
//       ),
//     );
//   }

//   Widget _buildChatMessages() {
//     return ListView(
//       padding: const EdgeInsets.all(16),
//       children: [
//         _messageBubble("Hey guys! 👋 Just joined.", false),
//         _messageBubble("Welcome! Happy to have you here.", true),
//         _messageBubble("Thanks! Excited for the project!", false),
//       ],
//     );
//   }

//   Widget _messageBubble(String text, bool isMe) {
//     return Align(
//       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 4),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         decoration: BoxDecoration(
//           color: isMe ? const Color(0xFF6A5AE0) : const Color(0xFFE7E6FB),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             color: isMe ? Colors.white : Colors.black87,
//             fontSize: 14,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMessageInput() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: "Type a message...",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF6A5AE0),
//               shape: const CircleBorder(),
//               padding: const EdgeInsets.all(16),
//             ),
//             child: const Icon(Icons.send, size: 20),
//           ),
//         ],
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplomaapp/services/firebase_service.dart';
import '../message/chat_page.dart';

class MessagePage extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firebaseService.getTeachersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text('Error loading teachers.'));
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());

          final teachers = snapshot.data!.docs;

          return ListView.builder(
            itemCount: teachers.length,
            itemBuilder: (context, index) {
              final teacher = teachers[index];
              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(teacher['name']),
                onTap: () {
                  final chatId = _firebaseService.getChatId(_firebaseService.currentUser!.uid, teacher.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatPage(
                        chatId: chatId,
                        receiverName: teacher['name'],
                        receiverId: teacher.id,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
