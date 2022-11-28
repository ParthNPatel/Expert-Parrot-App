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
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.loginId,
    this.loginType,
    this.bmi,
    this.createdAt,
    this.dependents,
    this.fcmToken,
    this.heartRate,
    this.likedPost,
    this.likedVideo,
    this.medicines,
    this.name,
    this.posts,
    this.requests,
    this.timeOffset,
    this.updatedAt,
    this.userTime,
    this.water,
    this.weight,
  });

  String? id;
  String? loginId;
  String? loginType;
  double? bmi;
  DateTime? createdAt;
  List<dynamic>? dependents;
  String? fcmToken;
  int? heartRate;
  List<dynamic>? likedPost;
  List<dynamic>? likedVideo;
  List<Medicine>? medicines;
  String? name;
  List<dynamic>? posts;
  List<dynamic>? requests;
  String? timeOffset;
  DateTime? updatedAt;
  DateTime? userTime;
  int? water;
  int? weight;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        loginId: json["loginId"],
        loginType: json["loginType"],
        bmi: json["bmi"].toDouble(),
        createdAt: DateTime.parse(json["createdAt"]),
        dependents: List<dynamic>.from(json["dependents"].map((x) => x)),
        fcmToken: json["fcm_token"],
        heartRate: json["heartRate"],
        likedPost: List<dynamic>.from(json["likedPost"].map((x) => x)),
        likedVideo: List<dynamic>.from(json["likedVideo"].map((x) => x)),
        medicines: List<Medicine>.from(
            json["medicines"].map((x) => Medicine.fromJson(x))),
        name: json["name"],
        posts: List<dynamic>.from(json["posts"].map((x) => x)),
        requests: List<dynamic>.from(json["requests"].map((x) => x)),
        timeOffset: json["timeOffset"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        userTime: DateTime.parse(json["userTime"]),
        water: json["water"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "loginId": loginId,
        "loginType": loginType,
        "bmi": bmi,
        "createdAt": createdAt!.toIso8601String(),
        "dependents": List<dynamic>.from(dependents!.map((x) => x)),
        "fcm_token": fcmToken,
        "heartRate": heartRate,
        "likedPost": List<dynamic>.from(likedPost!.map((x) => x)),
        "likedVideo": List<dynamic>.from(likedVideo!.map((x) => x)),
        "medicines": List<dynamic>.from(medicines!.map((x) => x.toJson())),
        "name": name,
        "posts": List<dynamic>.from(posts!.map((x) => x)),
        "requests": List<dynamic>.from(requests!.map((x) => x)),
        "timeOffset": timeOffset,
        "updatedAt": updatedAt!.toIso8601String(),
        "userTime": userTime!?.toIso8601String(),
        "water": water,
        "weight": weight,
      };
}

class Medicine {
  Medicine({
    this.id,
    this.name,
    this.strength,
    this.days,
    this.appearance,
    this.frequency,
    this.totalTimes,
    this.shceduleTime,
    this.utcShceduleTime,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  int? strength;
  int? days;
  String? appearance;
  String? frequency;
  int? totalTimes;
  List<String>? shceduleTime;
  List<String>? utcShceduleTime;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        id: json["_id"],
        name: json["name"],
        strength: json["strength"],
        days: json["days"],
        appearance: json["appearance"],
        frequency: json["frequency"],
        totalTimes: json["totalTimes"],
        shceduleTime: List<String>.from(json["shceduleTime"].map((x) => x)),
        utcShceduleTime:
            List<String>.from(json["utcShceduleTime"].map((x) => x)),
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "strength": strength,
        "days": days,
        "appearance": appearance,
        "frequency": frequency,
        "totalTimes": totalTimes,
        "shceduleTime": List<dynamic>.from(shceduleTime!.map((x) => x)),
        "utcShceduleTime": List<dynamic>.from(utcShceduleTime!.map((x) => x)),
        "userId": userId,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
