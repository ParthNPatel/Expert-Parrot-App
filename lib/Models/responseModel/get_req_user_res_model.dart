// To parse this JSON data, do
//
//     final getReqResponseModel = getReqResponseModelFromJson(jsonString);

import 'dart:convert';

GetReqResponseModel getReqResponseModelFromJson(String str) =>
    GetReqResponseModel.fromJson(json.decode(str));

String getReqResponseModelToJson(GetReqResponseModel data) =>
    json.encode(data.toJson());

class GetReqResponseModel {
  GetReqResponseModel({
    this.flag,
    this.data,
  });

  bool? flag;
  List<Datum>? data;

  factory GetReqResponseModel.fromJson(Map<String, dynamic> json) =>
      GetReqResponseModel(
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
    this.requestor,
    this.recipient,
    this.relation,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  Requestor? requestor;
  String? recipient;
  String? relation;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        requestor: Requestor.fromJson(json["requestor"]),
        recipient: json["recipient"],
        relation: json["relation"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "requestor": requestor!.toJson(),
        "recipient": recipient,
        "relation": relation,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}

class Requestor {
  Requestor({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Requestor.fromJson(Map<String, dynamic> json) => Requestor(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
