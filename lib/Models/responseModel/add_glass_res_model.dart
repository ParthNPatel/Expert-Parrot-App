// To parse this JSON data, do
//
//     final addGlassResponseModel = addGlassResponseModelFromJson(jsonString);

import 'dart:convert';

AddGlassResponseModel addGlassResponseModelFromJson(String str) =>
    AddGlassResponseModel.fromJson(json.decode(str));

String addGlassResponseModelToJson(AddGlassResponseModel data) =>
    json.encode(data.toJson());

class AddGlassResponseModel {
  AddGlassResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory AddGlassResponseModel.fromJson(Map<String, dynamic> json) =>
      AddGlassResponseModel(
        flag: json["flag"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.userId,
    this.createdAt,
    this.data,
    this.date,
    this.updatedAt,
  });

  String? id;
  String? userId;
  DateTime? createdAt;
  List<Datum>? data;
  DateTime? date;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        date: DateTime.parse(json["date"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "createdAt": createdAt!.toIso8601String(),
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "date": date!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}

class Datum {
  Datum({
    this.type,
    this.quantity,
    this.id,
  });

  String? type;
  int? quantity;
  String? id;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        type: json["type"],
        quantity: json["quantity"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "quantity": quantity,
        "_id": id,
      };
}
