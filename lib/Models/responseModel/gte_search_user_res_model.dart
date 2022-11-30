// To parse this JSON data, do
//
//     final getSearchUserResponseModel = getSearchUserResponseModelFromJson(jsonString);

import 'dart:convert';

GetSearchUserResponseModel getSearchUserResponseModelFromJson(String str) =>
    GetSearchUserResponseModel.fromJson(json.decode(str));

String getSearchUserResponseModelToJson(GetSearchUserResponseModel data) =>
    json.encode(data.toJson());

class GetSearchUserResponseModel {
  GetSearchUserResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  List<Datum>? data;

  factory GetSearchUserResponseModel.fromJson(Map<String, dynamic> json) =>
      GetSearchUserResponseModel(
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
    this.name,
    this.userImage,
  });

  String? id;
  String? name;
  String? userImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        userImage: json["userImage"] == null ? null : json["userImage"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "userImage": userImage == null ? null : userImage,
      };
}
