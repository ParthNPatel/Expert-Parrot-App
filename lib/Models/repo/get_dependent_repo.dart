import 'package:expert_parrot_app/Models/responseModel/dependents_response_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class GetDependentRepo extends BaseService {
  static Future<DependentsResponseModel> getDependentRepo() async {
    var response = await APIService()
        .getResponse(url: APIConst.dependent, apitype: APIType.aGet);
    print('GetDependentResponseModel response===>>>  $response');

    DependentsResponseModel dependentsResponseModel =
        DependentsResponseModel.fromJson(response);

    return dependentsResponseModel;
  }
}
