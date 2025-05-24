import 'package:chat_app/widget/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: false)
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('An error occurred!'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No messages yet!'));
        }
        final chatDocs = snapshot.data!.docs;
        return ListView.builder(
          itemBuilder: (context, index) {
            final chat = chatDocs[index];
            final currentMessageUserId = chat['userId'];
            final prevMessageUserId =
                index > 0 ? chatDocs[index - 1]['userId'] : null;
            final isSameUser = currentMessageUserId == prevMessageUserId;

            if (isSameUser) {
              return MessageBubble.next(
                message: chat['text'],
                isMe:
                    currentMessageUserId ==
                    FirebaseAuth.instance.currentUser!.uid,
              );
            }
            return MessageBubble.first(
              userImage: chat['userImage'],
              username: chat['username'],
              message: chat['text'],
              isMe:
                  currentMessageUserId ==
                  FirebaseAuth.instance.currentUser!.uid,
            );
          },
          itemCount: chatDocs.length,
        );
      },
    );
  }
}
