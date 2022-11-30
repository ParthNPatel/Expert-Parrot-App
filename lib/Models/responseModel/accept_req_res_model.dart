// To parse this JSON data, do
//
//     final acceptReqResponseModel = acceptReqResponseModelFromJson(jsonString);

import 'dart:convert';

AcceptReqResponseModel acceptReqResponseModelFromJson(String str) =>
    AcceptReqResponseModel.fromJson(json.decode(str));

String acceptReqResponseModelToJson(AcceptReqResponseModel data) =>
    json.encode(data.toJson());

class AcceptReqResponseModel {
  AcceptReqResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  String? data;

  factory AcceptReqResponseModel.fromJson(Map<String, dynamic> json) =>
      AcceptReqResponseModel(
        flag: json["flag"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "data": data,
      };
}
