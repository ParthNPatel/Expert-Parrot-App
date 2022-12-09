import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/date_medicine_record_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/date_record_medicine_res_model.dart';
import 'package:get/get.dart';

class DateMedicineRecordViewModel extends GetxController {
  ApiResponse _dateMedicineRecordApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get dateMedicineRecordApiResponse =>
      _dateMedicineRecordApiResponse;

  Future<void> dateMedicineRecordViewModel(
      {Map<String, dynamic>? model, bool isLoading = false}) async {
    if (isLoading) {
      _dateMedicineRecordApiResponse = ApiResponse.loading(message: 'Loading');
    }
    // update();
    try {
      DateMedicineRecordResponseModel response =
          await DateMedicineRecordRepo.dateMedicineRecordRepo(model: model!);
      print("DateMedicineRecordResponseModel=response==>$response");

      _dateMedicineRecordApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("DateMedicineRecordResponseModel=e==>$e");
      _dateMedicineRecordApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
