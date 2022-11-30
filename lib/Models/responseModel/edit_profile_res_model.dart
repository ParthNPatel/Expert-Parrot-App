// To parse this JSON data, do
//
//     final editProfileResponseModel = editProfileResponseModelFromJson(jsonString);

import 'dart:convert';

EditProfileResponseModel editProfileResponseModelFromJson(String str) =>
    EditProfileResponseModel.fromJson(json.decode(str));

String editProfileResponseModelToJson(EditProfileResponseModel data) =>
    json.encode(data.toJson());

class EditProfileResponseModel {
  EditProfileResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory EditProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      EditProfileResponseModel(
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
    this.requests,
    this.id,
    this.loginId,
    this.loginType,
    this.bmi,
    this.createdAt,
    this.heartRate,
    this.likedPost,
    this.likedVideo,
    this.medicines,
    this.name,
    this.posts,
    this.updatedAt,
    this.water,
    this.weight,
    this.fcmToken,
    this.timeOffset,
    this.userTime,
    this.age,
    this.height,
    this.profileSet,
    this.userImage,
    this.dependents,
  });

  List<dynamic>? requests;
  String? id;
  String? loginId;
  String? loginType;
  double? bmi;
  DateTime? createdAt;
  int? heartRate;
  List<String>? likedPost;
  List<dynamic>? likedVideo;
  List<dynamic>? medicines;
  String? name;
  List<dynamic>? posts;
  DateTime? updatedAt;
  int? water;
  int? weight;
  String? fcmToken;
  String? timeOffset;
  DateTime? userTime;
  int? age;
  int? height;
  bool? profileSet;
  String? userImage;
  List<dynamic>? dependents;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        requests: List<dynamic>.from(json["requests"].map((x) => x)),
        id: json["_id"],
        loginId: json["loginId"],
        loginType: json["loginType"],
        bmi: json["bmi"].toDouble(),
        createdAt: DateTime.parse(json["createdAt"]),
        heartRate: json["heartRate"],
        likedPost: List<String>.from(json["likedPost"].map((x) => x)),
        likedVideo: List<dynamic>.from(json["likedVideo"].map((x) => x)),
        medicines: List<dynamic>.from(json["medicines"].map((x) => x)),
        name: json["name"],
        posts: List<dynamic>.from(json["posts"].map((x) => x)),
        updatedAt: DateTime.parse(json["updatedAt"]),
        water: json["water"],
        weight: json["weight"],
        fcmToken: json["fcm_token"],
        timeOffset: json["timeOffset"],
        userTime: DateTime.parse(json["userTime"]),
        age: json["age"],
        height: json["height"],
        profileSet: json["profileSet"],
        userImage: json["userImage"],
        dependents: List<dynamic>.from(json["dependents"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "requests": List<dynamic>.from(requests!.map((x) => x)),
        "_id": id,
        "loginId": loginId,
        "loginType": loginType,
        "bmi": bmi,
        "createdAt": createdAt!.toIso8601String(),
        "heartRate": heartRate,
        "likedPost": List<dynamic>.from(likedPost!.map((x) => x)),
        "likedVideo": List<dynamic>.from(likedVideo!.map((x) => x)),
        "medicines": List<dynamic>.from(medicines!.map((x) => x)),
        "name": name,
        "posts": List<dynamic>.from(posts!.map((x) => x)),
        "updatedAt": updatedAt!.toIso8601String(),
        "water": water,
        "weight": weight,
        "fcm_token": fcmToken,
        "timeOffset": timeOffset,
        "userTime": userTime!.toIso8601String(),
        "age": age,
        "height": height,
        "profileSet": profileSet,
        "userImage": userImage,
        "dependents": List<dynamic>.from(dependents!.map((x) => x)),
      };
}
