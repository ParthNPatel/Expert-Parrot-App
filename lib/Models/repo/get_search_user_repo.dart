import 'package:expert_parrot_app/Models/responseModel/gte_search_user_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class GetSearchUserRepo extends BaseService {
  static Future<GetSearchUserResponseModel> getSearchUserRepo(
      {String? name}) async {
    var response = await APIService().getResponse(
      url: APIConst.searchUser + name!,
      apitype: APIType.aGet,
    );
    print('GetSearchUserResponseModel response===>>>  $response');
    GetSearchUserResponseModel getSearchUserResponseModel =
        GetSearchUserResponseModel.fromJson(response);
    return getSearchUserResponseModel;
  }
}
