import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/get_faq_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/get_faq_res_model.dart';
import 'package:get/get.dart';

class GetFaqViewModel extends GetxController {
  ApiResponse _getFaqApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getFaqApiResponse => _getFaqApiResponse;

  Future<void> getFaqViewModel({required String id}) async {
    _getFaqApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      GetFaqResponseModel response = await GetFaqRepo.getFaqRepo(id: id);
      print("GetFaqResponseModel=response==>$response");

      _getFaqApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("GetFaqResponseModel=e==>$e");
      _getFaqApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
