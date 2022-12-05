import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class GetDependentRepo extends BaseService {
  static Future<dynamic> getDependentRepo() async {
    var response = await APIService().getResponse(
      url: APIConst.dependent,
      apitype: APIType.aGet,
    );
    print('GetDependentResponseModel response===>>>  $response');

    return response;
  }
}
