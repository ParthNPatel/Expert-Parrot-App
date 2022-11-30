import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/get_search_user_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/gte_search_user_res_model.dart';
import 'package:get/get.dart';

class GetSearchUserViewModel extends GetxController {
  ApiResponse _getUserResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get getUserResponse => _getUserResponse;

  Future<void> getSearchUserViewModel({String name = ''}) async {
    _getUserResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      GetSearchUserResponseModel response =
          await GetSearchUserRepo.getSearchUserRepo(name: name);
      print("GetSearchUserResponseModel=response==>$response");

      _getUserResponse = ApiResponse.complete(response);
    } catch (e) {
      print("GetSearchUserResponseModel=e==>$e");
      _getUserResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
