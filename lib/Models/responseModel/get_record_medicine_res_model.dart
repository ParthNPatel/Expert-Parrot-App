class GetRecordMedicineResponseModel {
  bool? flag;
  Data? data;

  GetRecordMedicineResponseModel({this.flag, this.data});

  GetRecordMedicineResponseModel.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Docs>? docs;
  int? total;
  String? limit;
  String? page;
  int? pages;

  Data({this.docs, this.total, this.limit, this.page, this.pages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(new Docs.fromJson(v));
      });
    }
    total = json['total'];
    limit = json['limit'];
    page = json['page'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.docs != null) {
      data['docs'] = this.docs!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['limit'] = this.limit;
    data['page'] = this.page;
    data['pages'] = this.pages;
    return data;
  }
}

class Docs {
  String? sId;
  MedicineId? medicineId;
  String? createdAt;
  String? date;
  List<int>? doses;
  String? updatedAt;

  Docs(
      {this.sId,
      this.medicineId,
      this.createdAt,
      this.date,
      this.doses,
      this.updatedAt});

  Docs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    medicineId = json['medicineId'] != null
        ? new MedicineId.fromJson(json['medicineId'])
        : null;
    createdAt = json['createdAt'];
    date = json['date'];
    doses = json['doses'].cast<int>();
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.medicineId != null) {
      data['medicineId'] = this.medicineId!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['date'] = this.date;
    data['doses'] = this.doses;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class MedicineId {
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

  MedicineId(
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
      this.updatedAt});

  MedicineId.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
