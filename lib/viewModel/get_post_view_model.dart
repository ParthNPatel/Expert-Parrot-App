import 'dart:developer';

import 'package:expert_parrot_app/Models/responseModel/get_post_res_model.dart';
import 'package:expert_parrot_app/constant/api_const.dart';
import 'package:expert_parrot_app/get_storage_services/get_storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GetPostViewModel extends GetxController {
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  int currentPosts = 10;
  int currentPage = 1;
  late int totalPost;
  List<Post> post = [];
  List showDate = [];

  Future<bool> getPostByPage({String? catId, bool isRefresh = false}) async {
    log("calling ${currentPage}");

    if (isRefresh) {
      currentPage = 1;
    } else {
      if (currentPage >= totalPost) {
        refreshController.loadNoData();
        return false;
      }
    }

    final Uri uri = Uri.parse('${APIConst.baseUrl}' +
        '${APIConst.getPosts}' +
        "?latest=true" +
        '&categoryId=${catId}' +
        '&limit=${currentPosts}&page=${currentPage}');

    log("==== > $uri");

    Map<String, String> headers = GetStorageServices.getBarrierToken() != null
        ? {
            'Authorization': 'Bearer ${GetStorageServices.getBarrierToken()}',
            'Content-Type': 'application/json'
          }
        : {'Content-Type': 'application/json'};

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final result = getPostResponseModelFromJson(response.body);

      post.addAll(result.data!);

      currentPage = currentPage + 1;
      // currentNews = currentNews + 1;
      totalPost = 100;
      print(response.body);
      update();
      return true;
    } else {
      return false;
    }
  }

  // ApiResponse _getPostApiResponse =
  //     ApiResponse.initial(message: 'Initialization');
  //
  // ApiResponse get getPostApiResponse => _getPostApiResponse;
  //
  // Future<void> getPostViewModel({bool? isLoading = true, String? catId}) async {
  //   if (isLoading!) {
  //     _getPostApiResponse = ApiResponse.loading(message: 'Loading');
  //   }
  //   update();
  //   try {
  //     GetPostResponseModel response =
  //         await GetPostRepo.getPostRepo(catId: catId);
  //     print("GetPostResponseModel=response==>$response");
  //
  //     _getPostApiResponse = ApiResponse.complete(response);
  //   } catch (e) {
  //     print("GetPostResponseModel=e==>$e");
  //     _getPostApiResponse = ApiResponse.error(message: 'error');
  //   }
  //   update();
  // }
}
