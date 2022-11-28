import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/add_medicine_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/add_medicine_res_model.dart';
import 'package:get/get.dart';

class AddMedicineViewModel extends GetxController {
  ApiResponse _addMedicineApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get addMedicineApiResponse => _addMedicineApiResponse;

  Future<void> addMedicineViewModel({Map<String, dynamic>? model}) async {
    _addMedicineApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      AddMedicineResponseModel response =
          await AddMedicineRepo.addMedicineRepo(model: model!);
      print("LogInResponseModel=response==>$response");

      _addMedicineApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("LogInResponseModel=e==>$e");
      _addMedicineApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
