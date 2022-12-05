// To parse this JSON data, do
//
//     final getReminderResponseModel = getReminderResponseModelFromJson(jsonString);

import 'dart:convert';

GetReminderResponseModel getReminderResponseModelFromJson(String str) =>
    GetReminderResponseModel.fromJson(json.decode(str));

String getReminderResponseModelToJson(GetReminderResponseModel data) =>
    json.encode(data.toJson());

class GetReminderResponseModel {
  GetReminderResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory GetReminderResponseModel.fromJson(Map<String, dynamic> json) =>
      GetReminderResponseModel(
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
    this.title,
    this.userId,
    this.date,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? title;
  String? userId;
  DateTime? date;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        id: json["_id"],
        title: json["title"],
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "userId": userId,
        "date": date!.toIso8601String(),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
