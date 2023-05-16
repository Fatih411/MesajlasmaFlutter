import 'dart:convert';

import 'package:flutter_haberlesme/model/message.dart';
import 'package:http/http.dart' as http;

class MessageServices {
  static Future<dynamic> getMessage(int pushId, int getId) async {
    try {
      final String url =
          'https://localhost:44313/api/Message/getMessage?pushId=${pushId}&getId=${getId}';
      var response = await http.get(Uri.parse(url));
      var decode = jsonDecode(response.body);
      var list = (decode as List).map((e) => MessageModel.fromJson(e)).toList();
      return list;
    } catch (e) {
      return e.toString();
    }
  }

  static void addMessage(int pushId, int getId, String icerik) async {
    try {
      var url = "https://localhost:44313/api/Message/addMessage";
      var response = await http.post(Uri.parse(url), body: {
        "mesajiAtanId": pushId.toString(),
        "mesajiAlanId": getId.toString(),
        "mesajIcerik": icerik,
      });
    } catch (e) {
      e.toString();
    }
  }
}
