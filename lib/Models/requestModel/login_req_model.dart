class LoginReqModel {
  String? name;
  String? loginType;
  String? loginId;
  int? water;
  int? weight;
  int? heartRate;
  double? bmi;
  String? fcmToken;

  LoginReqModel(
      {this.name,
      this.loginType,
      this.loginId,
      this.water,
      this.weight,
      this.heartRate,
      this.bmi,
      this.fcmToken});

  LoginReqModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    loginType = json['loginType'];
    loginId = json['loginId'];
    water = json['water'];
    weight = json['weight'];
    heartRate = json['heartRate'];
    bmi = json['bmi'];
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['loginType'] = this.loginType;
    data['loginId'] = this.loginId;
    data['water'] = this.water;
    data['weight'] = this.weight;
    data['heartRate'] = this.heartRate;
    data['bmi'] = this.bmi;
    data['fcm_token'] = this.fcmToken;
    return data;
  }
}
