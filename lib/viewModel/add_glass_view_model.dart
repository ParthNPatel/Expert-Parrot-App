import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/add_glass_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/add_glass_res_model.dart';
import 'package:get/get.dart';

class AddGlassViewModel extends GetxController {
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
