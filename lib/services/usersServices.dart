import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../model/usersModel.dart';

class UserServices {
  static Future<List<UserModel>> allUsers(int id) async {
    try {
      List<UserModel> getList = [];
      final String url =
          'https://localhost:44313/api/Users/isUsers/${id.toString()}';

      var response = await http.get(Uri.parse(url));
      var list = (jsonDecode(response.body) as List)
          .map((e) => UserModel.fromJson(e))
          .toList();

      return list;
    } catch (e) {
      return [];
    }
  }

  static Future<List<UserModel>> loginUsers(int id) async {
    final String url =
        "https://localhost:44313/api/Users/isMesaj/${id.toString()}";

    try {
      var response = await http.get(Uri.parse(url));
      var list = (jsonDecode(response.body) as List)
          .map((e) => UserModel.fromJson(e))
          .toList();
      return list;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
