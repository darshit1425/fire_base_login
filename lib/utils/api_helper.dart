import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  Future<String> postApiCall(String subtitle, String title) async {
    String? apiLink = "https://fcm.googleapis.com/fcm/send";
    Uri uri = Uri.parse(apiLink);
    final body = {
      "to":
          "cj_duMQSQUiefCQIULDbut:APA91bESDIrVXmXJw5fVrCSEAILAyYJwOCbaez-OmkoZLeLqjPW5ZfcDyDThOf1czXL5YDLtI2w9dfqoTnBc7Co8kgSX9JZAs-3MhXzB6M7TLOONXz0oCZSzL9vRP31hE3pBWnldD9nW",
      "notification": {
        "body": subtitle,
        "title": title,
      }
    };
    var response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader:
            'key=AAAAhuwtkx4:APA91bGux2KtY7TVtY7bKpi7wsViWI-4Fej1EKNWq3dQFXYwM66Ny5HynruEQBr-m1hgPYy4O3R7ngZxUefAEibf4_ncemtN88jpJn_Obgv0Bc2wpS91Ld1u5Rdr2YWmv87oGUvmYjhU'
      },
    );
    if (response.statusCode == 200) {
      return "message send";
    }
    return "message not ";
  }
}
