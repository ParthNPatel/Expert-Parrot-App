import 'dart:developer';

import 'package:expert_parrot_app/Models/responseModel/date_record_medicine_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';

import '../services/api_services.dart';
import '../services/base_service.dart';

class DateMedicineRecordRepo extends BaseService {
  static Future<DateMedicineRecordResponseModel> dateMedicineRecordRepo(
      {required Map<String, dynamic> model}) async {
    var response = await APIService().getResponse(
        url: APIConst.dateMedicineRecord, apitype: APIType.aPost, body: model);
    log('RecordMedicineResponseModel response===>>> $response');

    DateMedicineRecordResponseModel dateMedicineRecordResponseModel =
        DateMedicineRecordResponseModel.fromJson(response);

    return dateMedicineRecordResponseModel;
  }
}
