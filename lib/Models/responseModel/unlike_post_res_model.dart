// To parse this JSON data, do
//
//     final unLikePostResponseModel = unLikePostResponseModelFromJson(jsonString);

import 'dart:convert';

UnLikePostResponseModel unLikePostResponseModelFromJson(String str) =>
    UnLikePostResponseModel.fromJson(json.decode(str));

String unLikePostResponseModelToJson(UnLikePostResponseModel data) =>
    json.encode(data.toJson());

class UnLikePostResponseModel {
  UnLikePostResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory UnLikePostResponseModel.fromJson(Map<String, dynamic> json) =>
      UnLikePostResponseModel(
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
    this.title,
    this.description,
    this.likes,
    this.userId,
    this.comments,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? title;
  String? description;
  int? likes;
  String? userId;
  List<String>? comments;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        likes: json["likes"],
        userId: json["userId"],
        comments: List<String>.from(json["comments"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "likes": likes,
        "userId": userId,
        "comments": List<dynamic>.from(comments!.map((x) => x)),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
