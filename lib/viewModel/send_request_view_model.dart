import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/send_request_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/send_req_res_model.dart';
import 'package:get/get.dart';

class SendReqViewModel extends GetxController {
  ApiResponse _sendReqApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get sendReqApiResponse => _sendReqApiResponse;

  Future<void> sendReqViewModel({Map<String, dynamic>? model}) async {
    _sendReqApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      SendReqResponseModel response =
          await SendRequestRepo.sendRequestRepo(model: model!);
      print("SendReqResponseModel=response==>$response");

      _sendReqApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("SendReqResponseModel=e==>$e");
      _sendReqApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
