import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/responseModel/get_all_medicine_names_model.dart';
import 'package:get/get.dart';

import '../repo/get_all_mdicine_names.dart';

class GetAllMedicineNamesList extends GetxController {
  ApiResponse _geAllMedicineNames =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getAllMedicines => _geAllMedicineNames;

  Future<void> getAllMedicineNames() async {
    _geAllMedicineNames = ApiResponse.loading(message: 'Loading');
    update();
    try {
      GetAllMedicineNames response =
          await GetAllMedicineRepo.getAllMedicineNames();
      print("GetCommentResponseModel=response==>$response");

      _geAllMedicineNames = ApiResponse.complete(response);
    } catch (e) {
      print("GetCommentResponseModel=e==>$e");
      _geAllMedicineNames = ApiResponse.error(message: 'error');
    }
    update();
  }
}
