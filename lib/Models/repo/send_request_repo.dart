import 'package:expert_parrot_app/Models/responseModel/send_req_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class SendRequestRepo extends BaseService {
  static Future<SendReqResponseModel> sendRequestRepo(
      {required Map<String, dynamic> model}) async {
    var response = await APIService().getResponse(
        url: APIConst.sendRequest, apitype: APIType.aPost, body: model);
    print('vSendReqResponseModel response===>>>  $response');
    SendReqResponseModel sendReqResponseModel =
        SendReqResponseModel.fromJson(response);
    return sendReqResponseModel;
  }
}
