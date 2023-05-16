import 'dart:convert';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  int? mesajId;
  int? mesajiAtanId;
  int? mesajAlanId;
  String? mesajIcerik;
  DateTime? mesajTarih;

  MessageModel({
    this.mesajId,
    this.mesajiAtanId,
    this.mesajAlanId,
    this.mesajIcerik,
    this.mesajTarih,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        mesajId: json["mesajId"],
        mesajiAtanId: json["mesajiAtanId"],
        mesajAlanId: json["mesajiAlanId"],
        mesajIcerik: json["mesajIcerik"],
        mesajTarih: json["mesajTarih"] == null
            ? null
            : DateTime.parse(json["mesajTarih"]),
      );

  Map<String, dynamic> toJson() => {
        "mesajId": mesajId,
        "mesajiAtanId": mesajiAtanId,
        "mesajiAlanId": mesajAlanId,
        "mesajIcerik": mesajIcerik,
        "mesajTarih": mesajTarih?.toIso8601String(),
      };
}
