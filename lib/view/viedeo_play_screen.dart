import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';
import '../components/common_widget.dart';
import '../constant/color_const.dart';
import '../constant/text_const.dart';
import '../constant/text_styel.dart';

class VideoPlayScreen extends StatefulWidget {
  const VideoPlayScreen({Key? key}) : super(key: key);

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.play();
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              color: Colors.black,
              child: _controller.value.isInitialized
                  ? Container(
                      height: Get.height,
                      width: Get.width,
                      child: AspectRatio(
                        aspectRatio: Get.height,
                        child: VideoPlayer(_controller),
                      ),
                    )
                  : Container(),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: header(),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CommonWidget.commonSvgPitcher(
                        height: 20,
                        image: ImageConst.hartBorderIcon,
                        color: Colors.white),
                    CommonText.textBoldWight400(
                        text: '143K', fontSize: 13.sp, color: Colors.white),
                    CommonWidget.commonSizedBox(height: 20),
                    Image.asset(ImageConst.shareIcon, scale: 4),
                    CommonText.textBoldWight400(
                        text: TextConst.share,
                        fontSize: 13.sp,
                        color: Colors.white),
                    CommonWidget.commonSizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CommonText.textBoldWight500(
                          text: 'Video Body',
                          fontSize: 13.sp,
                          color: Colors.white),
                    ),
                    CommonWidget.commonSizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CommonText.textBoldWight300(
                          color: CommonColor.whiteColorEDEDED,
                          text:
                              'Reference site about Lorem Ipsum, giving information \non its origins, as well as a random Lipsum More',
                          fontSize: 9.sp),
                    ),
                    CommonWidget.commonSizedBox(height: 20)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar header() {
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonWidget.commonBackButton(
          onTap: () {
            print('back work');
            Get.back();
          },
        ),
        Spacer(),
        CommonText.textBoldWight500(text: "Reminder", fontSize: 18.sp),
        Spacer(),
      ],
    );
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Row(
        children: [
          CommonWidget.commonSvgPitcher(image: ImageConst.closeIcon),
        ],
      ),
      title: CommonText.textBoldWight700(
        text: TextConst.videos,
        fontSize: 14.sp,
      ),
      centerTitle: true,
    );
  }
}
