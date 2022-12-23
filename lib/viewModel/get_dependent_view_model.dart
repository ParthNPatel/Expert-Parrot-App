import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/get_dependent_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/dependents_response_model.dart';
import 'package:get/get.dart';

class GetDependentViewModel extends GetxController {
  ApiResponse _getDependentApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getDependentApiResponse => _getDependentApiResponse;

  Future<void> getDependentViewModel() async {
    _getDependentApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      DependentsResponseModel response =
          await GetDependentRepo.getDependentRepo();
      print("GetDependentResponseModel=response==>$response");

      _getDependentApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("GetDependentResponseModel=e==>$e");
      _getDependentApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
