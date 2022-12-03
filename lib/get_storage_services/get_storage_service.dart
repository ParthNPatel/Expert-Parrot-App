import 'dart:io';

import 'package:get_storage/get_storage.dart';

class GetStorageServices {
  static GetStorage getStorage = GetStorage();

  static Future setUserHeight(String height) async {
    await getStorage.write('height', height);
  }

  static getUserHeight() {
    return getStorage.read('height');
  }

  static setBarrierToken(token) async {
    await getStorage.write('barrierToken', token);
  }
  static setUserWater(int height) {
    getStorage.write('water', height);
  }

  static getUserWater() {
    return getStorage.read('water');
  }
  static getBarrierToken() {
    return getStorage.read('barrierToken');
  }

  static setFcm(String fcm) async {
    await getStorage.write('fcm', fcm);
  }

  static getFcm() {
    return getStorage.read('fcm');
  }

  static setUserWeight(String weight) async {
    await getStorage.write('weight', weight);
  }

  static getUserWeight() {
    return getStorage.read('weight');
  }

  static setUserBMI(String bmi) async {
    await getStorage.write('bmi', bmi);
  }

  static getUserBMI() {
    return getStorage.read('bmi');
  }

  static setUserLoggedIn() async {
    await getStorage.write('isUserLoggedIn', true);
  }

  static getUserLoggedInStatus() {
    return getStorage.read('isUserLoggedIn');
  }

  static setUserName(String userName) async {
    await getStorage.write('userName', userName);
  }

  static getUserName() {
    return getStorage.read('userName');
  }

  static setAge(String age) async {
    await getStorage.write('age', age);
  }

  static getAge() {
    return getStorage.read('age');
  }

  static setUserImage(String userImage) async {
    await getStorage.write('userImage', userImage);
  }

  static getUserImage() {
    return getStorage.read('userImage');
  }

  static setLocalImage(File localImage) async {
    await getStorage.write('localImage', localImage);
  }

  static getLocalImage() {
    return getStorage.read('localImage');
  }

  static setUserProfileSet(bool profileSet) async {
    await getStorage.write('profileSet', profileSet);
  }

  static getUserProfileSet() {
    return getStorage.read('profileSet');
  }

  static logOut() {
    getStorage.erase();
  }
}
