import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/record_medicine_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/record_medicine_res_model.dart';
import 'package:get/get.dart';

class RecordMedicineViewModel extends GetxController {
  ApiResponse _recordMedicineApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get recordMedicineApiResponse => _recordMedicineApiResponse;

  Future<void> recordMedicineViewModel({Map<String, dynamic>? model}) async {
    _recordMedicineApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      RecordMedicineResponseModel response =
          await RecordMedicineRepo.recordMedicineRepo(model: model!);
      print("RecordMedicineResponseModel=response==>$response");

      _recordMedicineApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("RecordMedicineResponseModel=e==>$e");
      _recordMedicineApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
