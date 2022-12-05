import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class DeleteMedicineRepo extends BaseService {
  static Future<dynamic> deleteMedicineRepo({String? id}) async {
    var response = await APIService().getResponse(
      url: APIConst.removeMedicine + "$id",
      apitype: APIType.aGet,
    );
    print('DeleteMedicineResponseModel response===>>>  $response');

    return response;
  }
}
