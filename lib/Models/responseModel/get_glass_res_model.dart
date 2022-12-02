// To parse this JSON data, do
//
//     final getGlassResponseModel = getGlassResponseModelFromJson(jsonString);

import 'dart:convert';

GetGlassResponseModel getGlassResponseModelFromJson(String str) =>
    GetGlassResponseModel.fromJson(json.decode(str));

String getGlassResponseModelToJson(GetGlassResponseModel data) =>
    json.encode(data.toJson());

class GetGlassResponseModel {
  GetGlassResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  List<GetGlassResponseModelDatum>? data;

  factory GetGlassResponseModel.fromJson(Map<String, dynamic> json) =>
      GetGlassResponseModel(
        flag: json["flag"],
        data: List<GetGlassResponseModelDatum>.from(
            json["data"].map((x) => GetGlassResponseModelDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetGlassResponseModelDatum {
  GetGlassResponseModelDatum({
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
  List<DatumDatum>? data;
  DateTime? date;
  DateTime? updatedAt;

  factory GetGlassResponseModelDatum.fromJson(Map<String, dynamic> json) =>
      GetGlassResponseModelDatum(
        id: json["_id"],
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        data: List<DatumDatum>.from(
            json["data"].map((x) => DatumDatum.fromJson(x))),
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

class DatumDatum {
  DatumDatum({
    this.type,
    this.quantity,
    this.id,
  });

  String? type;
  int? quantity;
  String? id;

  factory DatumDatum.fromJson(Map<String, dynamic> json) => DatumDatum(
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
