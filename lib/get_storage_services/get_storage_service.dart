import 'package:get_storage/get_storage.dart';

class GetStorageServices {
  static GetStorage getStorage = GetStorage();

  static setUserHeight(int height) {
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

  static setUserWeight(int weight) {
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

  static setUserName(String userName) {
    getStorage.write('userName', userName);
  }

  static getUserName() {
    return getStorage.read('userName');
  }

  static setAge(int age) {
    getStorage.write('age', age);
  }

  static getAge() {
    return getStorage.read('age');
  }

  static setUserImage(String userImage) {
    getStorage.write('userImage', userImage);
  }

  static getUserImage() {
    return getStorage.read('userImage');
  }

  static setUserProfileSet(bool profileSet) {
    getStorage.write('profileSet', profileSet);
  }

  static getUserProfileSet() {
    return getStorage.read('profileSet');
  }

  static logOut() {
    getStorage.remove("height");
    getStorage.remove("userName");
    getStorage.remove("profileSet");
    getStorage.remove("weight");
    getStorage.remove("bmi");
    getStorage.remove("isUserLoggedIn");
  }
}
