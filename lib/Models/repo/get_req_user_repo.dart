import 'package:expert_parrot_app/Models/responseModel/get_req_user_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class GetRequestUserRepo extends BaseService {
  static Future<GetReqResponseModel> getRequestUserRepo() async {
    var response = await APIService().getResponse(
      url: APIConst.getReqUser,
      apitype: APIType.aGet,
    );
    print('GetReqResponseModel response===>>>  $response');
    GetReqResponseModel getReqResponseModel =
        GetReqResponseModel.fromJson(response);
    return getReqResponseModel;
  }
}
