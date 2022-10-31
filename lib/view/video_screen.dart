import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:expert_parrot_app/view/viedeo_play_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../components/common_widget.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  List<String> imageList = [
    ImageConst.video1Image,
    ImageConst.video2Image,
    ImageConst.video3Image,
  ];
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
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => VideoPlayScreen());
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
                                      child: Image.asset(
                                        imageList[index],
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(children: [
                                    CommonText.textBoldWight400(
                                        text: TextConst.videoBody,
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
                                        text: 'Video Short description Here',
                                        fontSize: 9.sp,
                                        color: CommonColor.gery787878),
                                    Spacer(),
                                    CommonText.textBoldWight500(
                                        text: '09:35 AM',
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
                                  CommonWidget.commonSvgPitcher(
                                      height: 20,
                                      image: ImageConst.hartBorderIcon,
                                      color: CommonColor.gery636363),
                                  CommonText.textBoldWight400(
                                      text: '143K',
                                      fontSize: 13.sp,
                                      color: CommonColor.gery636363),
                                ]),
                                Spacer(),
                                Column(children: [
                                  Image.asset(ImageConst.shareIcon,
                                      scale: 4, color: CommonColor.gery636363),

                                  // CommonWidget.commonSvgPitcher(
                                  //     height: 20,
                                  //     image: ImageConst.shareIcon,
                                  //     color: CommonColor.gery636363),
                                  CommonText.textBoldWight400(
                                      text: TextConst.share,
                                      fontSize: 13.sp,
                                      color: CommonColor.gery636363),
                                ]),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
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
