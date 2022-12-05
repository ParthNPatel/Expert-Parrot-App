import 'package:expert_parrot_app/Models/responseModel/log_in_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import 'package:expert_parrot_app/view/set_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/common_widget.dart';
import '../../get_storage_services/get_storage_service.dart';
import '../../view/bottom_nav_screen.dart';
import '../services/api_services.dart';
import '../services/base_service.dart';

class LoginRepo extends BaseService {
  static Future<LogInResponseModel> loginUserRepo(
      {required Map<String, dynamic> model}) async {
    var response = await APIService().getResponse(
        url: APIConst.loginUrl, apitype: APIType.aPost, body: model);
    print('Login response===>>>  $response');
    LogInResponseModel logInResponseModel =
        LogInResponseModel.fromJson(response);
    return logInResponseModel;
  }
}
