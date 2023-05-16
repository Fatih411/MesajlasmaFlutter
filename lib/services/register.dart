import 'package:flutter_haberlesme/model/usersModel';
import 'package:http/http.dart' as http;

class RegisterServices {
  static void registerUser(UserModel userModel) async {
    final String url = "https://localhost:44373/api/kullanici/kayitOl";
    var response = await http.post(Uri.parse(url), body: {
      "isim": userModel.isim.toString(),
      "soyad": userModel.soyad.toString(),
      "mail": userModel.mail.toString(),
      "sifre": userModel.sifre.toString(),
    });
  }
}
