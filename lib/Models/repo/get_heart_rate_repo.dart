import 'package:expert_parrot_app/Models/responseModel/get_heart_rate_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class GetHeartRateRepo extends BaseService {
  static Future<GetHeartRateResponseModel> getHeartRateRepo(
      {String? userId}) async {
    print('LINK response===>>>  ${APIConst.addMedicine}');

    var response = await APIService().getResponse(
        url: '${APIConst.heartRate}?dependentId=$userId',
        apitype: APIType.aGet);

    print('GetHeartRate response===>>>  $response');

    GetHeartRateResponseModel getHeartRateResponseModel =
        GetHeartRateResponseModel.fromJson(response);

    return getHeartRateResponseModel;
  }
}
