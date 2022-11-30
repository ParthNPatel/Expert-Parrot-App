import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/get_video_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/get_video_res_model.dart';
import 'package:expert_parrot_app/Models/responseModel/video_like_res_model.dart';
import 'package:get/get.dart';

class GetVideoViewModel extends GetxController {
  ApiResponse _getVideoApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getVideoApiResponse => _getVideoApiResponse;

  Future<void> getVideoViewModel({bool isLoading = true}) async {
    if (isLoading) {
      _getVideoApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      GetVideoResponseModel response = await GetVideoRepo.getVideoRepo();
      print("GetVideoResponseModel=response==>$response");

      _getVideoApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("GetVideoResponseModel=e==>$e");
      _getVideoApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// LIKE VIDEO
  ///

  bool like = false;
  void likeUnlike(bool value) {
    like = value;
    update();
  }

  ApiResponse _videoLikeApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get videoLikeApiResponse => _videoLikeApiResponse;

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
}
