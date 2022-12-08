class DateMedicineRecordResponseModel {
  bool? flag;
  List<Data>? data;

  DateMedicineRecordResponseModel({this.flag, this.data});

  DateMedicineRecordResponseModel.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  int? strength;
  int? days;
  String? appearance;
  String? frequency;
  int? totalTimes;
  List<String>? shceduleTime;
  List<String>? utcShceduleTime;
  String? userId;
  String? createdAt;
  String? updatedAt;
  List<int>? doses;

  Data(
      {this.sId,
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
      this.doses});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    strength = json['strength'];
    days = json['days'];
    appearance = json['appearance'];
    frequency = json['frequency'];
    totalTimes = json['totalTimes'];
    shceduleTime = json['shceduleTime'].cast<String>();
    utcShceduleTime = json['utcShceduleTime'].cast<String>();
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    doses = json['doses'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['strength'] = this.strength;
    data['days'] = this.days;
    data['appearance'] = this.appearance;
    data['frequency'] = this.frequency;
    data['totalTimes'] = this.totalTimes;
    data['shceduleTime'] = this.shceduleTime;
    data['utcShceduleTime'] = this.utcShceduleTime;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['doses'] = this.doses;
    return data;
  }
}
