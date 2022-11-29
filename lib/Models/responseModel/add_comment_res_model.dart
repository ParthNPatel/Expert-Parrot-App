// To parse this JSON data, do
//
//     final addCommentResponseModel = addCommentResponseModelFromJson(jsonString);

import 'dart:convert';

AddCommentResponseModel addCommentResponseModelFromJson(String str) =>
    AddCommentResponseModel.fromJson(json.decode(str));

String addCommentResponseModelToJson(AddCommentResponseModel data) =>
    json.encode(data.toJson());

class AddCommentResponseModel {
  AddCommentResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory AddCommentResponseModel.fromJson(Map<String, dynamic> json) =>
      AddCommentResponseModel(
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
    this.text,
    this.userId,
    this.postId,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  String? text;
  String? userId;
  String? postId;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        text: json["text"],
        userId: json["userId"],
        postId: json["postId"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "userId": userId,
        "postId": postId,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
