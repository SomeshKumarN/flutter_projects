import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    final message = _messageController.text;
    if (message.isEmpty) {
      return;
    }
    _messageController.clear();
    FocusScope.of(context).unfocus();
    final currentUser = FirebaseAuth.instance.currentUser!;
    final userData =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

    FirebaseFirestore.instance.collection('chat').add({
      'text': message,
      'createdAt': Timestamp.now(),
      'userId': currentUser.uid,
      'username': userData.data()!['username'],
      'email': userData.data()!['email'],
      'userImage': userData.data()!['image_url'],
    });
    print('Message sent: $message');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
      height: 70,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              autocorrect: true,
              decoration: const InputDecoration(labelText: 'Send a message...'),
              onSubmitted: (value) {
                // Handle message submission
              },
            ),
          ),
          IconButton(icon: const Icon(Icons.send), onPressed: _sendMessage),
        ],
      ),
    );
  }
}
