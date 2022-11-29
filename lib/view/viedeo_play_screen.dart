import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/viewModel/get_video_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../components/common_widget.dart';
import '../constant/color_const.dart';
import '../constant/text_const.dart';
import '../constant/text_styel.dart';

class VideoPlayScreen extends StatefulWidget {
  final String videoLink;
  final String title;
  final String description;
  final String likes;
  final bool? likeValue;

  const VideoPlayScreen(
      {Key? key,
      required this.videoLink,
      required this.title,
      required this.description,
      required this.likes,
      this.likeValue})
      : super(key: key);

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  late VideoPlayerController _controller;
  GetVideoViewModel likeUnlikeViewModel = Get.put(GetVideoViewModel());

  @override
  void initState() {
    likeUnlikeViewModel.like = widget.likeValue!;

    super.initState();
    _controller = VideoPlayerController.network('${widget.videoLink}')
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
          clipBehavior: Clip.none,
          children: [
            AbsorbPointer(
              child: Container(
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
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        print('on like tap');
                      },
                      child: Column(
                        children: [
                          CommonWidget.commonSvgPitcher(
                              height: 20,
                              image: ImageConst.hartBorderIcon,
                              color: Colors.white),
                          CommonText.textBoldWight400(
                              text: '${widget.likes}',
                              fontSize: 13.sp,
                              color: Colors.white),
                        ],
                      ),
                    ),
                    CommonWidget.commonSizedBox(height: 20),
                    InkWell(
                        onTap: () {
                          print('on tap in share');

                          Share.share('${widget.videoLink}', subject: '');
                        },
                        child: Column(
                          children: [
                            Image.asset(ImageConst.shareIcon, scale: 4),
                            CommonText.textBoldWight400(
                                text: TextConst.share,
                                fontSize: 13.sp,
                                color: Colors.white),
                          ],
                        )),
                    CommonWidget.commonSizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CommonText.textBoldWight500(
                          text: '${widget.title}',
                          fontSize: 13.sp,
                          color: Colors.white),
                    ),
                    CommonWidget.commonSizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CommonText.textBoldWight300(
                          color: CommonColor.whiteColorEDEDED,
                          text: '${widget.description}',
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
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Row(
        children: [
          InkWell(
              onTap: () {
                print('back work');
                Get.back();
              },
              child:
                  CommonWidget.commonSvgPitcher(image: ImageConst.closeIcon)),
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
