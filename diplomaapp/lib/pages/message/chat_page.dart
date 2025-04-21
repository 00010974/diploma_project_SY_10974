import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplomaapp/services/firebase_service.dart';
import 'package:diplomaapp/pages/message/widgets/message_bubble.dart';

class ChatPage extends StatefulWidget {
  final String chatId;
  final String receiverName;
  final String receiverId;

  const ChatPage({super.key, required this.chatId, required this.receiverName, required this.receiverId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      _firebaseService.sendMessage(widget.chatId, _messageController.text.trim(), widget.receiverId);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverName),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firebaseService.getMessagesStream(widget.chatId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message['senderId'] == _firebaseService.currentUser!.uid;
                    return MessageBubble(
                      text: message['text'],
                      isMe: isMe,
                    );
                  },
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: "Write a message...",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: _sendMessage,
              icon: const Icon(Icons.send, color: Color(0xFF6A5AE0)),
            ),
          ],
        ),
      ),
    );
  }
}
