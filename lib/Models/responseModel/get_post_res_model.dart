// To parse this JSON data, do
//
//     final getPostResponseModel = getPostResponseModelFromJson(jsonString);

import 'dart:convert';

GetPostResponseModel getPostResponseModelFromJson(String str) =>
    GetPostResponseModel.fromJson(json.decode(str));

String getPostResponseModelToJson(GetPostResponseModel data) =>
    json.encode(data.toJson());

class GetPostResponseModel {
  GetPostResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  List<AllPost>? data;

  factory GetPostResponseModel.fromJson(Map<String, dynamic> json) =>
      GetPostResponseModel(
        flag: json["flag"],
        data: List<AllPost>.from(json["data"].map((x) => AllPost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AllPost {
  AllPost({
    this.id,
    this.title,
    this.description,
    this.likes,
    this.userId,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.isLiked,
  });

  String? id;
  String? title;
  String? description;
  int? likes;
  String? userId;
  List<dynamic>? comments;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isLiked;

  factory AllPost.fromJson(Map<String, dynamic> json) => AllPost(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        likes: json["likes"],
        userId: json["userId"],
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        isLiked: json["isLiked"],
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
        "isLiked": isLiked,
      };
}
