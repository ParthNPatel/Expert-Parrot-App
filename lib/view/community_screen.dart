import 'dart:io';

import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/responseModel/add_post_res_model.dart';
import 'package:expert_parrot_app/Models/responseModel/get_all_post_categories_res_model.dart';
import 'package:expert_parrot_app/Models/responseModel/get_comment_res_model.dart';
import 'package:expert_parrot_app/Models/responseModel/get_post_res_model.dart';
import 'package:expert_parrot_app/components/community_shimmer.dart';
import 'package:expert_parrot_app/constant/api_const.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/controller/handle_float_controller.dart';
import 'package:expert_parrot_app/get_storage_services/get_storage_service.dart';
import 'package:expert_parrot_app/view/login_screen.dart';
import 'package:expert_parrot_app/viewModel/add_comment_view_model.dart';
import 'package:expert_parrot_app/viewModel/add_post_view_model.dart';
import 'package:expert_parrot_app/viewModel/get_all_post_categories_view_model.dart';
import 'package:expert_parrot_app/viewModel/get_comment_view_model.dart';
import 'package:expert_parrot_app/viewModel/get_post_view_model.dart';
import 'package:expert_parrot_app/viewModel/like_unlike_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../components/common_widget.dart';
import '../constant/image_const.dart';
import '../constant/text_styel.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  // TextEditingController _queryTitleController = TextEditingController();
  TextEditingController _queryDescriptionController = TextEditingController();

  GetPostViewModel getPostViewModel = Get.put(GetPostViewModel());
  AddPostViewModel addPostViewModel = Get.put(AddPostViewModel());
  GetAllPostCategoriesViewModel allPostCategoriesViewModel =
      Get.put(GetAllPostCategoriesViewModel());

  int catIndex = 0;

  int selectedCat = 0;
  String selectedCatName = "All";
  String selectedCatPostId = "";

  @override
  void initState() {
    super.initState();

    // getPostViewModel.getPostViewModel(isLoading: true, catId: "");
    getPostByPage(catId: "", isRefresh: true);
    allPostCategoriesViewModel.getAllPostCategoriesViewModel(isLoading: true);

    print(
        '============================== > ${GetStorageServices.getBarrierToken()}');
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  int currentPosts = 10;
  int currentPage = 1;
  late int totalPost;
  List<Post> post = [];
  List showDate = [];

  Future<bool> getPostByPage({String? catId, bool isRefresh = false}) async {
    print("calling ${currentPage}");

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
        '?categoryId=${catId}' +
        '&limit=${currentPosts}&page=${currentPage}');

    print('selectedCatNameselectedCatName ${selectedCatName}');

    print('catIdcatId ${catId}');

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
      totalPost = result.data!.length;
      print(response.body);
      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
      //extendBody: false,
      //primary: false,
      body: CommonWidget.commonBackGround(
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            header(),
            SizedBox(
              height: 13,
            ),
            CommonWidget.dottedLineWidget(),
            SizedBox(
              height: 23,
            ),
            Expanded(
              child: GetBuilder<GetAllPostCategoriesViewModel>(
                  builder: (controllerCat) {
                if (controllerCat.getAllPostCategoriesApiResponse.status ==
                    Status.LOADING) {
                  return SizedBox();
                }
                if (controllerCat.getAllPostCategoriesApiResponse.status ==
                    Status.COMPLETE) {
                  GetAllPostCategoriesResponseModel resp =
                      controllerCat.getAllPostCategoriesApiResponse.data;

                  if (resp.data!.elementAt(0).name != "All" &&
                      resp.data!.elementAt(0).id != "") {
                    resp.data!.insert(
                        0,
                        PostCat(
                            name: "All",
                            updatedAt: DateTime.now(),
                            createdAt: DateTime.now(),
                            id: ""));
                  }

                  showDate.clear();

                  post.forEach(
                    (element) {
                      if (showDate.contains(
                              element.createdAt.toString().split(' ').first) ==
                          false) {
                        showDate
                            .add(element.createdAt.toString().split(' ').first);
                      }
                    },
                  );

                  return Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: resp.data!.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 10.sp);
                            },
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    selectedCat = index;
                                    selectedCatName =
                                        "${resp.data![index].name}";
                                  });
                                  post.clear();

                                  await getPostByPage(
                                      isRefresh: true,
                                      catId: "${resp.data![selectedCat].id}");
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 25.w,
                                  decoration: BoxDecoration(
                                      color: selectedCat == index
                                          ? CommonColor.greenColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                          color: CommonColor.greenColor)),
                                  child: CommonText.textBoldWight500(
                                      text:
                                          "${resp.data![index].name.toString().capitalizeFirst}",
                                      fontSize: 12.sp,
                                      color: selectedCat == index
                                          ? Colors.white
                                          : CommonColor.greenColor),
                                ),
                              );
                            }),
                      ),
                      CommonWidget.commonSizedBox(height: 10),
                      Expanded(
                        flex: 12,
                        child: SmartRefresher(
                          controller: refreshController,
                          physics: BouncingScrollPhysics(),
                          enablePullUp: true,
                          onRefresh: () async {
                            post.clear();
                            final result = await getPostByPage(
                                isRefresh: true,
                                catId: "${resp.data![selectedCat].id}");

                            if (result) {
                              return refreshController.refreshCompleted();
                            } else {
                              return refreshController.refreshFailed();
                            }
                          },
                          onLoading: () async {
                            final result = await getPostByPage(
                                catId: "${resp.data![selectedCat].id}");

                            if (result) {
                              return refreshController.loadComplete();
                            } else {
                              return refreshController.loadFailed();
                            }
                          },
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: showDate.length,
                            itemBuilder: (context, index1) {
                              var dateData = showDate[index1];
                              var currentDate =
                                  DateTime.now().toString().split(' ').first;
                              var yesterday = DateTime.now()
                                  .subtract(Duration(days: 1))
                                  .toString()
                                  .split(' ')
                                  .first;
                              return Column(
                                children: [
                                  CommonText.textBoldWight500(
                                      text: dateData == currentDate
                                          ? 'Today'
                                          : dateData == yesterday
                                              ? 'Yesterday'
                                              : '${dateData}',
                                      color: Color(0xff939492)),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: post.length,
                                    separatorBuilder: (_, index) {
                                      return SizedBox(
                                        height: 20,
                                      );
                                    },
                                    itemBuilder: (_, index) {
                                      return post[index]
                                                  .createdAt
                                                  .toString()
                                                  .split(' ')
                                                  .first ==
                                              showDate[index1]
                                          ? post[index].image == null ||
                                                  post[index].image == ""
                                              ? Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          post[index]
                                                                      .userId!
                                                                      .userImage !=
                                                                  null
                                                              ? Container(
                                                                  height: 40.sp,
                                                                  width: 40.sp,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.black)),
                                                                  child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(500),
                                                                      child: Image.network(
                                                                        'https://health-app-test.s3.ap-south-1.amazonaws.com/user/${post[index].userId!.userImage}',
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        errorBuilder: (context,
                                                                                error,
                                                                                stackTrace) =>
                                                                            Icon(
                                                                          color:
                                                                              Colors.grey,
                                                                          Icons
                                                                              .person,
                                                                          size:
                                                                              22.sp,
                                                                        ),
                                                                      )),
                                                                )
                                                              : Container(
                                                                  height: 40.sp,
                                                                  width: 40.sp,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  child: Icon(
                                                                    color: Colors
                                                                        .grey,
                                                                    Icons
                                                                        .person,
                                                                    size: 22.sp,
                                                                  ),
                                                                ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CommonText
                                                                  .textBoldWight500(
                                                                      text:
                                                                          "${post[index].userId!.name.toString().capitalizeFirst}",
                                                                      fontSize:
                                                                          12.sp),
                                                              CommonText.textBoldWight400(
                                                                  text:
                                                                      "QR, Canada",
                                                                  color: Color(
                                                                      0xffa1a1a1),
                                                                  fontSize:
                                                                      10.sp),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          CommonText.textBoldWight400(
                                                              text:
                                                                  "${DateFormat.yMMMEd().format(DateTime.parse("${post[index].createdAt!}"))}",
                                                              color: Color(
                                                                  0xffa1a1a1),
                                                              fontSize: 10.sp),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 13,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CommonText.textBoldWight400(
                                                              text:
                                                                  "#${post[index].title}",
                                                              color: Color(
                                                                  0xffa1a1a1),
                                                              fontSize: 11.sp),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          CommonText.textBoldWight400(
                                                              text:
                                                                  "${post[index].description}",
                                                              color: Color(
                                                                  0xffa1a1a1),
                                                              fontSize: 11.sp),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 13,
                                                      ),
                                                      Divider(
                                                        thickness: 1.2,
                                                        color:
                                                            Color(0xffE0E1E2),
                                                      ),
                                                      SizedBox(
                                                        height: 13,
                                                      ),
                                                      LikeAndCommentWidget(
                                                        post: post,
                                                        index: index,
                                                        postId: post[index].id,
                                                        likeCount:
                                                            post[index].likes,
                                                        commentCount:
                                                            post[index]
                                                                .comments!
                                                                .length,
                                                        isLiked: post[index]
                                                            .isLiked!,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          post[index]
                                                                      .userId!
                                                                      .userImage !=
                                                                  null
                                                              ? Container(
                                                                  height: 40.sp,
                                                                  width: 40.sp,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.black)),
                                                                  child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(500),
                                                                      child: Image.network(
                                                                        'https://health-app-test.s3.ap-south-1.amazonaws.com/user/${post[index].userId!.userImage}',
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        errorBuilder: (context,
                                                                                error,
                                                                                stackTrace) =>
                                                                            Icon(
                                                                          color:
                                                                              Colors.grey,
                                                                          Icons
                                                                              .person,
                                                                          size:
                                                                              22.sp,
                                                                        ),
                                                                      )),
                                                                )
                                                              : Container(
                                                                  height: 40.sp,
                                                                  width: 40.sp,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  child: Icon(
                                                                    color: Colors
                                                                        .grey,
                                                                    Icons
                                                                        .person,
                                                                    size: 22.sp,
                                                                  ),
                                                                ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              CommonText
                                                                  .textBoldWight500(
                                                                      text:
                                                                          "${post[index].userId!.name.toString().capitalizeFirst}",
                                                                      fontSize:
                                                                          12.sp),
                                                              CommonText.textBoldWight400(
                                                                  text:
                                                                      "QR, Canada",
                                                                  color: Color(
                                                                      0xffa1a1a1),
                                                                  fontSize:
                                                                      10.sp),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          CommonText.textBoldWight400(
                                                              text:
                                                                  "${DateFormat.yMMMEd().format(DateTime.parse("${post[index].createdAt!}"))}",
                                                              color: Color(
                                                                  0xffa1a1a1),
                                                              fontSize: 10.sp),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 13,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CommonText.textBoldWight400(
                                                              text:
                                                                  "#${post[index].title}",
                                                              color: Color(
                                                                  0xffa1a1a1),
                                                              fontSize: 11.sp),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          CommonText.textBoldWight400(
                                                              text:
                                                                  "${post[index].description}",
                                                              color: Color(
                                                                  0xffa1a1a1),
                                                              fontSize: 11.sp),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Container(
                                                            height: 130.sp,
                                                            width:
                                                                double.infinity,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: Image
                                                                    .network(
                                                                  "https://health-app-test.s3.ap-south-1.amazonaws.com/post/" +
                                                                      "${post[index].image}",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  errorBuilder:
                                                                      (context,
                                                                              error,
                                                                              stackTrace) =>
                                                                          Icon(
                                                                    color: Colors
                                                                        .grey,
                                                                    Icons
                                                                        .image_not_supported_outlined,
                                                                    size: 60,
                                                                  ),
                                                                )),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Divider(
                                                        thickness: 1.2,
                                                        color:
                                                            Color(0xffE0E1E2),
                                                      ),
                                                      SizedBox(
                                                        height: 13,
                                                      ),
                                                      LikeAndCommentWidget(
                                                        index: index,
                                                        post: post,
                                                        postId: post[index].id,
                                                        likeCount:
                                                            post[index].likes,
                                                        commentCount:
                                                            post[index]
                                                                .comments!
                                                                .length,
                                                        isLiked: post[index]
                                                            .isLiked!,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                          : SizedBox();
                                    },
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                } else
                  return SizedBox();
              }),
            ),
            SizedBox(height: 23),
            /* Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // CommonText.textBoldWight500(
                    //   text: 'Today',
                    //   color: Color(0xff939492),
                    // ),

                    // Container(
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(20),
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Image.asset(
                    //             'assets/png/person1.png',
                    //             height: 40.sp,
                    //             width: 40.sp,
                    //           ),
                    //           SizedBox(
                    //             width: 10,
                    //           ),
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               CommonText.textBoldWight500(
                    //                   text: "Adam LR", fontSize: 12.sp),
                    //               CommonText.textBoldWight400(
                    //                   text: "QR, Canada",
                    //                   color: Color(0xffa1a1a1),
                    //                   fontSize: 10.sp),
                    //             ],
                    //           ),
                    //           Spacer(),
                    //           CommonText.textBoldWight400(
                    //               text: "2 hour ago",
                    //               color: Color(0xffa1a1a1),
                    //               fontSize: 10.sp),
                    //         ],
                    //       ),
                    //       SizedBox(
                    //         height: 13,
                    //       ),
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           CommonText.textBoldWight400(
                    //               text: "anyone know softgel pill details?",
                    //               color: Color(0xffa1a1a1),
                    //               fontSize: 11.sp),
                    //           SizedBox(
                    //             height: 10,
                    //           ),
                    //           Container(
                    //             height: 130.sp,
                    //             width: double.infinity,
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(10),
                    //               image: DecorationImage(
                    //                   image: AssetImage(
                    //                     "assets/png/medicine.png",
                    //                   ),
                    //                   fit: BoxFit.cover),
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //       SizedBox(
                    //         height: 8,
                    //       ),
                    //       Divider(
                    //         thickness: 1.2,
                    //         color: Color(0xffE0E1E2),
                    //       ),
                    //       SizedBox(
                    //         height: 13,
                    //       ),
                    //       LikeAndCommentWidget(
                    //           commentCount: 5,
                    //           likeCount: 5,
                    //           isLiked: true,
                    //           postId: "fsdfsfsd"),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 25,
                    // ),
                    // CommonText.textBoldWight500(
                    //   text: 'Yesterday',
                    //   color: Color(0xff939492),
                    // ),
                    // SizedBox(
                    //   height: 13,
                    // ),
                    // Container(
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(20),
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Image.asset(
                    //             'assets/png/person1.png',
                    //             height: 40.sp,
                    //             width: 40.sp,
                    //           ),
                    //           SizedBox(
                    //             width: 10,
                    //           ),
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               CommonText.textBoldWight500(
                    //                   text: "Vill Parmar", fontSize: 12.sp),
                    //               CommonText.textBoldWight400(
                    //                   text: "ON, Canada",
                    //                   color: Color(0xffa1a1a1),
                    //                   fontSize: 10.sp),
                    //             ],
                    //           ),
                    //           Spacer(),
                    //           CommonText.textBoldWight400(
                    //               text: "1 hour ago",
                    //               color: Color(0xffa1a1a1),
                    //               fontSize: 10.sp),
                    //         ],
                    //       ),
                    //       SizedBox(
                    //         height: 13,
                    //       ),
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           CommonText.textBoldWight400(
                    //               text:
                    //                   "anyone know softgel pill details? What is a softgel pill? What is inside a softgel?",
                    //               color: Color(0xffa1a1a1),
                    //               fontSize: 11.sp),
                    //           SizedBox(
                    //             height: 20,
                    //           ),
                    //           CommonText.textBoldWight400(
                    //               text:
                    //                   "If anyone have knowalge text in commment box.",
                    //               color: Color(0xffa1a1a1),
                    //               fontSize: 11.sp),
                    //         ],
                    //       ),
                    //       SizedBox(
                    //         height: 13,
                    //       ),
                    //       Divider(
                    //         thickness: 1.2,
                    //         color: Color(0xffE0E1E2),
                    //       ),
                    //       SizedBox(
                    //         height: 13,
                    //       ),
                    //       // LikeAndCommentWidget(),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            )*/
          ],
        ),
      ),
    );
  }

  Row header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonWidget.commonBackButton(
          onTap: () {
            Get.back();
          },
        ),
        CommonText.textBoldWight500(text: "Community", fontSize: 18.sp),
        InkWell(
          onTap: () async {
            if (GetStorageServices.getUserLoggedInStatus() == true) {
              Get.dialog(await askYourQuestion()).then((value) {
                setState(() {
                  // _queryTitleController.clear();
                  _queryDescriptionController.clear();
                  catIndex = 0;
                });
              });
            } else {
              Get.off(() => LoginScreen());
            }
          },
          child: Image.asset(
            'assets/png/chat1.png',
            height: 23.sp,
            width: 23.sp,
          ),
        )
      ],
    );
  }

  getImage(ImageSource imageSource) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickImage = await _picker.pickImage(source: imageSource);
    addPostViewModel.setImage(File(pickImage!.path));
    print('Image ================ > ${addPostViewModel.image}');
    setState(() {});
  }

  // showImageWidget() {
  //   try {
  //     return image == null
  //         ? SizedBox()
  //         : ClipRRect(
  //             borderRadius: BorderRadius.circular(18),
  //             child: Image.file(
  //               image!,
  //               fit: BoxFit.cover,
  //             ),
  //           );
  //   } catch (e) {
  //     return Icon(
  //       color: Colors.grey,
  //       Icons.person,
  //       size: 120,
  //     );
  //   }
  // }
  Future<StatefulBuilder> askYourQuestion() async {
    return StatefulBuilder(
      builder: (context, setState) =>
          GetBuilder<AddPostViewModel>(builder: (controller) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText.textBoldWight500(
                          text: "Ask Your Query",
                          fontSize: 17.sp,
                        ),
                        InkWell(
                          onTap: () {
                            // _queryTitleController.clear();
                            _queryDescriptionController.clear();
                            catIndex = 0;
                            controller.image = null;
                            Get.back();
                          },
                          child: CommonWidget.commonSvgPitcher(
                            image: ImageConst.close,
                          ),
                        )
                      ],
                    ),
                  ),
                  CommonWidget.dottedLineWidget(),
                  GetBuilder<GetAllPostCategoriesViewModel>(
                      builder: (controllerCat) {
                    if (controllerCat.getAllPostCategoriesApiResponse.status ==
                        Status.LOADING) {
                      return SizedBox();
                    }
                    if (controllerCat.getAllPostCategoriesApiResponse.status ==
                        Status.COMPLETE) {
                      GetAllPostCategoriesResponseModel response =
                          controllerCat.getAllPostCategoriesApiResponse.data;

                      if (response.data!.elementAt(0).name == "All" &&
                          response.data!.elementAt(0).id == "") {
                        response.data!.removeAt(0);
                      }
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText.textBoldWight400(
                              text: "Please enter your medicine related query",
                              fontSize: 11.sp,
                              color: Color(0xff9B9B9B),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            controller.image == null
                                ? SizedBox()
                                : Container(
                                    height: 150.sp,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.file(
                                        controller.image!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                            SizedBox(height: 20),

                            Container(
                              //height: 40.sp,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xffF8F8F6),
                              ),
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  iconColor: CommonColor.greenColor,
                                  title: Row(
                                    children: [
                                      CommonText.textBoldWight500(
                                          text:
                                              "${response.data![catIndex].name.toString().capitalizeFirst}",
                                          fontSize: 13.sp,
                                          color: Colors.black),
                                    ],
                                  ),
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      child: Column(
                                        children: List.generate(
                                          response.data!.length,
                                          (index) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                catIndex = index;
                                              });
                                              setState(() {});
                                              print(
                                                  "select:- ${response.data![catIndex].name}");
                                            },
                                            child: Container(
                                              color: catIndex == index
                                                  ? Color(0xffe1f9ea)
                                                  : Colors.white,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.check,
                                                    size: 17,
                                                    color: catIndex == index
                                                        ? CommonColor.greenColor
                                                        : Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CommonText.textBoldWight500(
                                                    text: response.data![index]
                                                        .name!.capitalizeFirst!,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            // TextFormField(
                            //   controller: _queryTitleController,
                            //   decoration: InputDecoration(
                            //       filled: true,
                            //       fillColor: Color(0xffF8F8F6),
                            //       hintText: "Enter post category",
                            //       border: OutlineInputBorder(
                            //         borderSide: BorderSide.none,
                            //         borderRadius: BorderRadius.circular(20),
                            //       )),
                            // ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _queryDescriptionController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xffF8F8F6),
                                  hintText: "Enter your query description",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                            ),
                            SizedBox(height: 23),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: 29.w,
                                    child: MaterialButton(
                                      onPressed: () async {
                                        Get.dialog(
                                          AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                MaterialButton(
                                                    color: CommonColor
                                                        .greenColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                    onPressed: () {
                                                      getImage(
                                                          ImageSource.camera);
                                                      Get.back();
                                                    },
                                                    child: Text("Camera",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white))),
                                                MaterialButton(
                                                  color: CommonColor.greenColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  onPressed: () {
                                                    getImage(
                                                        ImageSource.gallery);
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    "Gallery",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      color: CommonColor.greenColor,
                                      height: 35.sp,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CommonText.textBoldWight600(
                                                text: "Select Image",
                                                color: Colors.white,
                                                fontSize: 10.sp)
                                          ]),
                                    )),
                                SizedBox(width: 5.sp),
                                SizedBox(
                                    width: 29.w,
                                    child: MaterialButton(
                                      onPressed: () async {
                                        if (/*_queryTitleController.text.isNotEmpty &&*/
                                            _queryDescriptionController
                                                .text.isNotEmpty) {
                                          var _req = controller.image != null
                                              ? {
                                                  "title":
                                                      "${response.data![catIndex].name!}",
                                                  "description":
                                                      "${_queryDescriptionController.text}",
                                                  "image":
                                                      controller.image!.path,
                                                  "categoryId":
                                                      "${response.data![catIndex].id!}"
                                                }
                                              : {
                                                  "title":
                                                      "${response.data![catIndex].name!}",
                                                  "description":
                                                      "${_queryDescriptionController.text}",
                                                  "categoryId":
                                                      "${response.data![catIndex].id!}"
                                                };

                                          print('================= > $_req');

                                          if (controller.image != null) {
                                            await controller.addPostViewModel(
                                                model: _req);
                                          } else {
                                            await controller
                                                .addPostWithoutImgViewModel(
                                                    model: _req);
                                          }

                                          if (controller
                                                  .addPostApiResponse.status ==
                                              Status.COMPLETE) {
                                            AddPostResponseModel resp =
                                                controller
                                                    .addPostApiResponse.data;

                                            print(
                                                'image from response ======================== > ${resp.data!.image}');
                                            controller.image = null;
                                            // _queryTitleController.clear();
                                            _queryDescriptionController.clear();
                                            catIndex = 0;
                                            Get.back();

                                            await getPostViewModel
                                                .getPostViewModel(
                                                    isLoading: true, catId: "");
                                            CommonWidget.getSnackBar(
                                                duration: 2,
                                                color: CommonColor.greenColor,
                                                colorText: Colors.white,
                                                title: "Submitted",
                                                message:
                                                    'Your query has been submitted successfully.');
                                          }
                                          if (controller
                                                  .addPostApiResponse.status ==
                                              Status.ERROR) {
                                            Get.back();

                                            CommonWidget.getSnackBar(
                                                duration: 2,
                                                color: Colors.red.shade300,
                                                colorText: Colors.white,
                                                title: "Error",
                                                message:
                                                    'Something went wrong!');
                                          }
                                        } else {
                                          CommonWidget.getSnackBar(
                                              color: Colors.red.shade300,
                                              duration: 2,
                                              colorText: Colors.white,
                                              title: "Required",
                                              message: /*_queryTitleController
                                                      .text.isEmpty
                                                  ? 'Please enter your query title'
                                                  : */
                                                  "Please enter your query description");
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      color: CommonColor.greenColor,
                                      padding: EdgeInsets.zero,
                                      height: 35.sp,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CommonText.textBoldWight600(
                                                text: "Submit",
                                                color: Colors.white,
                                                fontSize: 10.sp)
                                          ]),
                                    )),
                              ],
                            )
                          ],
                        ),
                      );
                    } else
                      return SizedBox();
                  }),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class LikeAndCommentWidget extends StatefulWidget {
  List<Post> post;
  int? index;
  int? likeCount;
  int? commentCount;
  bool isLiked;
  String? postId;
  LikeAndCommentWidget(
      {required this.likeCount,
      required this.index,
      required this.post,
      required this.commentCount,
      required this.isLiked,
      required this.postId,
      Key? key})
      : super(key: key);

  @override
  State<LikeAndCommentWidget> createState() => _LikeAndCommentWidgetState();
}

