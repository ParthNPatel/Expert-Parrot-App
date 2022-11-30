// To parse this JSON data, do
//
//     final rejectReqResponseModel = rejectReqResponseModelFromJson(jsonString);

import 'dart:convert';

RejectReqResponseModel rejectReqResponseModelFromJson(String str) =>
    RejectReqResponseModel.fromJson(json.decode(str));

String rejectReqResponseModelToJson(RejectReqResponseModel data) =>
    json.encode(data.toJson());

class RejectReqResponseModel {
  RejectReqResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  String? data;

  factory RejectReqResponseModel.fromJson(Map<String, dynamic> json) =>
      RejectReqResponseModel(
        flag: json["flag"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "data": data,
      };
}
