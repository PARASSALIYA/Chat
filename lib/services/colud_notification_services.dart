import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class Notifications {
  Notifications._();
  static Notifications notifications = Notifications._();

  Future<void> permission() async {
    PermissionStatus permissionStatus = await Permission.notification.request();
    if (permissionStatus.isDenied) {
      await permission();
    }
  }

  Future<String> getAccessToken() async {
    String path = "assets/json/chat.json";

    String json = await rootBundle.loadString(path);

    var accountCredential = ServiceAccountCredentials.fromJson(json);

    List<String> scopes = [
      "https://www.googleapis.com/auth/firebase.messaging"
    ];
    var accessToken = await clientViaServiceAccount(accountCredential, scopes);

    return accessToken.credentials.accessToken.data;
  }

  Future<void> sendNotification({
    required String title,
    required String body,
    required String token,
  }) async {
    String accessToken = await getAccessToken();

    Map<String, dynamic> myBody = {
      'message': {
        'token': token,
        'notification': {
          'title': title,
          'body': body,
        },
        'data': {
          'age': '22',
          'school': 'PQR',
        }
      },
    };
    http.Response response = await http.post(
      Uri.parse(
          "https://fcm.googleapis.com/v1/projects/chat-app-7fde3/messages:send"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
      body: jsonEncode(myBody),
    );
    log("Status Code : ${response.statusCode}");
    if (response.statusCode == 200) {
      log("================================");
      log("Notification Successfully.....");
      log("================================");
    } else {
      log("================= Error: ${response.body} ==================");
    }
  }
}
