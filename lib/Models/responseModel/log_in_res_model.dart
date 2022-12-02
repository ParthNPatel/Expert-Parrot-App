// // To parse this JSON data, do
// //
// //     final logInResponseModel = logInResponseModelFromJson(jsonString);
//
// import 'dart:convert';
//
// LogInResponseModel logInResponseModelFromJson(String str) =>
//     LogInResponseModel.fromJson(json.decode(str));
//
// String logInResponseModelToJson(LogInResponseModel data) =>
//     json.encode(data.toJson());
//
// class LogInResponseModel {
//   LogInResponseModel({
//     this.flag,
//     this.token,
//     this.data,
//   });
//
//   bool? flag;
//   String? token;
//   Data? data;
//
//   factory LogInResponseModel.fromJson(Map<String, dynamic> json) =>
//       LogInResponseModel(
//         flag: json["flag"],
//         token: json["token"],
//         data: Data.fromJson(json["data"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "flag": flag,
//         "token": token,
//         "data": data!.toJson(),
//       };
// }
//
// class Data {
//   Data({
//     this.id,
//     this.loginId,
//     this.loginType,
//     this.bmi,
//     this.height,
//     this.createdAt,
//     this.dependents,
//     this.fcmToken,
//     this.heartRate,
//     this.likedPost,
//     this.likedVideo,
//     this.medicines,
//     this.name,
//     this.posts,
//     this.requests,
//     this.timeOffset,
//     this.userImage,
//     this.updatedAt,
//     this.userTime,
//     this.water,
//     this.weight,
//     this.age,
//     this.profileSet,
//   });
//
//   String? id;
//   String? loginId;
//   String? loginType;
//   double? bmi;
//   int? height;
//   DateTime? createdAt;
//   List<dynamic>? dependents;
//   String? fcmToken;
//   int? heartRate;
//   List<dynamic>? likedPost;
//   List<dynamic>? likedVideo;
//   List<dynamic>? medicines;
//   String? name;
//   List<dynamic>? posts;
//   List<dynamic>? requests;
//   String? timeOffset;
//   String? userImage;
//   DateTime? updatedAt;
//   DateTime? userTime;
//   int? water;
//   int? weight;
//   int? age;
//   bool? profileSet;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["_id"],
//         loginId: json["loginId"],
//         loginType: json["loginType"],
//         bmi: json["bmi"].toDouble(),
//         height: json["height"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         dependents: List<dynamic>.from(json["dependents"].map((x) => x)),
//         fcmToken: json["fcm_token"],
//         heartRate: json["heartRate"],
//         likedPost: List<dynamic>.from(json["likedPost"].map((x) => x)),
//         likedVideo: List<dynamic>.from(json["likedVideo"].map((x) => x)),
//         medicines: List<dynamic>.from(json["medicines"].map((x) => x)),
//         name: json["name"],
//         posts: List<dynamic>.from(json["posts"].map((x) => x)),
//         requests: List<dynamic>.from(json["requests"].map((x) => x)),
//         timeOffset: json["timeOffset"],
//         userImage: json["userImage"],
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         userTime: DateTime.parse(json["userTime"]),
//         water: json["water"],
//         weight: json["weight"],
//         age: json["age"],
//         profileSet: json["profileSet"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "loginId": loginId,
//         "loginType": loginType,
//         "bmi": bmi,
//         "height": height,
//         "createdAt": createdAt!.toIso8601String(),
//         "dependents": List<dynamic>.from(dependents!.map((x) => x)),
//         "fcm_token": fcmToken,
//         "heartRate": heartRate,
//         "likedPost": List<dynamic>.from(likedPost!.map((x) => x)),
//         "likedVideo": List<dynamic>.from(likedVideo!.map((x) => x)),
//         "medicines": List<dynamic>.from(medicines!.map((x) => x)),
//         "name": name,
//         "posts": List<dynamic>.from(posts!.map((x) => x)),
//         "requests": List<dynamic>.from(requests!.map((x) => x)),
//         "timeOffset": timeOffset,
//         "userImage": userImage,
//         "updatedAt": updatedAt!.toIso8601String(),
//         "userTime": userTime!.toIso8601String(),
//         "water": water,
//         "weight": weight,
//         "age": age,
//         "profileSet": profileSet,
//       };
// }
// To parse this JSON data, do
//
//     final logInResponseModel = logInResponseModelFromJson(jsonString);

import 'dart:convert';

LogInResponseModel logInResponseModelFromJson(String str) =>
    LogInResponseModel.fromJson(json.decode(str));

String logInResponseModelToJson(LogInResponseModel data) =>
    json.encode(data.toJson());

class LogInResponseModel {
  LogInResponseModel({
    this.flag,
    this.token,
    this.data,
  });

  bool? flag;
  String? token;
  Data? data;

  factory LogInResponseModel.fromJson(Map<String, dynamic> json) =>
      LogInResponseModel(
        flag: json["flag"],
        token: json["token"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "token": token,
        "data": data!.toJson(),
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
  List<dynamic>? likedVideo;
  List<dynamic>? medicines;
  String? name;
  List<dynamic>? posts;
  bool? profileSet;
  List<dynamic>? requests;
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
        likedVideo: List<dynamic>.from(json["likedVideo"].map((x) => x)),
        medicines: List<dynamic>.from(json["medicines"].map((x) => x)),
        name: json["name"],
        posts: List<dynamic>.from(json["posts"].map((x) => x)),
        profileSet: json["profileSet"],
        requests: List<dynamic>.from(json["requests"].map((x) => x)),
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
