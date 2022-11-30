import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/accept_req_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/accept_req_res_model.dart';
import 'package:get/get.dart';

class AcceptRequestViewModel extends GetxController {
  ApiResponse _acceptReqUserResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get acceptReqUserResponse => _acceptReqUserResponse;

  Future<void> acceptRequestViewModel({Map<String, dynamic>? model}) async {
    _acceptReqUserResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      AcceptReqResponseModel response =
          await AcceptRequestRepo.acceptRequestRepo(model: model!);
      print("AcceptReqResponseModel=response==>$response");

      _acceptReqUserResponse = ApiResponse.complete(response);
    } catch (e) {
      print("AcceptReqResponseModel=e==>$e");
      _acceptReqUserResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
