import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/get_glass_repo.dart';
import 'package:get/get.dart';

import '../Models/responseModel/get_glass_res_model.dart';

class GetGlassViewModel extends GetxController {
  ApiResponse _getGlassApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getGlassApiResponse => _getGlassApiResponse;

  Future<void> getGlassViewModel(
      {bool? isLoading = true, String? userId}) async {
    if (isLoading!) {
      _getGlassApiResponse = ApiResponse.loading(message: 'Loading');
    }
    update();
    try {
      GetGlassResponseModel response =
          await GetGlassRepo.getGlassRepo(userId: userId ?? "");
      print("GetGlassResponseModel=response==>$response");

      _getGlassApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("GetGlassResponseModel=e==>$e");
      _getGlassApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
