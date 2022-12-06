import 'package:expert_parrot_app/Models/responseModel/add_record_medicine_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class AddRecordMedicineRepo extends BaseService {
  static Future<AddRecordMedicineResponseModel> addRecordMedicineRepo(
      {required Map<String, dynamic> model}) async {
    var response = await APIService().getResponse(
        url: APIConst.recordMedicine, apitype: APIType.aPost, body: model);
    print('RecordMedicineResponseModel response===>>> $response');

    AddRecordMedicineResponseModel addRecordMedicineResponseModel =
        AddRecordMedicineResponseModel.fromJson(response);

    return addRecordMedicineResponseModel;
  }
}
