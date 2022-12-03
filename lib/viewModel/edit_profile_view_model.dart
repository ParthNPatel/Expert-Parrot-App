// import 'package:expert_parrot_app/Models/apis/api_response.dart';
// import 'package:expert_parrot_app/Models/repo/edit_profile_repo.dart';
// import 'package:expert_parrot_app/Models/responseModel/edit_profile_res_model.dart';
// import 'package:get/get.dart';
//
// class EditProfileViewModel extends GetxController {
//   ApiResponse _editProfileApiResponse =
//       ApiResponse.initial(message: 'Initialization');
//
//   ApiResponse get editProfileApiResponse => _editProfileApiResponse;
//
//   Future<void> editProfileViewModel({Map<String, dynamic>? model}) async {
//     _editProfileApiResponse = ApiResponse.loading(message: 'Loading');
//     update();
//     try {
//       EditProfileResponseModel response =
//           await EditProfileRepo.editProfileRepo(model: model!);
//       print("EditProfileResponseModel=response==>$response");
//       _editProfileApiResponse = ApiResponse.complete(response);
//     } catch (e) {
//       print("EditProfileResponseModel=e==>$e");
//       _editProfileApiResponse = ApiResponse.error(message: 'error');
//     }
//     update();
//   }
// }
