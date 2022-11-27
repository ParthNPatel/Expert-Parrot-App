// import 'package:meyaoo_app/Models/requestModel/view_chat_req_model.dart';
// import 'package:meyaoo_app/Models/responseModel/view_chat_response_model.dart';
//
// import '../services/api_services.dart';
// import '../services/base_service.dart';
//
// class ViewChatRepo extends BaseService {
//   Future<ViewChatResponseModel> getViewChatRepo(
//       {required ViewChatReqModel model}) async {
//     var response = await APIService().getResponse(
//         url: viewChat, apitype: APIType.aPost, body: model.toJson());
//     print('response  $response');
//     ViewChatResponseModel viewChatResponseModel =
//         ViewChatResponseModel.fromJson(response);
//     print('istYpinjbfjd ${viewChatResponseModel.message}');
//     return viewChatResponseModel;
//   }
// }
