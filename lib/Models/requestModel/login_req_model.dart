class LoginReqModel {
  String? name;
  String? loginType;
  String? loginId;
  String? water;
  String? weight;
  String? heartRate;
  double? bmi;
  String? fcmToken;
  String? userTime;

  LoginReqModel(
      {this.name,
      this.loginType,
      this.loginId,
      this.water,
      this.weight,
      this.heartRate,
      this.userTime,
      this.bmi,
      this.fcmToken});

  LoginReqModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userTime = json['userTime'];
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
    data['userTime'] = this.userTime;
    return data;
  }
}
