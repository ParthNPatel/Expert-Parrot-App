// To parse this JSON data, do
//
//     final dependentsResponseModel = dependentsResponseModelFromJson(jsonString);

import 'dart:convert';

DependentsResponseModel dependentsResponseModelFromJson(String str) =>
    DependentsResponseModel.fromJson(json.decode(str));

String dependentsResponseModelToJson(DependentsResponseModel data) =>
    json.encode(data.toJson());

class DependentsResponseModel {
  DependentsResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  Data? data;

  factory DependentsResponseModel.fromJson(Map<String, dynamic> json) =>
      DependentsResponseModel(
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
    this.dependents,
    this.name,
  });

  String? id;
  List<DataDependent>? dependents;
  String? name;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        dependents: List<DataDependent>.from(
            json["dependents"].map((x) => DataDependent.fromJson(x))),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "dependents": List<dynamic>.from(dependents!.map((x) => x.toJson())),
        "name": name,
      };
}

class DataDependent {
  DataDependent({
    this.relation,
    this.userId,
  });

  String? relation;
  UserId? userId;

  factory DataDependent.fromJson(Map<String, dynamic> json) => DataDependent(
        relation: json["relation"],
        userId: UserId.fromJson(json["userId"]),
      );

  Map<String, dynamic> toJson() => {
        "relation": relation,
        "userId": userId!.toJson(),
      };
}

class UserId {
  UserId({
    this.bmi,
    this.id,
    this.loginId,
    this.loginType,
    this.createdAt,
    this.dependents,
    this.fcmToken,
    this.likedPost,
    this.likedVideo,
    this.medicines,
    this.posts,
    this.profileSet,
    this.requests,
    this.timeOffset,
    this.updatedAt,
    this.userTime,
    this.age,
    this.height,
    this.name,
    this.userImage,
    this.weight,
    this.calories,
    this.kilometers,
    this.steps,
  });

  int? bmi;
  String? id;
  String? loginId;
  String? calories;
  String? kilometers;
  String? steps;
  String? loginType;
  DateTime? createdAt;
  List<UserIdDependent>? dependents;
  String? fcmToken;
  List<dynamic>? likedPost;
  List<dynamic>? likedVideo;
  List<dynamic>? medicines;
  List<dynamic>? posts;
  bool? profileSet;
  List<dynamic>? requests;
  String? timeOffset;
  DateTime? updatedAt;
  DateTime? userTime;
  int? age;
  int? height;
  String? name;
  String? userImage;
  int? weight;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        bmi: json["bmi"],
        id: json["_id"],
        loginId: json["loginId"],
        loginType: json["loginType"],
        calories: json["calories"],
        kilometers: json["kilometers"],
        steps: json["steps"],
        createdAt: DateTime.parse(json["createdAt"]),
        dependents: List<UserIdDependent>.from(
            json["dependents"].map((x) => UserIdDependent.fromJson(x))),
        fcmToken: json["fcm_token"],
        likedPost: List<dynamic>.from(json["likedPost"].map((x) => x)),
        likedVideo: List<dynamic>.from(json["likedVideo"].map((x) => x)),
        medicines: List<dynamic>.from(json["medicines"].map((x) => x)),
        posts: List<dynamic>.from(json["posts"].map((x) => x)),
        profileSet: json["profileSet"],
        requests: List<dynamic>.from(json["requests"].map((x) => x)),
        timeOffset: json["timeOffset"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        userTime: DateTime.parse(json["userTime"]),
        age: json["age"],
        height: json["height"],
        name: json["name"],
        userImage: json["userImage"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "bmi": bmi,
        "_id": id,
        "loginId": loginId,
        "calories": calories,
        "kilometers": kilometers,
        "steps": steps,
        "loginType": loginType,
        "createdAt": createdAt!.toIso8601String(),
        "dependents": List<dynamic>.from(dependents!.map((x) => x.toJson())),
        "fcm_token": fcmToken,
        "likedPost": List<dynamic>.from(likedPost!.map((x) => x)),
        "likedVideo": List<dynamic>.from(likedVideo!.map((x) => x)),
        "medicines": List<dynamic>.from(medicines!.map((x) => x)),
        "posts": List<dynamic>.from(posts!.map((x) => x)),
        "profileSet": profileSet,
        "requests": List<dynamic>.from(requests!.map((x) => x)),
        "timeOffset": timeOffset,
        "updatedAt": updatedAt!.toIso8601String(),
        "userTime": userTime!.toIso8601String(),
        "age": age,
        "height": height,
        "name": name,
        "userImage": userImage,
        "weight": weight,
      };
}

class UserIdDependent {
  UserIdDependent({
    this.relation,
    this.userId,
    this.id,
  });

  String? relation;
  String? userId;
  String? id;

  factory UserIdDependent.fromJson(Map<String, dynamic> json) =>
      UserIdDependent(
        relation: json["relation"],
        userId: json["userId"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "relation": relation,
        "userId": userId,
        "_id": id,
      };
}
