import 'package:expert_parrot_app/Models/responseModel/accept_req_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class AcceptRequestRepo extends BaseService {
  static Future<AcceptReqResponseModel> acceptRequestRepo(
      {required Map<String, dynamic> model}) async {
    var response = await APIService().getResponse(
        url: APIConst.acceptRequest, apitype: APIType.aPost, body: model);
    print('acceptReqResponseModel response===>>>  $response');
    AcceptReqResponseModel acceptReqResponseModel =
        AcceptReqResponseModel.fromJson(response);
    return acceptReqResponseModel;
  }
}
