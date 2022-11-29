import 'package:expert_parrot_app/Models/responseModel/add_postn_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class AddPostRepo extends BaseService {
  static Future<AddPostResponseModel> addPostUserRepo(
      {required Map<String, dynamic> model}) async {
    var response = await APIService().getResponse(
        url: APIConst.getPosts, apitype: APIType.aPost, body: model);
    print('AddPost response===>>>  $response');
    AddPostResponseModel addPostResponseModel =
        AddPostResponseModel.fromJson(response);
    return addPostResponseModel;
  }
}
