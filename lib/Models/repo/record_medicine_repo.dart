import 'package:expert_parrot_app/Models/responseModel/record_medicine_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class RecordMedicineRepo extends BaseService {
  static Future<RecordMedicineResponseModel> recordMedicineRepo(
      {required Map<String, dynamic> model}) async {
    var response = await APIService().getResponse(
        url: APIConst.recordMedicine, apitype: APIType.aPost, body: model);
    print('RecordMedicineResponseModel response===>>> $response');

    RecordMedicineResponseModel recordMedicineResponseModel =
        RecordMedicineResponseModel.fromJson(response);

    return recordMedicineResponseModel;
  }
}
