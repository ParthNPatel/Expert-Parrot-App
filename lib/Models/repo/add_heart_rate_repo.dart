import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class AddHeartRateRepo extends BaseService {
  static Future<void> addHeartRateRepo(
      {required Map<String, dynamic> model}) async {
    var response = await APIService().getResponse(
        url: APIConst.heartRate, apitype: APIType.aPost, body: model);
    print('AddHeartRate response===>>>  $response');
  }
}
