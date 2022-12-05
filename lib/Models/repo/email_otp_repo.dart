import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class EmailOTPRepo extends BaseService {
  static Future<dynamic> emailOTPRepo(
      {required Map<String, dynamic> model}) async {
    var response = await APIService().getResponse(
        url: APIConst.emailOTP, apitype: APIType.aPost, body: model);
    print('EmailOTP response===>>>  $response');
    // AddMedicineResponseModel addMedicineResponseModel =
    // AddMedicineResponseModel.fromJson(response);
    return response;
  }
}
