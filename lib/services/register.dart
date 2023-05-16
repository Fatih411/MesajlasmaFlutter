import 'package:http/http.dart' as http;

import '../model/usersModel.dart';

class RegisterServices {
  static void registerUser(UserModel userModel) async {
    final String url = "https://localhost:44313/api/Users/register";
    var response = await http.post(Uri.parse(url), body: {
      "isim": userModel.isim.toString(),
      "soyad": userModel.soyad.toString(),
      "mail": userModel.mail.toString(),
      "sifre": userModel.sifre.toString(),
    });
  }
}
