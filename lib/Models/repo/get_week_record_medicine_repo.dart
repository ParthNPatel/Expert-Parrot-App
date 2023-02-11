import 'dart:developer';

import 'package:expert_parrot_app/Models/responseModel/get_record_medicine_res_model.dart';
import 'package:expert_parrot_app/Models/responseModel/get_week_record_medicine_response_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class GetWeekRecordMedicineRepo extends BaseService {
  static Future<GetWeekRecordMedicineResponseModel> getWeekRecordMedicineRepo(
      {String? page,
      required Map<String, dynamic> body,
      isForDependent = false,
      String? dependentId}) async {
    log("body ====== > ${body}");

    var response = await APIService().getResponse(
        url: isForDependent == true
            ? "${APIConst.weekRecordMedicine}?dependentId=$dependentId"
            : APIConst.weekRecordMedicine,
        apitype: APIType.aPost,
        body: body);
    print('GetWeekRecordMedicineRepo response===>>>  $response');
    GetWeekRecordMedicineResponseModel getWeekRecordMedicineResponseModel =
        GetWeekRecordMedicineResponseModel.fromJson(response);
    return getWeekRecordMedicineResponseModel;
  }
}
