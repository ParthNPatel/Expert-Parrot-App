import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/add_comment_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/add_comment_res_model.dart';
import 'package:get/get.dart';

class AddCommentViewModel extends GetxController {
  ApiResponse _addCommentApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get addCommentApiResponse => _addCommentApiResponse;

  Future<void> addCommentViewModel({Map<String, dynamic>? model}) async {
    _addCommentApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      AddCommentResponseModel response =
          await AddCommentRepo.addCommentRepo(model: model!);
      print("AddCommentResponseModel=response==>$response");

      _addCommentApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("AddCommentResponseModel=e==>$e");
      _addCommentApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
