// To parse this JSON data, do
//
//     final getCommentResponseModel = getCommentResponseModelFromJson(jsonString);

import 'dart:convert';

GetCommentResponseModel getCommentResponseModelFromJson(String str) =>
    GetCommentResponseModel.fromJson(json.decode(str));

String getCommentResponseModelToJson(GetCommentResponseModel data) =>
    json.encode(data.toJson());

class GetCommentResponseModel {
  GetCommentResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  List<Datum>? data;

  factory GetCommentResponseModel.fromJson(Map<String, dynamic> json) =>
      GetCommentResponseModel(
        flag: json["flag"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.text,
    this.userId,
    this.postId,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? text;
  UserId? userId;
  String? postId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        text: json["text"],
        userId: UserId.fromJson(json["userId"]),
        postId: json["postId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "text": text,
        "userId": userId!.toJson(),
        "postId": postId,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}

class UserId {
  UserId({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
