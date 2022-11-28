import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/user_data_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/user_data_res_model.dart';
import 'package:get/get.dart';

class UserDataViewModel extends GetxController {
  ApiResponse _userDataApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get userDataApiResponse => _userDataApiResponse;

  Future<void> userDataViewModel() async {
    _userDataApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      UserDataResponseModel response = await UserDataRepo.userDataRepo();
      print("UserDataResponseModel=response==>$response");

      _userDataApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("UserDataResponseModel=e==>$e");
      _userDataApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
