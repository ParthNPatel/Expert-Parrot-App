import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
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
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)),
                        height: 300,
                        child: Column(children: []),
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
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonWidget.commonBackButton(
          onTap: () {
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
          CommonWidget.commonBackButton(
            onTap: () {
              Get.back();
            },
          ),
        ],
      ),
      title: CommonText.textBoldWight500(
          text: "Reminder",
          fontSize: 18.sp,
          color: CommonColor.blackButtonColor1E232C),
      centerTitle: true,
    );
  }
}
