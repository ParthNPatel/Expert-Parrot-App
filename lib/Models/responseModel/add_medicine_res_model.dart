// To parse this JSON data, do
//
//     final addMedicineResponseModel = addMedicineResponseModelFromJson(jsonString);

import 'dart:convert';

AddMedicineResponseModel addMedicineResponseModelFromJson(String str) =>
    AddMedicineResponseModel.fromJson(json.decode(str));

String addMedicineResponseModelToJson(AddMedicineResponseModel data) =>
    json.encode(data.toJson());

class AddMedicineResponseModel {
  AddMedicineResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory AddMedicineResponseModel.fromJson(Map<String, dynamic> json) =>
      AddMedicineResponseModel(
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
    this.name,
    this.strength,
    this.days,
    this.appearance,
    this.frequency,
    this.totalTimes,
    this.shceduleTime,
    this.utcShceduleTime,
    this.userId,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  String? name;
  int? strength;
  int? days;
  String? appearance;
  String? frequency;
  int? totalTimes;
  List<String>? shceduleTime;
  List<String>? utcShceduleTime;
  String? userId;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        strength: json["strength"],
        days: json["days"],
        appearance: json["appearance"],
        frequency: json["frequency"],
        totalTimes: json["totalTimes"],
        shceduleTime: List<String>.from(json["shceduleTime"].map((x) => x)),
        utcShceduleTime:
            List<String>.from(json["utcShceduleTime"].map((x) => x)),
        userId: json["userId"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "strength": strength,
        "days": days,
        "appearance": appearance,
        "frequency": frequency,
        "totalTimes": totalTimes,
        "shceduleTime": List<dynamic>.from(shceduleTime!.map((x) => x)),
        "utcShceduleTime": List<dynamic>.from(utcShceduleTime!.map((x) => x)),
        "userId": userId,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
