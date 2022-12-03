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
  Data? data;

  factory GetGlassResponseModel.fromJson(Map<String, dynamic> json) =>
      GetGlassResponseModel(
        flag: json["flag"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "data": data!?.toJson(),
      };
}

class Data {
  Data({
    this.docs,
    this.total,
    this.limit,
    this.page,
    this.pages,
  });

  List<Doc>? docs;
  int? total;
  int? limit;
  int? page;
  int? pages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        docs: List<Doc>.from(json["docs"].map((x) => Doc.fromJson(x))),
        total: json["total"],
        limit: json["limit"],
        page: json["page"],
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "docs": List<dynamic>.from(docs!.map((x) => x.toJson())),
        "total": total,
        "limit": limit,
        "page": page,
        "pages": pages,
      };
}

class Doc {
  Doc({
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

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
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
