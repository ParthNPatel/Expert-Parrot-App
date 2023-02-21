import 'dart:convert';

import 'package:expert_parrot_app/constant/api_const.dart';
import '../../get_storage_services/get_storage_service.dart';
import '../services/api_services.dart';
import '../services/base_service.dart';
import 'package:http/http.dart' as http;

class DeleteMedicineRepo extends BaseService {
  static Future<dynamic> deleteMedicineRepo({String? id}) async {
    var response = await APIService().getResponse(
      url: APIConst.removeMedicine + "$id",
      apitype: APIType.aGet,
    );
    print('DeleteMedicineResponseModel response===>>>  $response');

    return response;
  }

  static Future<dynamic> skipMedicineRepo({String? id}) async {
    var headers = {
      'Authorization': 'Bearer ${GetStorageServices.getBarrierToken()}',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('http://52.66.209.219:5000/medicine/skip'));
    request.body = json.encode({'medicineId': '$id', 'skip': true});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("SKIP Medicine==${await response.stream.bytesToString()}");
    } else {
      print("SKIP Medicine Error ==${response.reasonPhrase}");
    }
  }
}
