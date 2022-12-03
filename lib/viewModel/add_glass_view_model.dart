import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/add_glass_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/add_glass_res_model.dart';
import 'package:get/get.dart';

class AddGlassViewModel extends GetxController {
  int? index;
  int glass = 0;
  int bottle = 0;
  int bigBottle = 0;

  glassCounter({required bool isAdding}) {
    if (isAdding) {
      glass++;
    } else {
      if (glass > 0) glass--;
    }
    update();
  }

  bottleCounter({required bool isAdding}) {
    if (isAdding) {
      glass++;
    } else {
      glass--;
    }
    update();
  }

  bigBottleCounter({required bool isAdding}) {
    if (isAdding) {
      glass++;
    } else {
      glass--;
    }
    update();
  }

  ApiResponse _addGlassApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get addGlassApiResponse => _addGlassApiResponse;

  Future<void> addGlassViewModel({Map<String, dynamic>? model}) async {
    _addGlassApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      AddGlassResponseModel response =
          await AddGlassRepo.addGlassRepo(model: model!);
      print("LogInResponseModel=response==>$response");

      _addGlassApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("LogInResponseModel=e==>$e");
      _addGlassApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
