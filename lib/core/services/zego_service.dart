import 'package:nafsia_app/constant.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

const int appID = zegoAppid; // Replace with your actual AppID
const String appSign = zegoAppSign; // Replace with your actual AppSign

initializeZego(String userID, String userName) async {
  print('🚀 Starting Zego Initialization');

  try {
    print('🟠 Initializing ZIMKit...');
    await ZIMKit().init(appID: appID, appSign: appSign);
    print('✅ ZIMKit initialized');

    print('🟢 Connecting ZIMKit user...');
    await ZIMKit().connectUser(id: userID, name: userName);
    print('✅ ZIMKit user connected');

    print('🔵 Initializing Call Invitation Service...');
    await ZegoUIKitPrebuiltCallInvitationService().init(
      appID: appID,
      appSign: appSign,
      userID: userID,
      userName: userName,
      plugins: [ZegoUIKitSignalingPlugin()],
    );
    print('✅ Call Invitation Service initialized');
  } catch (e, stacktrace) {
    print('❌ Zego Initialization Failed: $e');
    print(stacktrace);
  }
}
