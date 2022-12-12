import 'package:expert_parrot_app/Models/responseModel/get_all_post_categories_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class GetAllPostCategoriesRepo extends BaseService {
  static Future<GetAllPostCategoriesResponseModel>
      getAllPostCategoriesRepo() async {
    print('LINK response===>>>  ${APIConst.addMedicine}');

    var response = await APIService().getResponse(
        url: '${APIConst.getAllPostCategories}', apitype: APIType.aGet);

    print('GetAllPostCategories response===>>>  $response');

    GetAllPostCategoriesResponseModel getAllPostCategoriesResponseModel =
        GetAllPostCategoriesResponseModel.fromJson(response);

    return getAllPostCategoriesResponseModel;
  }
}
