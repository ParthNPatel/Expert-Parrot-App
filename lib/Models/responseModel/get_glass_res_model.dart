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
        "data": data!.toJson(),
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
  String? limit;
  String? page;
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
    this.bottle,
    this.createdAt,
    this.date,
    this.glass,
    this.largeBottle,
    this.updatedAt,
  });

  String? id;
  String? userId;
  int? bottle;
  DateTime? createdAt;
  DateTime? date;
  int? glass;
  int? largeBottle;
  DateTime? updatedAt;

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        id: json["_id"],
        userId: json["userId"],
        bottle: json["bottle"],
        createdAt: DateTime.parse(json["createdAt"]),
        date: DateTime.parse(json["date"]),
        glass: json["glass"],
        largeBottle: json["large_bottle"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "bottle": bottle,
        "createdAt": createdAt!.toIso8601String(),
        "date": date!.toIso8601String(),
        "glass": glass,
        "large_bottle": largeBottle,
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
