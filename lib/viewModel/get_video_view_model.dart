import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/get_video_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/get_video_res_model.dart';
import 'package:get/get.dart';

class GetVideoViewModel extends GetxController {
  ApiResponse _getVideoApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getVideoApiResponse => _getVideoApiResponse;

  Future<void> getVideoViewModel({bool isLoading = true}) async {
    if (isLoading) {
      _getVideoApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      GetVideoResponseModel response = await GetVideoRepo.getVideoRepo();
      print("LogInResponseModel=response==>$response");

      _getVideoApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("LogInResponseModel=e==>$e");
      _getVideoApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
