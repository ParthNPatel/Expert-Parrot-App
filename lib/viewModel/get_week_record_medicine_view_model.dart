import 'dart:developer';

import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/get_record_medicine_repo.dart';
import 'package:expert_parrot_app/Models/repo/get_week_record_medicine_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/get_record_medicine_res_model.dart';
import 'package:expert_parrot_app/Models/responseModel/get_week_record_medicine_response_model.dart';
import 'package:get/get.dart';

class GetWeekRecordMedicineViewModel extends GetxController {
  ApiResponse _getWeekRecordMedicineApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getWeekRecordMedicineApiResponse =>
      _getWeekRecordMedicineApiResponse;

  Future<void> getWeekRecordMedicineViewModel(
      {bool? isLoading = true,
      String? page,
      required Map<String, dynamic> body}) async {
    if (isLoading!) {
      _getWeekRecordMedicineApiResponse =
          ApiResponse.loading(message: 'Loading');
    }
    update();
    try {
      GetWeekRecordMedicineResponseModel response =
          await GetWeekRecordMedicineRepo.getWeekRecordMedicineRepo(
              page: page, body: body);
      log("GetWeekRecordMedicineResponseModel=response==>$response");

      _getWeekRecordMedicineApiResponse = ApiResponse.complete(response);
    } catch (e) {
      log("GetWeekRecordMedicineResponseModel=e==>$e");
      _getWeekRecordMedicineApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
