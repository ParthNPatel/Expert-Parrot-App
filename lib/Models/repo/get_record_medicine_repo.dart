import 'package:expert_parrot_app/Models/responseModel/get_record_medicine_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class GetRecordMedicineRepo extends BaseService {
  static Future<GetRecordMedicineResponseModel> getRecordMedicineRepo(
      {String? page}) async {
    var response = await APIService().getResponse(
      url: APIConst.recordMedicine + "?limit=7&page=0",
      apitype: APIType.aGet,
    );
    print('GetRecordMedicineRepo response===>>>  $response');
    GetRecordMedicineResponseModel getRecordMedicineResponseModel =
        GetRecordMedicineResponseModel.fromJson(response);
    return getRecordMedicineResponseModel;
  }
}
