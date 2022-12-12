import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/get_post_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/get_post_res_model.dart';
import 'package:get/get.dart';

class GetPostViewModel extends GetxController {
  ApiResponse _getPostApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getPostApiResponse => _getPostApiResponse;

  Future<void> getPostViewModel({bool? isLoading = true, String? catId}) async {
    if (isLoading!) {
      _getPostApiResponse = ApiResponse.loading(message: 'Loading');
    }
    update();
    try {
      GetPostResponseModel response =
          await GetPostRepo.getPostRepo(catId: catId);
      print("GetPostResponseModel=response==>$response");

      _getPostApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("GetPostResponseModel=e==>$e");
      _getPostApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
