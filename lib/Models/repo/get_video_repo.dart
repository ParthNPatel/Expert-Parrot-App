import 'package:expert_parrot_app/Models/responseModel/get_video_res_model.dart';
import 'package:expert_parrot_app/Models/responseModel/video_like_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class GetVideoRepo extends BaseService {
  static Future<GetVideoResponseModel> getVideoRepo() async {
    var response = await APIService()
        .getResponse(url: APIConst.video, apitype: APIType.aGet);
    print('EditProfile response===>>>  $response');
    GetVideoResponseModel getVideoResponseModel =
        GetVideoResponseModel.fromJson(response);
    return getVideoResponseModel;
  }

  static Future<VideoLikeResponseModel> videoLikeRepo(
      {Map<String, dynamic>? model}) async {
    var response = await APIService().getResponse(
        url: APIConst.videoLike, apitype: APIType.aPost, body: model);
    print('VideoLikeResponseModel response===>>>  $response');
    print('MODEL response===>>>  $model');
    VideoLikeResponseModel videoLikeResponseModel =
        VideoLikeResponseModel.fromJson(response);
    return videoLikeResponseModel;
  }
}
