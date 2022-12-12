import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/get_heart_rate_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/get_heart_rate_res_model.dart';
import 'package:get/get.dart';

class GetHeartRateViewModel extends GetxController {
  ApiResponse _getHeartRateApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getHeartRateApiResponse => _getHeartRateApiResponse;

  Future<void> getHeartRateViewModel({bool isLoading = true}) async {
    if (isLoading) {
      _getHeartRateApiResponse = ApiResponse.loading(message: 'Loading');
    }
    // update();
    try {
      GetHeartRateResponseModel response =
          await GetHeartRateRepo.getHeartRateRepo();
      print("GetHeartRateResponseModel=response==>$response");

      _getHeartRateApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("GetHeartRateResponseModel=e==>$e");
      _getHeartRateApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
