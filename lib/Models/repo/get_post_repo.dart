import 'package:expert_parrot_app/Models/responseModel/get_post_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class GetPostRepo extends BaseService {
  static Future<GetPostResponseModel> getPostRepo() async {
    var response = await APIService().getResponse(
      url: APIConst.getPosts + "?latest=true",
      apitype: APIType
          .aGet, /*header: {"Token": "${GetStorageServices.getBarrierToken()}"}*/
    );
    print('Post response===>>>  $response');
    GetPostResponseModel getPostResponseModel =
        GetPostResponseModel.fromJson(response);
    return getPostResponseModel;
  }
}
