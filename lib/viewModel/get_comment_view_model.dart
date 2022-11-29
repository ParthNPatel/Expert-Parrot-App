import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/get_comment_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/get_comment_res_model.dart';
import 'package:get/get.dart';

class GetCommentViewModel extends GetxController {
  ApiResponse _getCommentApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getCommentApiResponse => _getCommentApiResponse;

  Future<void> getCommentViewModel({String? id}) async {
    _getCommentApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      GetCommentResponseModel response =
          await GetCommentRepo.getCommentRepo(id: id!);
      print("GetCommentResponseModel=response==>$response");

      _getCommentApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("GetCommentResponseModel=e==>$e");
      _getCommentApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
