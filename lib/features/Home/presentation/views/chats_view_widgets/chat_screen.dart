import 'package:flutter/material.dart';
import 'package:nafsia_app/constant.dart';
import 'package:nafsia_app/core/helper_functions/get_user_data.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ChatScreen extends StatelessWidget {
  final String chatID;

  const ChatScreen({required this.chatID, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZIMKitMessageListPage(
        conversationID: chatID,
        appBarActions: [
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CallScreen(
                    callID: chatID,
                    isVideoCall: true,
                    targetUserName: chatID, // You might use real name
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CallScreen(
                    callID: chatID,
                    isVideoCall: false,
                    targetUserName: chatID,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CallScreen extends StatelessWidget {
  final String callID;
  final bool isVideoCall;
  final String targetUserName;

  const CallScreen({
    required this.callID,
    required this.isVideoCall,
    required this.targetUserName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = getUserData().data!.user;

    return Scaffold(
      body: ZegoUIKitPrebuiltCall(
        appID: zegoAppid,
        appSign: zegoAppSign,
        userID: user!.id!,
        userName: user.name!,
        callID: callID,
        config: isVideoCall
            ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
            : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
      ),
    );
  }
}
