// To parse this JSON data, do
//
//     final recordMedicineResponseModel = recordMedicineResponseModelFromJson(jsonString);

import 'dart:convert';

RecordMedicineResponseModel recordMedicineResponseModelFromJson(String str) =>
    RecordMedicineResponseModel.fromJson(json.decode(str));

String recordMedicineResponseModelToJson(RecordMedicineResponseModel data) =>
    json.encode(data.toJson());

class RecordMedicineResponseModel {
  RecordMedicineResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory RecordMedicineResponseModel.fromJson(Map<String, dynamic> json) =>
      RecordMedicineResponseModel(
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
    this.medicineId,
    this.createdAt,
    this.date,
    this.doses,
    this.updatedAt,
  });

  String? id;
  String? medicineId;
  DateTime? createdAt;
  DateTime? date;
  List<int>? doses;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        medicineId: json["medicineId"],
        createdAt: DateTime.parse(json["createdAt"]),
        date: DateTime.parse(json["date"]),
        doses: List<int>.from(json["doses"].map((x) => x)),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "medicineId": medicineId,
        "createdAt": createdAt!.toIso8601String(),
        "date": date!.toIso8601String(),
        "doses": List<dynamic>.from(doses!.map((x) => x)),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
