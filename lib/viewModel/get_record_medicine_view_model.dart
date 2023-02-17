import 'dart:developer';
import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/get_record_medicine_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/get_record_medicine_res_model.dart';
import 'package:get/get.dart';

class GetRecordMedicineViewModel extends GetxController {
  ApiResponse _getRecordMedicineApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getRecordMedicineApiResponse => _getRecordMedicineApiResponse;

  Future<void> getRecordMedicineViewModel(
      {bool? isLoading = true, String? page, String dependentId = ""}) async {
    if (isLoading!) {
      _getRecordMedicineApiResponse = ApiResponse.loading(message: 'Loading');
    }
    update();
    try {
      GetRecordMedicineResponseModel response =
          await GetRecordMedicineRepo.getRecordMedicineRepo(
              page: page, dependentId: dependentId);
      log("GetRecordMedicineResponseModel=response==>$response");

      _getRecordMedicineApiResponse = ApiResponse.complete(response);
    } catch (e) {
      log("GetRecordMedicineResponseModel=e==>$e");
      _getRecordMedicineApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
