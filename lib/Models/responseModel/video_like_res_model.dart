// To parse this JSON data, do
//
//     final videoLikeResponseModel = videoLikeResponseModelFromJson(jsonString);

import 'dart:convert';

VideoLikeResponseModel videoLikeResponseModelFromJson(String str) =>
    VideoLikeResponseModel.fromJson(json.decode(str));

String videoLikeResponseModelToJson(VideoLikeResponseModel data) =>
    json.encode(data.toJson());

class VideoLikeResponseModel {
  VideoLikeResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory VideoLikeResponseModel.fromJson(Map<String, dynamic> json) =>
      VideoLikeResponseModel(
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
    this.video,
    this.likes,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? title;
  String? description;
  String? video;
  int? likes;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        video: json["video"],
        likes: json["likes"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "video": video,
        "likes": likes,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
