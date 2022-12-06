import 'package:expert_parrot_app/constant/api_const.dart';

import '../responseModel/get_all_medicine_names_model.dart';
import '../services/api_services.dart';
import '../services/base_service.dart';

class GetAllMedicineRepo extends BaseService {
  static Future<GetAllMedicineNames> getAllMedicineNames() async {
    print('LINK response===>>>  ${APIConst.addMedicine}');

    var response = await APIService().getResponse(
      url: '${APIConst.addMedicine}',
      apitype: APIType.aGet,
    );

    print('GetAllMedicine response===>>>  $response');

    GetAllMedicineNames getAllMedicineNames =
        GetAllMedicineNames.fromJson(response);

    return getAllMedicineNames;
  }
}
