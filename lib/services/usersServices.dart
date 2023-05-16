import 'dart:convert';
import 'package:flutter/material.dart';

import '../model/usersModel' show UserModel;
import 'package:http/http.dart' as http;

class UserServices {
  static Future<List<UserModel>> allUsers(int id) async {
    try {
      List<UserModel> getList = [];
      final String url =
          'https://localhost:44373/api/kullanici/kendinHaricList/${id.toString()}';

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
        "https://localhost:44373/api/kullanici/mesajiVarmi?kid=${id.toString()}";

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
