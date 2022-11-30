// To parse this JSON data, do
//
//     final sendReqResponseModel = sendReqResponseModelFromJson(jsonString);

import 'dart:convert';

SendReqResponseModel sendReqResponseModelFromJson(String str) =>
    SendReqResponseModel.fromJson(json.decode(str));

String sendReqResponseModelToJson(SendReqResponseModel data) =>
    json.encode(data.toJson());

class SendReqResponseModel {
  SendReqResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  String? data;

  factory SendReqResponseModel.fromJson(Map<String, dynamic> json) =>
      SendReqResponseModel(
        flag: json["flag"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "data": data,
      };
}
