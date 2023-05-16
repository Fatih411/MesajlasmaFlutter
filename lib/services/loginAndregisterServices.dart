import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_haberlesme/pages/iUsers.dart';
import 'package:http/http.dart' as http;

import '../model/usersModel.dart';

class LoginAndRegisterServices {
  static Future<dynamic> login(
      String? name, String? password, BuildContext context) async {
    try {
      final String url =
          "https://localhost:44313/api/Users/login?name=${name}&password=${password}";

      final response = await http.get(Uri.parse(url));
      final list = (jsonDecode(response.body) as List)
          .map((e) => UserModel.fromJson(e))
          .toList();
      if (list.isNotEmpty) {
        return Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Users(title: "Kişilerim", getId: list[0].id!),
            ));
      } else {
        return "Yanlış";
      }
    } catch (e) {
      return e.toString();
    }
  }
}
