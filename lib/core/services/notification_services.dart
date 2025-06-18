import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nafsia_app/core/utils/constants.dart';
//import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationService {
  String url = 'https://api.onesignal.com/notifications';
  static const String oneSignalAppId = kOneSignalAppId;
  static const String oneSignalRestApiKey =
      "os_v2_app_ravfrq2ty5aozezpjwmh5yh6y6yyyiuyauzupl5fovezdflxup2nj4tf5z7imo2agkcuqebfyu22uljnt3zgct5ydjieepighj7urga";

  Future<void> sendNotification(
      {required String pushId,
      required String title,
      required String body}) async {
    try {
      var response = await http.post(
          Uri.parse(
            url,
          ),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Basic $oneSignalRestApiKey'
          },
          body: jsonEncode({
            "app_id": oneSignalAppId,
            "contents": {"en": body},
            "include_player_ids": [pushId],
            "headings": {"en": title},
          }));

      if (response.statusCode == 200) {
        print("notification sent ");
      } else {}
    } on Exception catch (e) {
      print("notification failed $e");
    }
  }
}
