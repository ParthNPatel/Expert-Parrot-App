import 'dart:developer';

import 'package:expert_parrot_app/Models/responseModel/get_glass_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class GetGlassRepo extends BaseService {
  static Future<GetGlassResponseModel> getGlassRepo(
      {String userId = ""}) async {
    log("Glass response ============== > ${APIConst.glass + "?page=1&limit=10&dependentId=${userId}"}");
    var response = await APIService().getResponse(
        url: APIConst.glass + "?page=1&limit=10&dependentId=${userId}",
        apitype: APIType.aGet);
    log('Glass response===>>>  $response');
    GetGlassResponseModel getGlassResponseModel =
        GetGlassResponseModel.fromJson(response);
    return getGlassResponseModel;
  }
}
