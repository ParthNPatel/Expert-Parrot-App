import 'package:expert_parrot_app/Models/responseModel/get_comment_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';
import '../responseModel/get_all_medicine_names_model.dart';
import '../services/api_services.dart';
import '../services/base_service.dart';

class GetAllMedicineRepo extends BaseService {
  static Future<GetAllMedicineNames> getAllMedicineNames() async {
    print('LINK response===>>>  ${APIConst.getAllMedicineNames}');

    var response = await APIService().getResponse(
      url: '${APIConst.getAllMedicineNames}',
      apitype: APIType.aGet,
    );

    print('GetAllMedicine response===>>>  $response');

    GetAllMedicineNames getAllMedicineNames =
        GetAllMedicineNames.fromJson(response);

    return getAllMedicineNames;
  }
}
