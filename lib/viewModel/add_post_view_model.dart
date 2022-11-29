import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/add_post_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/add_post_res_model.dart';
import 'package:get/get.dart';

class AddPostViewModel extends GetxController {
  ApiResponse _addPostApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get addPostApiResponse => _addPostApiResponse;

  Future<void> addPostViewModel({Map<String, dynamic>? model}) async {
    _addPostApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      AddPostResponseModel response =
          await AddPostRepo.addPostRepo(model: model!);
      print("LogInResponseModel=response==>$response");

      _addPostApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("LogInResponseModel=e==>$e");
      _addPostApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
