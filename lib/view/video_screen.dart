import 'dart:developer';

import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/responseModel/get_video_res_model.dart';
import 'package:expert_parrot_app/components/video_shimmer.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:expert_parrot_app/view/viedeo_play_screen.dart';
import 'package:expert_parrot_app/viewModel/get_video_view_model.dart';
import 'package:expert_parrot_app/viewModel/like_unlike_video_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../components/common_widget.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  GetVideoViewModel getVideoViewModel = Get.put(GetVideoViewModel());
  LikeUnLikeVideoViewModel likeUnLikeVideoViewModel =
      Get.put(LikeUnLikeVideoViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVideoViewModel.getVideoViewModel(isLoading: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonWidget.commonBackGround(
        body: Column(
          children: [
            CommonWidget.commonSizedBox(height: 10),
            header(),
            CommonWidget.commonSizedBox(height: 6),
            CommonWidget.dottedLineWidget(),
            CommonWidget.commonSizedBox(height: 23),
            Expanded(
              child: SingleChildScrollView(
                child: GetBuilder<GetVideoViewModel>(builder: (controller) {
                  if (controller.getVideoApiResponse.status == Status.LOADING) {
                    return VideoShimmer();
                  }

                  if (controller.getVideoApiResponse.status ==
                      Status.COMPLETE) {
                    GetVideoResponseModel response =
                        controller.getVideoApiResponse.data;

                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: response.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  likeUnLikeVideoViewModel.updateLike(
                                      response.data![index].isLiked!);
                                  likeUnLikeVideoViewModel
                                      .enterValue(response.data![index].likes!);

                                  Get.to(
                                    () => VideoPlayScreen(
                                      videoLink:
                                          "https://health-app-test.s3.ap-south-1.amazonaws.com/video/" +
                                              response.data![index].video!,
                                      title: response.data![index].title!,
                                      description:
                                          response.data![index].description!,
                                      id: response.data![index].id,
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  height: 210,
                                  child: Column(children: [
                                    Container(
                                        width: Get.width,
                                        height: 150,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8)),
                                          child: Image.network(
                                            "https://health-app-test.s3.ap-south-1.amazonaws.com/video/1671467948401.octet-stream" +
                                                response
                                                    .data![index].thumbnail!,
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Row(children: [
                                        CommonText.textBoldWight400(
                                            text: response.data![index].title!,
                                            fontSize: 13.sp,
                                            color: Colors.black),
                                        Spacer(),
                                        Image.asset(
                                          ImageConst.doubleArrow,
                                          scale: 4,
                                        )
                                      ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 0),
                                      child: Row(children: [
                                        CommonText.textBoldWight500(
                                            text: response.data![index]
                                                        .description!.length >
                                                    45
                                                ? '${response.data![index].description!.substring(0, 45)}'
                                                : '${response.data![index].description!}',
                                            fontSize: 9.sp,
                                            color: CommonColor.gery787878),
                                        Spacer(),
                                        CommonText.textBoldWight500(
                                            text:
                                                '${DateFormat.Hm().format(DateTime.parse("${response.data![index].updatedAt}"))}',
                                            fontSize: 9.sp,
                                            color: CommonColor.gery787878),
                                      ]),
                                    ),
                                  ]),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Row(
                                  children: [
                                    Column(children: [
                                      InkResponse(
                                        onTap: () async {
                                          if (response.data![index].isLiked ==
                                              false) {
                                            await likeUnLikeVideoViewModel
                                                .videoLikeViewModel(model: {
                                              "type": "like",
                                              "videoId":
                                                  "${response.data![index].id}"
                                            });

                                            if (likeUnLikeVideoViewModel
                                                    .videoLikeApiResponse
                                                    .status ==
                                                Status.COMPLETE) {
                                              // getVideoViewModel
                                              //     .getVideoViewModel(
                                              //         isLoading: false);
                                            }
                                            if (likeUnLikeVideoViewModel
                                                    .videoLikeApiResponse
                                                    .status ==
                                                Status.ERROR) {
                                              CommonWidget.getSnackBar(
                                                  color: Colors.red,
                                                  duration: 2,
                                                  colorText: Colors.white,
                                                  title: "Something went wrong",
                                                  message: 'Try Again.');
                                            }
                                          } else if (response
                                                  .data![index].isLiked ==
                                              true) {
                                            await likeUnLikeVideoViewModel
                                                .videoUnLikeViewModel(model: {
                                              "type": "unlike",
                                              "videoId":
                                                  "${response.data![index].id}"
                                            });
                                            if (likeUnLikeVideoViewModel
                                                    .videoUnLikeApiResponse
                                                    .status ==
                                                Status.COMPLETE) {
                                              getVideoViewModel
                                                  .getVideoViewModel(
                                                      isLoading: false);
                                            }
                                            if (likeUnLikeVideoViewModel
                                                    .videoUnLikeApiResponse
                                                    .status ==
                                                Status.ERROR) {
                                              CommonWidget.getSnackBar(
                                                  color: Colors.red,
                                                  duration: 2,
                                                  colorText: Colors.white,
                                                  title: "Something went wrong",
                                                  message: 'Try Again.');
                                            }
                                          }
                                          getVideoViewModel.getVideoViewModel(
                                              isLoading: false);
                                          if (getVideoViewModel
                                                  .getVideoApiResponse.status ==
                                              Status.COMPLETE) {
                                            log('DONE');
                                          } else {
                                            log('Error');
                                          }
                                        },
                                        child: response.data![index].isLiked ==
                                                true
                                            ? Icon(
                                                Icons.favorite,
                                                size: 20,
                                                color: Colors.red,
                                              )
                                            : CommonWidget.commonSvgPitcher(
                                                height: 20,
                                                image:
                                                    ImageConst.hartBorderIcon,
                                                color: CommonColor.gery636363,
                                              ),
                                      ),
                                      CommonText.textBoldWight400(
                                          text:
                                              '${response.data![index].likes}',
                                          fontSize: 13.sp,
                                          color: CommonColor.gery636363),
                                    ]),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Share.share(
                                            '${ImageConst.videoUrl}${response.data![index].video}',
                                            subject:
                                                '${response.data![index].description}');
                                      },
                                      child: Column(
                                        children: [
                                          Image.asset(ImageConst.shareIcon,
                                              scale: 4,
                                              color: CommonColor.gery636363),
                                          CommonText.textBoldWight400(
                                            text: TextConst.share,
                                            fontSize: 13.sp,
                                            color: CommonColor.gery636363,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else
                    return SizedBox();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar header() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Row(
        children: [
          CommonWidget.commonBackButton(
            onTap: () {
              Get.back();
            },
          ),
        ],
      ),
      title: CommonText.textBoldWight500(
          text: "Videos",
          fontSize: 18.sp,
          color: CommonColor.blackButtonColor1E232C),
      centerTitle: true,
    );
  }
}
