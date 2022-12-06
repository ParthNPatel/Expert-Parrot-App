import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/add_record_medicine_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/add_record_medicine_res_model.dart';
import 'package:get/get.dart';

class AddRecordMedicineViewModel extends GetxController {
  ApiResponse _addRecordMedicineApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get addRecordMedicineApiResponse => _addRecordMedicineApiResponse;

  Future<void> addRecordMedicineViewModel({Map<String, dynamic>? model}) async {
    _addRecordMedicineApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      AddRecordMedicineResponseModel response =
          await AddRecordMedicineRepo.addRecordMedicineRepo(model: model!);
      print("AddRecordMedicineResponseModel=response==>$response");

      _addRecordMedicineApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("AddRecordMedicineResponseModel=e==>$e");
      _addRecordMedicineApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
