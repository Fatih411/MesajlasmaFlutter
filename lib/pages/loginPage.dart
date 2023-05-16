import 'package:flutter/material.dart';
import 'package:flutter_haberlesme/contants/contants.dart';
import 'package:flutter_haberlesme/model/usersModel';
import 'package:flutter_haberlesme/services/register.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../services/loginAndregisterServices.dart';

class LoginPage extends StatelessWidget {
  final String title;
  LoginPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
  late bool obscureText;
  late List<UserModel> list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: Contants.titletTextStyle(),
        ),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context1) {
    return ScreenUtilInit(
      builder: (context, child) {
        return Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 40.h),
                child: _textFormField("Kullanici Adi", _name, false),
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 40.h),
                  child: _textFormField("Sifre", _password, true)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        final TextEditingController _nameRegister =
                            TextEditingController();
                        final TextEditingController _surnameRegister =
                            TextEditingController();
                        final TextEditingController _mailRegister =
                            TextEditingController();
                        final TextEditingController _passwordRegister =
                            TextEditingController();
                        return AlertDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                  RegisterServices.registerUser(UserModel(
                                      isim: _nameRegister.text,
                                      soyad: _surnameRegister.text,
                                      mail: _mailRegister.text,
                                      sifre: _passwordRegister.text));
                                  Navigator.pop(context);
                                },
                                child: Text("Tamam")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("İptal"))
                          ],
                          title: Column(children: [
                            _textFormField("İsim", _nameRegister, false),
                            _textFormField("Soyisim", _surnameRegister, false),
                            _textFormField("Mail", _mailRegister, false),
                            _textFormField("Sifre", _passwordRegister, true),
                          ]),
                        );
                      },
                    );
                  },
                  child: Text("KayitOl"),
                ),
              ),
              Container(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    LoginAndRegisterServices.login(
                        _name.text, _password.text, context1);
                    _name.text = "";
                    _password.text = "";
                  },
                  child: const Text("Giris Yap"),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

_textFormField(
    String text, TextEditingController controller, bool obscureText) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          )),
    ),
  );
}
