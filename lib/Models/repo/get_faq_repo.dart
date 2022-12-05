import 'package:expert_parrot_app/Models/responseModel/get_faq_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class GetFaqRepo extends BaseService {
  static Future<GetFaqResponseModel> getFaqRepo({required String id}) async {
    var response = await APIService()
        .getResponse(url: APIConst.getFaq + "${id}", apitype: APIType.aGet);
    print('Get FAQ response===>>>  $response');
    GetFaqResponseModel getFaqResponseModel =
        GetFaqResponseModel.fromJson(response);
    return getFaqResponseModel;
  }
}
