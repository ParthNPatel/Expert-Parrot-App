import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/get_video_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/unlike_video_res_model.dart';
import 'package:expert_parrot_app/Models/responseModel/video_like_res_model.dart';
import 'package:get/get.dart';

class LikeUnLikeVideoViewModel extends GetxController {
  /// LIKE API

  ApiResponse _videoLikeApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get videoUnLikeApiResponse => _videoLikeApiResponse;

  Future<void> videoLikeViewModel({Map<String, dynamic>? model}) async {
    _videoLikeApiResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      VideoLikeResponseModel response =
          await GetVideoRepo.videoLikeRepo(model: model);
      print("VideoLikeResponseModel=response==>$response");

      _videoLikeApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("VideoLikeResponseModel=e==>$e");
      _videoLikeApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// UNLIKE VIDEO
  ApiResponse _videoUnLikeApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get videoLikeApiResponse => _videoUnLikeApiResponse;

  Future<void> videoUnLikeViewModel({Map<String, dynamic>? model}) async {
    _videoUnLikeApiResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      UnLikeVideoResponseModel response =
          await GetVideoRepo.videoUnLikeRepo(model: model);
      print("UnLikeVideoResponseModel=response==>$response");

      _videoUnLikeApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("UnLikeVideoResponseModel=e==>$e");
      _videoUnLikeApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  var isLike = false;
  updateLike(bool value) {
    isLike = value;
    update();
  }

  var likeCount = 0;

  enterValue(int val) {
    likeCount = val;
  }

  incriment() {
    likeCount++;
    update();
  }

  dicriment() {
    likeCount--;
    update();
  }
}
