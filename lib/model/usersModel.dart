import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    int? id;
    String? isim;
    String? soyad;
    String? mail;
    String? sifre;
    String? yetki;

    UserModel({
        this.id,
        this.isim,
        this.soyad,
        this.mail,
        this.sifre,
        this.yetki,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        isim: json["isim"],
        soyad: json["soyad"],
        mail: json["mail"],
        sifre: json["sifre"],
        yetki: json["yetki"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "isim": isim,
        "soyad": soyad,
        "mail": mail,
        "sifre": sifre,
        "yetki": yetki,
    };
}
