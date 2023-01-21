// To parse this JSON data, do
//
//     final getWeekRecordMedicineResponseModel = getWeekRecordMedicineResponseModelFromJson(jsonString);

import 'dart:convert';

GetWeekRecordMedicineResponseModel getWeekRecordMedicineResponseModelFromJson(
        String str) =>
    GetWeekRecordMedicineResponseModel.fromJson(json.decode(str));

String getWeekRecordMedicineResponseModelToJson(
        GetWeekRecordMedicineResponseModel data) =>
    json.encode(data.toJson());

class GetWeekRecordMedicineResponseModel {
  GetWeekRecordMedicineResponseModel({
    required this.flag,
    required this.data,
  });

  bool flag;
  List<Datum> data;

  factory GetWeekRecordMedicineResponseModel.fromJson(
          Map<String, dynamic> json) =>
      GetWeekRecordMedicineResponseModel(
        flag: json["flag"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.date,
    required this.records,
  });

  DateTime date;
  List<Record> records;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: DateTime.parse(json["date"]),
        records:
            List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
      };
}

class Record {
  Record({
    required this.id,
    required this.name,
    required this.strength,
    required this.days,
    required this.appearance,
    required this.frequency,
    required this.totalTimes,
    required this.shceduleTime,
    required this.utcShceduleTime,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.doses,
  });

  String id;
  String name;
  int strength;
  int days;
  String appearance;
  String frequency;
  int totalTimes;
  List<String> shceduleTime;
  List<String> utcShceduleTime;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  List<int> doses;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["_id"],
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
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        doses: List<int>.from(json["doses"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "strength": strength,
        "days": days,
        "appearance": appearance,
        "frequency": frequency,
        "totalTimes": totalTimes,
        "shceduleTime": List<dynamic>.from(shceduleTime.map((x) => x)),
        "utcShceduleTime": List<dynamic>.from(utcShceduleTime.map((x) => x)),
        "userId": userId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "doses": List<dynamic>.from(doses.map((x) => x)),
      };
}
