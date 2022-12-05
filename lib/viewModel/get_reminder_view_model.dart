import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/get_reminder_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/get_reminder_res_model.dart';
import 'package:get/get.dart';

class GetReminderViewModel extends GetxController {
  ApiResponse _getReminderApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getReminderApiResponse => _getReminderApiResponse;

  Future<void> getReminderViewModel(
      {String page = '1', String limit = '10'}) async {
    _getReminderApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      GetReminderResponseModel response =
          await GetReminderRepo.getReminderRepo(limit: limit, page: page);
      print("GetReminderResponseModel=response==>$response");

      _getReminderApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("GetReminderResponseModel=e==>$e");
      _getReminderApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
