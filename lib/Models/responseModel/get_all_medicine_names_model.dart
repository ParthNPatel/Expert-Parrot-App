// To parse this JSON data, do
//
//     final getAllMedicineNames = getAllMedicineNamesFromJson(jsonString);

import 'dart:convert';

GetAllMedicineNames getAllMedicineNamesFromJson(String str) =>
    GetAllMedicineNames.fromJson(json.decode(str));

String getAllMedicineNamesToJson(GetAllMedicineNames data) =>
    json.encode(data.toJson());

class GetAllMedicineNames {
  GetAllMedicineNames({
    this.flag,
    this.data,
  });

  bool? flag;
  List<String>? data;

  factory GetAllMedicineNames.fromJson(Map<String, dynamic> json) =>
      GetAllMedicineNames(
        flag: json["flag"],
        data: List<String>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "data": List<dynamic>.from(data!.map((x) => x)),
      };
}
