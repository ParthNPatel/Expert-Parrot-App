// To parse this JSON data, do
//
//     final userDataResponseModel = userDataResponseModelFromJson(jsonString);

import 'dart:convert';

UserDataResponseModel userDataResponseModelFromJson(String str) =>
    UserDataResponseModel.fromJson(json.decode(str));

String userDataResponseModelToJson(UserDataResponseModel data) =>
    json.encode(data.toJson());

class UserDataResponseModel {
  UserDataResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory UserDataResponseModel.fromJson(Map<String, dynamic> json) =>
      UserDataResponseModel(
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
    this.loginId,
    this.loginType,
    this.createdAt,
    this.dependents,
    this.fcmToken,
    this.likedPost,
    this.likedVideo,
    this.medicines,
    this.name,
    this.posts,
    this.profileSet,
    this.requests,
    this.timeOffset,
    this.updatedAt,
    this.userTime,
  });

  String? id;
  String? loginId;
  String? loginType;
  DateTime? createdAt;
  List<dynamic>? dependents;
  String? fcmToken;
  List<dynamic>? likedPost;
  List<String>? likedVideo;
  List<dynamic>? medicines;
  String? name;
  List<dynamic>? posts;
  bool? profileSet;
  List<String>? requests;
  String? timeOffset;
  DateTime? updatedAt;
  DateTime? userTime;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        loginId: json["loginId"],
        loginType: json["loginType"],
        createdAt: DateTime.parse(json["createdAt"]),
        dependents: List<dynamic>.from(json["dependents"].map((x) => x)),
        fcmToken: json["fcm_token"],
        likedPost: List<dynamic>.from(json["likedPost"].map((x) => x)),
        likedVideo: List<String>.from(json["likedVideo"].map((x) => x)),
        medicines: List<dynamic>.from(json["medicines"].map((x) => x)),
        name: json["name"],
        posts: List<dynamic>.from(json["posts"].map((x) => x)),
        profileSet: json["profileSet"],
        requests: List<String>.from(json["requests"].map((x) => x)),
        timeOffset: json["timeOffset"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        userTime: DateTime.parse(json["userTime"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "loginId": loginId,
        "loginType": loginType,
        "createdAt": createdAt!.toIso8601String(),
        "dependents": List<dynamic>.from(dependents!.map((x) => x)),
        "fcm_token": fcmToken,
        "likedPost": List<dynamic>.from(likedPost!.map((x) => x)),
        "likedVideo": List<dynamic>.from(likedVideo!.map((x) => x)),
        "medicines": List<dynamic>.from(medicines!.map((x) => x)),
        "name": name,
        "posts": List<dynamic>.from(posts!.map((x) => x)),
        "profileSet": profileSet,
        "requests": List<dynamic>.from(requests!.map((x) => x)),
        "timeOffset": timeOffset,
        "updatedAt": updatedAt!.toIso8601String(),
        "userTime": userTime!.toIso8601String(),
      };
}
