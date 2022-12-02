import 'package:expert_parrot_app/Models/responseModel/add_glass_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class AddGlassRepo extends BaseService {
  static Future<AddGlassResponseModel> addGlassRepo(
      {required Map<String, dynamic> model}) async {
    var response = await APIService()
        .getResponse(url: APIConst.glass, apitype: APIType.aPost, body: model);
    print('AddMedicine response===>>>  $response');
    AddGlassResponseModel addGlassResponseModel =
        AddGlassResponseModel.fromJson(response);
    return addGlassResponseModel;
  }
}
