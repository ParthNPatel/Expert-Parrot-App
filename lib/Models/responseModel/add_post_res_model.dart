// To parse this JSON data, do
//
//     final addPostResponseModel = addPostResponseModelFromJson(jsonString);

import 'dart:convert';

AddPostResponseModel addPostResponseModelFromJson(String str) =>
    AddPostResponseModel.fromJson(json.decode(str));

String addPostResponseModelToJson(AddPostResponseModel data) =>
    json.encode(data.toJson());

class AddPostResponseModel {
  AddPostResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory AddPostResponseModel.fromJson(Map<String, dynamic> json) =>
      AddPostResponseModel(
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
    this.title,
    this.description,
    this.likes,
    this.userId,
    this.comments,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  String? title;
  String? description;
  int? likes;
  String? userId;
  List<dynamic>? comments;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        description: json["description"],
        likes: json["likes"],
        userId: json["userId"],
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "likes": likes,
        "userId": userId,
        "comments": List<dynamic>.from(comments!.map((x) => x)),
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