class _LikeAndCommentWidgetState extends State<LikeAndCommentWidget> {
  bool isCommentOpened = false;

  final commentController = TextEditingController();
  AddCommentViewModel addCommentViewModel = Get.put(AddCommentViewModel());
  GetCommentViewModel getCommentViewModel = Get.put(GetCommentViewModel());
  LikeUnLikeViewModel likeUnLikeViewModel = Get.put(LikeUnLikeViewModel());
  GetPostViewModel getPostViewModel = Get.put(GetPostViewModel());
  HandleFloatController controller = Get.find();
  @override
  void initState() {
    // likeUnLikeViewModel.updateLike(widget.isLiked);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () async {
                if (widget.isLiked == false) {
                  await likeUnLikeViewModel.likeViewModel(
                      model: {"type": "like", "postId": "${widget.postId}"});
                  if (likeUnLikeViewModel.likeApiResponse.status ==
                      Status.COMPLETE) {
                    getPostViewModel.getPostViewModel(isLoading: false);

                    widget.post[widget.index!] = Post(
                        likes: widget.post[widget.index!].likes! + 1,
                        id: widget.post[widget.index!].id,
                        image: widget.post[widget.index!].image,
                        description: widget.post[widget.index!].description,
                        isLiked: true,
                        title: widget.post[widget.index!].title,
                        comments: widget.post[widget.index!].comments,
                        updatedAt: widget.post[widget.index!].updatedAt,
                        createdAt: widget.post[widget.index!].createdAt,
                        userId: widget.post[widget.index!].userId);
                  }
                  if (likeUnLikeViewModel.likeApiResponse.status ==
                      Status.ERROR) {
                    CommonWidget.getSnackBar(
                        color: Colors.red,
                        duration: 2,
                        colorText: Colors.white,
                        title: "Something went wrong 123",
                        message: 'Try Again.');
                  }
                } else if (widget.isLiked == true) {
                  await likeUnLikeViewModel.unlikeViewModel(
                      model: {"type": "unlike", "postId": "${widget.postId}"});
                  if (likeUnLikeViewModel.unlikeApiResponse.status ==
                      Status.COMPLETE) {
                    getPostViewModel.getPostViewModel(isLoading: false);
                    widget.post[widget.index!] = Post(
                        likes: widget.post[widget.index!].likes! - 1,
                        id: widget.post[widget.index!].id,
                        image: widget.post[widget.index!].image,
                        description: widget.post[widget.index!].description,
                        isLiked: false,
                        title: widget.post[widget.index!].title,
                        comments: widget.post[widget.index!].comments,
                        updatedAt: widget.post[widget.index!].updatedAt,
                        createdAt: widget.post[widget.index!].createdAt,
                        userId: widget.post[widget.index!].userId);
                  }
                  if (likeUnLikeViewModel.unlikeApiResponse.status ==
                      Status.ERROR) {
                    CommonWidget.getSnackBar(
                        color: Colors.red,
                        duration: 2,
                        colorText: Colors.white,
                        title: "Something went wrong",
                        message: 'Try Again.');
                  }
                }
              },
              child: Row(
                children: [
                  Image.asset(
                    widget.isLiked == true
                        ? 'assets/png/like (2).png'
                        : "assets/png/like_outlined.png",
                    height: widget.isLiked == true ? 17.sp : 15.sp,
                    width: widget.isLiked == true ? 17.sp : 15.sp,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CommonText.textBoldWight400(
                      text: "${widget.likeCount}", fontSize: 11.sp),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  isCommentOpened = !isCommentOpened;
                });

                try {
                  await getCommentViewModel.getCommentViewModel(
                      id: widget.postId);
                } catch (e) {
                  CommonWidget.getSnackBar(
                      color: Colors.red,
                      duration: 2,
                      colorText: Colors.white,
                      title: "Something went wrong",
                      message: 'Try Again.');
                }
              },
              child: Row(
                children: [
                  Image.asset(
                    "assets/png/comment.png",
                    height: 17.sp,
                    width: 17.sp,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CommonText.textBoldWight400(
                      text: "${widget.commentCount}", fontSize: 11.sp),
                ],
              ),
            ),
          ],
        ),
        Visibility(
          visible: isCommentOpened,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40.sp,
                    width: 40.sp,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300, shape: BoxShape.circle),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: Image.network(
                          'https://health-app-test.s3.ap-south-1.amazonaws.com/user/${GetStorageServices.getUserImage()}',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            color: Colors.grey,
                            Icons.person,
                            size: 22.sp,
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          onTap: () {
                            controller.changeVisibility(true);
                          },
                          controller: commentController,
                          maxLines: 2,
                          decoration: InputDecoration(
                            hintText: "Add a comment...",
                            hintStyle: TextStyle(
                              color: Color(0xffeaebed),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: BorderSide(
                                color: Color(0xffeaebed),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: BorderSide(
                                color: Color(0xffeaebed),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            if (commentController.text.isNotEmpty) {
                              setState(
                                () {},
                              );

                              try {
                                await addCommentViewModel.addCommentViewModel(
                                    model: {
                                      "postId": "${widget.postId}",
                                      "text": commentController.text.trim()
                                    });

                                if (addCommentViewModel
                                        .addCommentApiResponse.status ==
                                    Status.COMPLETE) {
                                  await getCommentViewModel.getCommentViewModel(
                                      id: widget.postId);

                                  getPostViewModel.getPostViewModel(
                                      isLoading: false);
                                }
                                if (addCommentViewModel
                                        .addCommentApiResponse.status ==
                                    Status.ERROR) {
                                  CommonWidget.getSnackBar(
                                      title: "Something went wrong",
                                      duration: 2,
                                      message: "try Again...",
                                      color: Colors.red,
                                      colorText: Colors.white);
                                }
                              } catch (e) {
                                CommonWidget.getSnackBar(
                                    title: "Something went wrong",
                                    duration: 2,
                                    message: "try Again...",
                                    color: Colors.red,
                                    colorText: Colors.white);
                              }
                              //isCommentOpened = false;
                              commentController.clear();

                              controller.changeVisibility(false);
                            } else {
                              controller.changeVisibility(false);

                              CommonWidget.getSnackBar(
                                  title: "Required",
                                  duration: 2,
                                  message: "Please enter your comment",
                                  color: Colors.red,
                                  colorText: Colors.white);
                            }
                          },
                          child: Container(
                            height: 28.sp,
                            width: 65,
                            decoration: BoxDecoration(
                              color: CommonColor.greenColor,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Center(
                              child: CommonText.textBoldWight500(
                                text: "Post",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              GetBuilder<GetCommentViewModel>(
                builder: (getController) {
                  if (getController.getCommentApiResponse.status ==
                      Status.LOADING) {
                    return CommentShimmer();
                  }

                  if (getController.getCommentApiResponse.status ==
                      Status.COMPLETE) {
                    GetCommentResponseModel getComment =
                        getController.getCommentApiResponse.data;

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: getComment.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 40.sp,
                                  width: 40.sp,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      shape: BoxShape.circle),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(500),
                                      child: Image.network(
                                        'https://health-app-test.s3.ap-south-1.amazonaws.com/user/${GetStorageServices.getUserImage()}',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Icon(
                                          color: Colors.grey,
                                          Icons.person,
                                          size: 22.sp,
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonText.textBoldWight500(
                                        text:
                                            "${getComment.data![index].userId!.name}",
                                        fontSize: 12.sp),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    CommonText.textBoldWight400(
                                        text: "${getComment.data![index].text}",
                                        color: Color(0xffa1a1a1),
                                        fontSize: 10.sp),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// if (getController.getCommentApiResponse.status ==
// Status.LOADING) {
// return CircularProgressIndicator();
// }
//
// if (getController.getCommentApiResponse.status ==
// Status.COMPLETE) {
// GetCommentResponseModel getComment =
// getController.getCommentApiResponse.data;
// return ListView.builder(
// shrinkWrap: true,
// physics: NeverScrollableScrollPhysics(),
// itemCount: getComment.data!.length,
// itemBuilder: (context, index) {
// return Column(
// children: [
// SizedBox(
// height: 15,
// ),
// Row(
// children: [
// Image.asset(
// 'assets/png/person2.png',
// height: 40.sp,
// width: 40.sp,
// ),
// SizedBox(
// width: 10,
// ),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// CommonText.textBoldWight500(
// text:
// "${getComment.data![index].userId!.name}",
// fontSize: 12.sp),
// SizedBox(
// height: 3,
// ),
// CommonText.textBoldWight400(
// text: "${getComment.data![index].text}",
// color: Color(0xffa1a1a1),
// fontSize: 10.sp),
// ],
// ),
// ],
// ),
// ],
// );
// },
// );
// }
// return SizedBox();
