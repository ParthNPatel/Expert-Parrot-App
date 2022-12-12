// To parse this JSON data, do
//
//     final getHeartRateResponseModel = getHeartRateResponseModelFromJson(jsonString);

import 'dart:convert';

GetHeartRateResponseModel getHeartRateResponseModelFromJson(String str) =>
    GetHeartRateResponseModel.fromJson(json.decode(str));

String getHeartRateResponseModelToJson(GetHeartRateResponseModel data) =>
    json.encode(data.toJson());

class GetHeartRateResponseModel {
  GetHeartRateResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory GetHeartRateResponseModel.fromJson(Map<String, dynamic> json) =>
      GetHeartRateResponseModel(
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
    this.userId,
    this.createdAt,
    this.date,
    this.rate,
    this.updatedAt,
  });

  String? id;
  String? userId;
  DateTime? createdAt;
  DateTime? date;
  int? rate;
  DateTime? updatedAt;

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        id: json["_id"],
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        date: DateTime.parse(json["date"]),
        rate: json["rate"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "createdAt": createdAt!.toIso8601String(),
        "date": date!.toIso8601String(),
        "rate": rate,
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
