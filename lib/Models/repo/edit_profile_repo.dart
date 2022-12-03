import 'package:expert_parrot_app/constant/api_const.dart';
import 'package:expert_parrot_app/get_storage_services/get_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../components/common_widget.dart';
import '../../view/bottom_nav_screen.dart';
import '../services/api_services.dart';
import '../services/base_service.dart';

class EditProfileRepo extends BaseService {
  static Future editProfileRepo({required Map<String, dynamic> model}) async {
    print('getBarrierToken   ${GetStorageServices.getBarrierToken()}');

    var response = await APIService().getPutResponse(
        url: APIConst.userData, apitype: APIType.aPut, body: model);
    print('EditProfile response===>>>  $response');
    if (response['flag'] == true) {
      GetStorageServices.setBarrierToken('${response['token']}');

      if (response['data']['profileSet'] == true) {
        var dataOfApi = response['data'];
// print('${}')
        CommonWidget.updateUserDetails(
            height: '${dataOfApi['height']}',
            age: '${dataOfApi['age']}',
            userImage: '${response['userImage']}',
            weight: '${response['weight']}',
            name: '${dataOfApi['name']}');

        Get.offAll(BottomNavScreen());
      }
    } else {
      CommonWidget.getSnackBar(
        message: '',
        title: 'Login Failed',
        duration: 2,
        color: Colors.red,
      );
    }
    return response;
  }
}
