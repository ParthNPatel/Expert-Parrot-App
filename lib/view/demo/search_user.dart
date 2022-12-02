import 'package:dotted_line/dotted_line.dart';
import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/responseModel/gte_search_user_res_model.dart';
import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:expert_parrot_app/viewModel/get_search_user_view_model.dart';
import 'package:expert_parrot_app/viewModel/send_request_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'get_req_user_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();
  TextEditingController relation = TextEditingController();
  GetSearchUserViewModel getSearchUserViewModel =
      Get.put(GetSearchUserViewModel());
  SendReqViewModel sendReqViewModel = Get.put(SendReqViewModel());

  @override
  void initState() {
    getSearchUserViewModel.getSearchUserViewModel(name: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     elevation: 0,
      //     centerTitle: true,
      //     leadingWidth: 53.sp,
      //     backgroundColor: Colors.transparent,
      //     leading: Padding(
      //       padding: EdgeInsets.only(
      //           left: 15.sp, bottom: 8.sp, right: 8.sp, top: 8.sp),
      //       child: CommonWidget.commonBackButton(
      //         onTap: () {
      //           Get.back();
      //         },
      //       ),
      //     ),
      //     title: CommonText.textBoldWight500(
      //         text: TextConst.dependentSearch,
      //         fontSize: 16.sp,
      //         color: Colors.black),
      //     actions: [
      //       Padding(
      //         padding: EdgeInsets.only(bottom: 8.sp, right: 15.sp, top: 8.sp),
      //         child: CommonWidget.commonBackButton(
      //           image: ImageConst.add,
      //           onTap: () {
      //             Get.to(() => RequestUserScreen());
      //           },
      //         ),
      //       )
      //     ]),
      body: CommonWidget.commonBackGround(
        body: Column(
          children: [
            CommonWidget.commonSizedBox(height: 10),
            CommonWidget.header(
                backOnTap: () {
                  Get.back();
                },
                addOnTap: () {
                  Get.to(() => RequestUserScreen());
                },
                titleText: TextConst.dependentSearch),
            CommonWidget.commonSizedBox(height: 13),
            DottedLine(
              lineLength: double.infinity,
              lineThickness: 1.0,
              dashLength: 10.0,
              dashColor: Color(0xffbac2ba),
              dashRadius: 0.0,
              dashGapLength: 6.0,
              dashGapColor: Colors.transparent,
              dashGapRadius: 0.0,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 35.sp,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: search,
                      onChanged: (val) async {
                        await getSearchUserViewModel.getSearchUserViewModel(
                            name: '${search.text.trim()}');
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, bottom: 9),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.sp,
                  ),
                  InkResponse(
                    onTap: () async {
                      await getSearchUserViewModel.getSearchUserViewModel(
                          name: '${search.text.trim()}');
                    },
                    child: CircleAvatar(
                      radius: 20.sp,
                      child: Icon(Icons.search, color: Colors.white),
                      backgroundColor: CommonColor.greenColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Expanded(
              child: GetBuilder<GetSearchUserViewModel>(
                builder: (controller) {
                  if (controller.getUserResponse.status == Status.LOADING) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (controller.getUserResponse.status == Status.COMPLETE) {
                    GetSearchUserResponseModel getSearchRes =
                        controller.getUserResponse.data;

                    return search.text.isEmpty
                        ? ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemCount: getSearchRes.data!.length,
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              return Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 13.sp),
                                  height: 45.sp,
                                  decoration: BoxDecoration(
                                      color: CommonColor.greenColor
                                          .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(18)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundImage: NetworkImage(
                                                'https://wallpapercave.com/dwp1x/wp4376818.jpg'),
                                          ),
                                          SizedBox(width: 10.sp),
                                          Text(
                                            '${getSearchRes.data![index].name}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 23.sp,
                                        width: 23.sp,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                            ),
                                            color: CommonColor.greenColor
                                                .withOpacity(0.35),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: IconButton(
                                          icon: SvgPicture.asset(ImageConst.add,
                                              color: Colors.white),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) => Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: SizedBox(
                                                        height: 175.sp,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20,
                                                                  vertical: 15),
                                                          child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    CommonText
                                                                        .textBoldWight500(
                                                                      text:
                                                                          "Enter Relation",
                                                                      fontSize:
                                                                          17.sp,
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Get.back();
                                                                      },
                                                                      child: CommonWidget
                                                                          .commonSvgPitcher(
                                                                        image: ImageConst
                                                                            .close,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                CommonWidget
                                                                    .dottedLineWidget(),
                                                                SizedBox(
                                                                    height: 20),
                                                                TextField(
                                                                  controller:
                                                                      relation,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(),
                                                                    hintText:
                                                                        'Relation',
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        20.sp),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    SizedBox(
                                                                        width: 20
                                                                            .sp),
                                                                    SizedBox(
                                                                      height:
                                                                          6.5.h,
                                                                      width:
                                                                          25.w,
                                                                      child: CommonWidget.commonButton(
                                                                          color: CommonColor.greenColor,
                                                                          radius: 10,
                                                                          onTap: () async {
                                                                            if (relation.text.isNotEmpty) {
                                                                              await sendReqViewModel.sendReqViewModel(model: {
                                                                                "userId": "${getSearchRes.data![index].id}",
                                                                                "relation": "${relation.text.trim()}"
                                                                              });
                                                                              relation.clear();

                                                                              if (sendReqViewModel.sendReqApiResponse.status == Status.COMPLETE) {
                                                                                Get.back();
                                                                                CommonWidget.getSnackBar(
                                                                                  message: 'Request send successfully',
                                                                                  title: 'Successfully',
                                                                                  duration: 2,
                                                                                  color: Colors.green,
                                                                                );
                                                                              }
                                                                              if (sendReqViewModel.sendReqApiResponse.status == Status.ERROR) {
                                                                                Get.back();
                                                                                CommonWidget.getSnackBar(
                                                                                  message: "This user is already in your dependent list.",
                                                                                  title: 'Failed',
                                                                                  duration: 2,
                                                                                  color: Colors.red,
                                                                                );
                                                                              }
                                                                            } else {
                                                                              CommonWidget.getSnackBar(
                                                                                message: "Please enter relation!",
                                                                                title: 'Exception',
                                                                                duration: 2,
                                                                                color: Colors.red,
                                                                              );
                                                                            }
                                                                          },
                                                                          text: "Send"),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          6.5.h,
                                                                      width:
                                                                          25.w,
                                                                      child: CommonWidget.commonButton(
                                                                          color: CommonColor.greenColor,
                                                                          radius: 10,
                                                                          onTap: () {
                                                                            Navigator.of(ctx).pop();
                                                                          },
                                                                          text: "Back"),
                                                                    )
                                                                  ],
                                                                ),
                                                              ]),
                                                        ),
                                                      ),
                                                    ));
                                          },
                                        ),
                                      ),
                                    ],
                                  ));
                            },
                          )
                        : ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemCount: getSearchRes.data!.length <= 8
                                ? getSearchRes.data!.length
                                : 8,
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              return Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 13.sp),
                                  height: 45.sp,
                                  decoration: BoxDecoration(
                                      color: CommonColor.greenColor
                                          .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(18)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundImage: NetworkImage(
                                                'https://wallpapercave.com/dwp1x/wp4376818.jpg'),
                                          ),
                                          SizedBox(width: 10.sp),
                                          Text(
                                            '${getSearchRes.data![index].name}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 23.sp,
                                        width: 23.sp,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                            ),
                                            color: CommonColor.greenColor
                                                .withOpacity(0.35),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: IconButton(
                                          icon: SvgPicture.asset(ImageConst.add,
                                              color: Colors.white),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) => Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: SizedBox(
                                                        height: 175.sp,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20,
                                                                  vertical: 15),
                                                          child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    CommonText
                                                                        .textBoldWight500(
                                                                      text:
                                                                          "Enter Relation",
                                                                      fontSize:
                                                                          17.sp,
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Get.back();
                                                                      },
                                                                      child: CommonWidget
                                                                          .commonSvgPitcher(
                                                                        image: ImageConst
                                                                            .close,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                CommonWidget
                                                                    .dottedLineWidget(),
                                                                SizedBox(
                                                                    height: 20),
                                                                TextField(
                                                                  controller:
                                                                      relation,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(),
                                                                    hintText:
                                                                        'Relation',
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        20.sp),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    SizedBox(
                                                                        width: 20
                                                                            .sp),
                                                                    SizedBox(
                                                                      height:
                                                                          6.5.h,
                                                                      width:
                                                                          25.w,
                                                                      child: CommonWidget.commonButton(
                                                                          color: CommonColor.greenColor,
                                                                          radius: 10,
                                                                          onTap: () async {
                                                                            await sendReqViewModel.sendReqViewModel(model: {
                                                                              "userId": "${getSearchRes.data![index].id}",
                                                                              "relation": "${relation.text.trim()}"
                                                                            });
                                                                            relation.clear();

                                                                            if (sendReqViewModel.sendReqApiResponse.status ==
                                                                                Status.COMPLETE) {
                                                                              Get.back();
                                                                              CommonWidget.getSnackBar(
                                                                                message: 'Request send successfully',
                                                                                title: 'Successfully',
                                                                                duration: 2,
                                                                                color: Colors.green,
                                                                              );
                                                                            }
                                                                            if (sendReqViewModel.sendReqApiResponse.status ==
                                                                                Status.ERROR) {
                                                                              Get.back();
                                                                              CommonWidget.getSnackBar(
                                                                                message: 'Try Again...',
                                                                                title: 'Failed',
                                                                                duration: 2,
                                                                                color: Colors.red,
                                                                              );
                                                                            }
                                                                          },
                                                                          text: "Send"),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          6.5.h,
                                                                      width:
                                                                          25.w,
                                                                      child: CommonWidget.commonButton(
                                                                          color: CommonColor.greenColor,
                                                                          radius: 10,
                                                                          onTap: () {
                                                                            Navigator.of(ctx).pop();
                                                                          },
                                                                          text: "Back"),
                                                                    )
                                                                  ],
                                                                ),
                                                              ]),
                                                        ),
                                                      ),
                                                    ));
                                          },
                                        ),
                                      ),
                                    ],
                                  ));
                            },
                          );
                  }
                  return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
