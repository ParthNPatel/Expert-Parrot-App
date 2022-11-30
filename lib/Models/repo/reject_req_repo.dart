import 'package:expert_parrot_app/Models/responseModel/reject_req_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class RejectRequestRepo extends BaseService {
  static Future<RejectReqResponseModel> rejectRequestRepo(
      {required Map<String, dynamic> model}) async {
    var response = await APIService().getResponse(
        url: APIConst.rejectRequest, apitype: APIType.aPost, body: model);
    print('RejectReqResponseModel response===>>>  $response');
    RejectReqResponseModel rejectReqResponseModel =
        RejectReqResponseModel.fromJson(response);
    return rejectReqResponseModel;
  }
}
