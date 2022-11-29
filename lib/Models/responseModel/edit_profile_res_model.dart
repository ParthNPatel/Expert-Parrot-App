// To parse this JSON data, do
//
//     final editProfileResponseModel = editProfileResponseModelFromJson(jsonString);

import 'dart:convert';

EditProfileResponseModel editProfileResponseModelFromJson(String str) => EditProfileResponseModel.fromJson(json.decode(str));

String editProfileResponseModelToJson(EditProfileResponseModel data) => json.encode(data.toJson());

class EditProfileResponseModel {
  EditProfileResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory EditProfileResponseModel.fromJson(Map<String, dynamic> json) => EditProfileResponseModel(
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
    this.likedVideo,
    this.posts,
    this.requests,
    this.id,
    this.loginId,
    this.loginType,
    this.bmi,
    this.createdAt,
    this.heartRate,
    this.medicines,
    this.name,
    this.updatedAt,
    this.water,
    this.weight,
    this.likedPost,
    this.dependents,
  });

  List<dynamic>? likedVideo;
  List<dynamic>? posts;
  List<dynamic>? requests;
  String? id;
  String? loginId;
  String? loginType;
  double? bmi;
  DateTime? createdAt;
  int? heartRate;
  List<String>? medicines;
  String? name;
  DateTime? updatedAt;
  int? water;
  int? weight;
  List<String>? likedPost;
  List<dynamic>? dependents;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    likedVideo: List<dynamic>.from(json["likedVideo"].map((x) => x)),
    posts: List<dynamic>.from(json["posts"].map((x) => x)),
    requests: List<dynamic>.from(json["requests"].map((x) => x)),
    id: json["_id"],
    loginId: json["loginId"],
    loginType: json["loginType"],
    bmi: json["bmi"].toDouble(),
    createdAt: DateTime.parse(json["createdAt"]),
    heartRate: json["heartRate"],
    medicines: List<String>.from(json["medicines"].map((x) => x)),
    name: json["name"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    water: json["water"],
    weight: json["weight"],
    likedPost: List<String>.from(json["likedPost"].map((x) => x)),
    dependents: List<dynamic>.from(json["dependents"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "likedVideo": List<dynamic>.from(likedVideo!.map((x) => x)),
    "posts": List<dynamic>.from(posts!.map((x) => x)),
    "requests": List<dynamic>.from(requests!.map((x) => x)),
    "_id": id,
    "loginId": loginId,
    "loginType": loginType,
    "bmi": bmi,
    "createdAt": createdAt!.toIso8601String(),
    "heartRate": heartRate,
    "medicines": List<dynamic>.from(medicines!.map((x) => x)),
    "name": name,
    "updatedAt": updatedAt!.toIso8601String(),
    "water": water,
    "weight": weight,
    "likedPost": List<dynamic>.from(likedPost!.map((x) => x)),
    "dependents": List<dynamic>.from(dependents!.map((x) => x)),
  };
}
