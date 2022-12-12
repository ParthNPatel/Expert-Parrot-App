// To parse this JSON data, do
//
//     final getAllPostCategoriesResponseModel = getAllPostCategoriesResponseModelFromJson(jsonString);

import 'dart:convert';

GetAllPostCategoriesResponseModel getAllPostCategoriesResponseModelFromJson(
        String str) =>
    GetAllPostCategoriesResponseModel.fromJson(json.decode(str));

String getAllPostCategoriesResponseModelToJson(
        GetAllPostCategoriesResponseModel data) =>
    json.encode(data.toJson());

class GetAllPostCategoriesResponseModel {
  GetAllPostCategoriesResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  List<PostCat>? data;

  factory GetAllPostCategoriesResponseModel.fromJson(
          Map<String, dynamic> json) =>
      GetAllPostCategoriesResponseModel(
        flag: json["flag"],
        data: List<PostCat>.from(json["data"].map((x) => PostCat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PostCat {
  PostCat({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory PostCat.fromJson(Map<String, dynamic> json) => PostCat(
        id: json["_id"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
