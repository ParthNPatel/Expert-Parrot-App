import 'package:expert_parrot_app/Models/responseModel/get_reminder_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class GetReminderRepo extends BaseService {
  static Future<GetReminderResponseModel> getReminderRepo(
      {String? limit, String? page}) async {
    var response = await APIService().getResponse(
      url: '${APIConst.getReminder}limit=$limit&page=$page',
      apitype: APIType.aGet,
    );
    print('getReminderResponseModel response===>>>  $response');
    GetReminderResponseModel getReminderResponseModel =
        GetReminderResponseModel.fromJson(response);
    return getReminderResponseModel;
  }
}
