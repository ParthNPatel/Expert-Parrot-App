import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/like_unlike_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/like_res_model.dart';
import 'package:expert_parrot_app/Models/responseModel/unlike_post_res_model.dart';
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

  ApiResponse _unlikeApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get unlikeApiResponse => _unlikeApiResponse;

  Future<void> unlikeViewModel({Map<String, dynamic>? model}) async {
    _unlikeApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      UnLikePostResponseModel response =
          await LikeUnLikeRepo.removeLikeRepo(model: model!);
      print("UnLikePostResponseModel=response==>$response");

      _unlikeApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("LikeRespoUnLikePostResponseModelnseModel=e==>$e");
      _unlikeApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
