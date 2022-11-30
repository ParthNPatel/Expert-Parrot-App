// To parse this JSON data, do
//
//     final unLikeVideoResponseModel = unLikeVideoResponseModelFromJson(jsonString);

import 'dart:convert';

UnLikeVideoResponseModel unLikeVideoResponseModelFromJson(String str) =>
    UnLikeVideoResponseModel.fromJson(json.decode(str));

String unLikeVideoResponseModelToJson(UnLikeVideoResponseModel data) =>
    json.encode(data.toJson());

class UnLikeVideoResponseModel {
  UnLikeVideoResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory UnLikeVideoResponseModel.fromJson(Map<String, dynamic> json) =>
      UnLikeVideoResponseModel(
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
    this.id,
    this.title,
    this.description,
    this.thumbnail,
    this.video,
    this.likes,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? title;
  String? description;
  String? thumbnail;
  String? video;
  int? likes;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        video: json["video"],
        likes: json["likes"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "thumbnail": thumbnail,
        "video": video,
        "likes": likes,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
