import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/get_dependent_repo.dart';
import 'package:get/get.dart';

class GetDependentViewModel extends GetxController {
  ApiResponse _getDependentApiResponse =
      ApiResponse.initial(message: 'Initialization');
  var data;

  ApiResponse get getDependentApiResponse => _getDependentApiResponse;

  Future<void> getDependentViewModel() async {
    _getDependentApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      data = await GetDependentRepo.getDependentRepo();
      print("GetDependentResponseModel=response==>$data");

      _getDependentApiResponse = ApiResponse.complete(data);
    } catch (e) {
      print("GetDependentResponseModel=e==>$e");
      _getDependentApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
