import 'package:expert_parrot_app/Models/requestModel/login_req_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';
import '../services/api_services.dart';
import '../services/base_service.dart';

class LoginRepo extends BaseService {
  static Future loginUserRepo({required LoginReqModel model}) async {
    var response = await APIService().getResponse(
        url: APIConst.baseUrl + APIConst.loginUrl,
        apitype: APIType.aPost,
        body: model.toJson());
    print('Login response===>>>  $response');
    //LoginReqModel loginReqModel = LoginReqModel.fromJson(response);
    // return loginReqModel;
  }
}
