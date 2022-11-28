import 'package:expert_parrot_app/Models/responseModel/user_data_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class UserDataRepo extends BaseService {
  static Future<UserDataResponseModel> userDataRepo() async {
    var response = await APIService()
        .getResponse(url: APIConst.userData, apitype: APIType.aGet);
    print('UserData response===>>>  $response');
    UserDataResponseModel userDataResponseModel =
        UserDataResponseModel.fromJson(response);
    return userDataResponseModel;
  }
}
