import 'package:expert_parrot_app/constant/api_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/common_widget.dart';
import '../../get_storage_services/get_storage_service.dart';
import '../../view/bottom_nav_screen.dart';
import '../../view/set_profile_screen.dart';
import '../services/api_services.dart';
import '../services/base_service.dart';

class LoginRepo extends BaseService {
  static Future loginUserRepo(
      {required Map<String, dynamic> model,
      required final progress,
      required String logInId,
      required String loginType,
      bool isNavigator = false}) async {
    try {
      var response = await APIService().getResponse(
          url: APIConst.loginUrl, apitype: APIType.aPost, body: model);
      print('Login response===>>>  $response');
      print('${response['flag']}');
      print('${response['data']['profileSet']}');
      if (response['flag'] == true) {
        GetStorageServices.setBarrierToken('${response['token']}');

        if (response['data']['profileSet'] == true) {
          var dataOfApi = response['data'];
// print('${}')
          CommonWidget.setUserDetailsAtLogin(
              height: '${dataOfApi['height']}',
              age: '${dataOfApi['age']}',
              token: '${response['token']}',
              userImage: '${response['userImage']}',
              weight: '${response['weight']}',
              isUserProfileSet: true,
              name: '${dataOfApi['name']}');

          Get.offAll(BottomNavScreen());
        } else {
          Get.offAll(SetProfileScreen(
            logInId: logInId,
            loginType: loginType,
          ));
        }
      } else {
        CommonWidget.getSnackBar(
          message: '',
          title: 'Login Failed',
          duration: 2,
          color: Colors.red,
        );
      }
    } catch (e) {
      CommonWidget.getSnackBar(
        message: '',
        title: 'Failed',
        duration: 2,
        color: Colors.red,
      );
    }
  }
}
