// import 'package:expert_parrot_app/Models/apis/api_response.dart';
// import 'package:expert_parrot_app/Models/repo/login_repo.dart';
// import 'package:expert_parrot_app/Models/responseModel/log_in_res_model.dart';
// import 'package:get/get.dart';
//
// class LogInViewModel extends GetxController {
//   ApiResponse _logInApiResponse =
//       ApiResponse.initial(message: 'Initialization');
//
//   ApiResponse get logInApiResponse => _logInApiResponse;
//
//   Future<void> logInViewModel({Map<String, dynamic>? model}) async {
//     _logInApiResponse = ApiResponse.loading(message: 'Loading');
//     update();
//     try {
//       LogInResponseModel response =
//           await LoginRepo.loginUserRepo(model: model!);
//       print("LogInResponseModel=response==>$response");
//
//       _logInApiResponse = ApiResponse.complete(response);
//     } catch (e) {
//       print("LogInResponseModel=e==>$e");
//       _logInApiResponse = ApiResponse.error(message: 'error');
//     }
//     update();
//   }
// }
