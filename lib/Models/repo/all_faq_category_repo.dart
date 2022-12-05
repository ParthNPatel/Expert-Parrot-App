import 'package:expert_parrot_app/Models/responseModel/all_faq_category_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class AllFaqCategoryRepo extends BaseService {
  static Future<AllFaqCategoryResponseModel> allFaqCategoryRepo() async {
    var response = await APIService()
        .getResponse(url: APIConst.allCategory, apitype: APIType.aGet);
    print('All FAQ response===>>>  $response');
    AllFaqCategoryResponseModel allFaqCategoryResponseModel =
        AllFaqCategoryResponseModel.fromJson(response);
    return allFaqCategoryResponseModel;
  }
}
