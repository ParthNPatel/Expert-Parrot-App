import 'package:get_storage/get_storage.dart';

class GetStorageServices {
  static GetStorage getStorage = GetStorage();

  static setUserHeight({required String height}) {
    getStorage.write('height', height);
  }

  static getUserHeight() {
    return getStorage.read('height');
  }

  static setBarrierToken(token) {
    getStorage.write('barrierToken', token);
  }

  static getBarrierToken() {
    return getStorage.read('barrierToken');
  }

  static setFcm(String fcm) {
    getStorage.write('fcm', fcm);
  }

  static getFcm() {
    return getStorage.read('fcm');
  }

  static setUserWeight(String weight) {
    getStorage.write('weight', weight);
  }

  static getUserWeight() {
    return getStorage.read('weight');
  }

  static setUserBMI(String bmi) {
    getStorage.write('bmi', bmi);
  }

  static getUserBMI() {
    return getStorage.read('bmi');
  }

  static setUserLoggedIn() {
    getStorage.write('isUserLoggedIn', true);
  }

  static getUserLoggedInStatus() {
    return getStorage.read('isUserLoggedIn');
  }

  static logOut() {
    getStorage.remove("height");
    getStorage.remove("weight");
    getStorage.remove("bmi");
    getStorage.remove("isUserLoggedIn");
  }
}
