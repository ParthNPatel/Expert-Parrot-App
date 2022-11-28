import 'package:expert_parrot_app/Models/responseModel/like_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class LikeUnLikeRepo extends BaseService {
  static Future<LikeResponseModel> giveLikeRepo(
      {required Map<String, dynamic> model}) async {
    var response = await APIService().getResponse(
        url: APIConst.postLike, apitype: APIType.aPost, body: model);
    print('LikeResponseModel response===>>>  $response');
    LikeResponseModel likeResponseModel = LikeResponseModel.fromJson(response);
    return likeResponseModel;
  }
}
