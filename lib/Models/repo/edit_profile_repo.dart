import 'package:expert_parrot_app/Models/responseModel/edit_profile_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';
import 'package:expert_parrot_app/get_storage_services/get_storage_service.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class EditProfileRepo extends BaseService {
  static Future<EditProfileResponseModel> editProfileRepo(
      {required Map<String, dynamic> model}) async {
    print('getBarrierToken   ${GetStorageServices.getBarrierToken()}');

    var response = await APIService().getPutResponse(
        url: APIConst.userData, apitype: APIType.aPut, body: model);
    print('EditProfile response===>>>  $response');
    EditProfileResponseModel editProfileResponseModel =
        EditProfileResponseModel.fromJson(response);

    return editProfileResponseModel;
  }
}
