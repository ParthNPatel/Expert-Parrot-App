import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/get_req_user_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/get_req_user_res_model.dart';
import 'package:get/get.dart';

class GetRequestUserViewModel extends GetxController {
  ApiResponse _getReqUserResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getReqUserResponse => _getReqUserResponse;

  Future<void> getRequestUserViewModel({bool? isLoading = true}) async {
    if (isLoading!) {
      _getReqUserResponse = ApiResponse.loading(message: 'Loading');
    }
    update();
    try {
      GetReqResponseModel response =
          await GetRequestUserRepo.getRequestUserRepo();
      print("GetReqResponseModel=response==>$response");

      _getReqUserResponse = ApiResponse.complete(response);
    } catch (e) {
      print("GetReqResponseModel=e==>$e");
      _getReqUserResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
