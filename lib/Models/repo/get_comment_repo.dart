import 'package:expert_parrot_app/Models/responseModel/get_comment_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class GetCommentRepo extends BaseService {
  static Future<GetCommentResponseModel> getCommentRepo(
      {required String id}) async {
    print('LINK response===>>>  ${APIConst.getComment}$id');

    var response = await APIService().getResponse(
      url: '${APIConst.getComment}$id',
      apitype: APIType.aGet,
    );
    print('GetCommentResponseModel response===>>>  $response');
    GetCommentResponseModel getCommentResponseModel =
        GetCommentResponseModel.fromJson(response);
    return getCommentResponseModel;
  }
}
