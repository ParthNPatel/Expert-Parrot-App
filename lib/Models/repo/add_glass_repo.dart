import 'package:expert_parrot_app/Models/responseModel/add_glass_res_model.dart';
import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/constant/api_const.dart';
import 'package:expert_parrot_app/get_storage_services/get_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class AddGlassRepo extends BaseService {
  static Future<AddGlassResponseModel> addGlassRepo(
      {required Map<String, dynamic> model}) async {
    var response = await APIService()
        .getResponse(url: APIConst.glass, apitype: APIType.aPost, body: model);
    print('AddMedicine response===>>>  $response');
    dynamic addGlassResponseModel = AddGlassResponseModel.fromJson(response);
    return addGlassResponseModel;
  }
}

//
// import 'package:expert_parrot_app/constant/api_const.dart';
// import 'package:expert_parrot_app/view/set_profile_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../components/common_widget.dart';
// import '../../get_storage_services/get_storage_service.dart';
// import '../../view/bottom_nav_screen.dart';
// import '../services/api_services.dart';
// import '../services/base_service.dart';

class AddGlassRepo1 extends BaseService {
  static Future addGlassRepo({
    required Map<String, dynamic> model,
    TextEditingController? addGlass,
  }) async {
    try {
      // progress.show();
      var response = await APIService().getResponse(
          url: APIConst.glass, apitype: APIType.aPost, body: model);
      print('ADD GLASS response===>>>  $response');
      print('FLAG===>>>  ${response['flag']}');

      if (response['flag'] == true) {
        Get.back();

        await GetStorageServices.setUserWater(
            (GetStorageServices.getUserWater() == null
                    ? 0
                    : GetStorageServices.getUserWater()) +
                int.parse(addGlass!.text));
        addGlass.clear();

        CommonWidget.getSnackBar(
          message: 'Added Successfully',
          title: 'Done',
          duration: 2,
          color: Colors.green,
        );
      } else {
        CommonWidget.getSnackBar(
          message: '',
          title: 'Failed1',
          duration: 2,
          color: Colors.red,
        );
      }
    } catch (e) {
      CommonWidget.getSnackBar(
        message: '',
        title: 'Failed',
        duration: 2,
        color: Colors.red,
      );
    }
  }
}
