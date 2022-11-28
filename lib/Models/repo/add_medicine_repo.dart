import 'package:expert_parrot_app/Models/responseModel/add_medicine_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class AddMedicineRepo extends BaseService {
  static Future<AddMedicineResponseModel> addMedicineRepo(
      {required Map<String, dynamic> model}) async {
    var response = await APIService().getResponse(
        url: APIConst.addMedicine, apitype: APIType.aPost, body: model);
    print('AddMedicine response===>>>  $response');
    AddMedicineResponseModel addMedicineResponseModel =
        AddMedicineResponseModel.fromJson(response);
    return addMedicineResponseModel;
  }
}
