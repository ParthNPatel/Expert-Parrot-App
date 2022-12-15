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
  List<Post>? data;

  factory GetPostResponseModel.fromJson(Map<String, dynamic> json) =>
      GetPostResponseModel(
        flag: json["flag"],
        data: List<Post>.from(json["data"].map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Post {
  Post({
    this.id,
    this.title,
    this.description,
    this.image,
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
  String? image;
  int? likes;
  UserId? userId;
  List<String>? comments;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isLiked;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        likes: json["likes"],
        userId: UserId.fromJson(json["userId"]),
        comments: List<String>.from(json["comments"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        isLiked: json["isLiked"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "image": image,
        "likes": likes,
        "userId": userId!.toJson(),
        "comments": List<dynamic>.from(comments!.map((x) => x)),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "isLiked": isLiked,
      };
}

class UserId {
  UserId({
    this.name,
    this.userImage,
  });

  String? name;
  String? userImage;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        name: json["name"],
        userImage: json["userImage"] == null ? null : json["userImage"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "userImage": userImage == null ? null : userImage,
      };
}
