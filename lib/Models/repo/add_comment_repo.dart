import 'package:expert_parrot_app/Models/responseModel/add_comment_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class AddCommentRepo extends BaseService {
  static Future<AddCommentResponseModel> addCommentRepo(
      {required Map<String, dynamic> model}) async {
    var response = await APIService().getResponse(
        url: APIConst.addComment, apitype: APIType.aPost, body: model);
    print('AddCommentResponseModel response===>>>  $response');
    AddCommentResponseModel addCommentResponseModel =
        AddCommentResponseModel.fromJson(response);
    return addCommentResponseModel;
  }
}
