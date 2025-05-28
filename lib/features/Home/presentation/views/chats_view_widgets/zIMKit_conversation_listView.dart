import 'package:flutter/material.dart';
import 'package:nafsia_app/features/Home/presentation/views/chats_view_widgets/chat_screen.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:zego_zimkit/zego_zimkit.dart';

import 'empty_chats_list.dart';

class ZimkitConversationListview extends StatelessWidget {
  const ZimkitConversationListview({super.key});

  @override
  Widget build(BuildContext context) {
    return ZIMKitConversationListView(
      lastMessageTimeBuilder: (context, messageTime, defaultWidget) => Text(
        timeago.format(messageTime!, locale: 'ar'),
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
      emptyBuilder: (context, defaultWidget) => const Center(
        child: EmptyChatsList(),
      ),
      onPressed: (context, conversation, defaultAction) =>
          Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            //targetUserID: conversation.id,
            //targetUserName: conversation.name,
            chatID: conversation.id,
          ),
        ),
      ),
    );
  }
}
