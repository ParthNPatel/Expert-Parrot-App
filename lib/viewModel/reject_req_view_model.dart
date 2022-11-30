import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/reject_req_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/reject_req_res_model.dart';
import 'package:get/get.dart';

class RejectRequestViewModel extends GetxController {
  ApiResponse _rejectReqUserResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get rejectReqUserResponse => _rejectReqUserResponse;

  Future<void> rejectRequestViewModel({Map<String, dynamic>? model}) async {
    _rejectReqUserResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      RejectReqResponseModel response =
          await RejectRequestRepo.rejectRequestRepo(model: model!);
      print("RejectReqResponseModel=response==>$response");

      _rejectReqUserResponse = ApiResponse.complete(response);
    } catch (e) {
      print("RejectReqResponseModel=e==>$e");
      _rejectReqUserResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
