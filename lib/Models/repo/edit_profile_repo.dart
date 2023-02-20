import 'dart:convert';
import 'dart:developer';

import 'package:expert_parrot_app/constant/api_const.dart';
import 'package:expert_parrot_app/get_storage_services/get_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../components/common_widget.dart';
import '../../view/bottom_nav_screen.dart';
import '../services/api_services.dart';
import '../services/base_service.dart';

class EditProfileRepo extends BaseService {
  static Future editProfileRepo(
      {required Map<String, dynamic> model, bool isEdit = false}) async {
    print('getBarrierToken   ${GetStorageServices.getBarrierToken()}');

    var response = await APIService().getPutResponse(
        url: APIConst.userData, apitype: APIType.aPut, body: model);
    print('EditProfile response===>>>  $response');
    if (response['flag'] == true) {
      // GetStorageServices.setBarrierToken('${response['token']}');

      if (response['data']['profileSet'] == true) {
        var dataOfApi = response['data'];
// print('${}')
        CommonWidget.updateUserDetails(
            height: '${dataOfApi['height']}',
            age: '${dataOfApi['age']}',
            userImage: '${dataOfApi['userImage']}',
            weight: '${dataOfApi['weight']}',
            name: '${dataOfApi['name']}');
        if (!isEdit) {
          Get.offAll(BottomNavScreen());
        } else {
          Get.back();
        }
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

  static Future editDailyStepsReport({
    required String calories,
    required String kilometers,
    required String steps,
  }) async {
    var headers = {
      'Authorization': 'Bearer ${GetStorageServices.getBarrierToken()}',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('PUT', Uri.parse('http://52.66.209.219:5000/user/'));
    request.body = json.encode({
      "calories": "$calories",
      "kilometers": "$kilometers",
      "steps": "$steps"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
