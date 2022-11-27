import 'package:expert_parrot_app/Models/responseModel/log_in_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

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
