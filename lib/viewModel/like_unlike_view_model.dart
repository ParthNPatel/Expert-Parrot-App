import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/like_unlike_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/like_res_model.dart';
import 'package:get/get.dart';

class LikeUnLikeViewModel extends GetxController {
  /// LIKE API
  ApiResponse _likeApiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get likeApiResponse => _likeApiResponse;

  Future<void> likeViewModel({Map<String, dynamic>? model}) async {
    _likeApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      LikeResponseModel response =
          await LikeUnLikeRepo.giveLikeRepo(model: model!);
      print("LikeResponseModel=response==>$response");

      _likeApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("LikeResponseModel=e==>$e");
      _likeApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// UNLIKE API
}
