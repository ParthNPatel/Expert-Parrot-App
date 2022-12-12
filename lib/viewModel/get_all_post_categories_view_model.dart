import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/get_all_post_categories_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/get_all_post_categories_res_model.dart';
import 'package:get/get.dart';

class GetAllPostCategoriesViewModel extends GetxController {
  ApiResponse _getAllPostCategoriesApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getAllPostCategoriesApiResponse =>
      _getAllPostCategoriesApiResponse;

  Future<void> getAllPostCategoriesViewModel(
      {Map<String, dynamic>? model, bool isLoading = false}) async {
    if (isLoading) {
      _getAllPostCategoriesApiResponse =
          ApiResponse.loading(message: 'Loading');
    }
    // update();
    try {
      GetAllPostCategoriesResponseModel response =
          await GetAllPostCategoriesRepo.getAllPostCategoriesRepo();
      print("GetAllPostCategoriesResponseModel=response==>$response");

      _getAllPostCategoriesApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("GetAllPostCategoriesResponseModel=e==>$e");
      _getAllPostCategoriesApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
