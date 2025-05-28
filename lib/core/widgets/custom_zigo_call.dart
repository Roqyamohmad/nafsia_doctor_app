import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ZegoSendCallInvitationButton(
      isVideoCall: true,
      //You need to use the resourceID that you created in the subsequent steps.
      //Please continue reading this document.
      resourceID: "zegouikit_call",
      invitees: [
        ZegoUIKitUser(
          id: '12345',
          name: 'shady',
        ),
      ],
    );
  }
}
