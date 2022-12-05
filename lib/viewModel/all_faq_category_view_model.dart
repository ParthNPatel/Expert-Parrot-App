import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/all_faq_category_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/all_faq_category_res_model.dart';
import 'package:get/get.dart';

class AllFaqCategoryViewModel extends GetxController {
  ApiResponse _allFaqCategoryApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get allFaqCategoryApiResponse => _allFaqCategoryApiResponse;

  Future<void> allFaqCategoryViewModel() async {
    _allFaqCategoryApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      AllFaqCategoryResponseModel response =
          await AllFaqCategoryRepo.allFaqCategoryRepo();
      print("AllFaqCategoryResponseModel=response==>$response");

      _allFaqCategoryApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("AllFaqCategoryResponseModel=e==>$e");
      _allFaqCategoryApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
