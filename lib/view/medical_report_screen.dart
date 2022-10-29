import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../components/common_widget.dart';

class MedicalReportScreen extends StatefulWidget {
  const MedicalReportScreen({Key? key}) : super(key: key);

  @override
  State<MedicalReportScreen> createState() => _MedicalReportScreenState();
}

class _MedicalReportScreenState extends State<MedicalReportScreen> {
  int index = 0;
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
            userProfileWidget(),
            CommonWidget.commonSizedBox(height: 23),
            Container(
              width: Get.width,
              height: 186.sp,
              child: Image.asset(
                ImageConst.verticalGraph, fit: BoxFit.contain,
                // scale: 5.5,
              ),
            ),
            CommonWidget.commonSizedBox(height: 25),
            tabWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Container(
                      height: 28.sp,
                      width: 28.sp,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 20.0,
                          ),
                        ],
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: CommonWidget.commonSvgPitcher(
                          height: 50, image: ImageConst.capsule1)),
                  CommonWidget.commonSizedBox(width: 8),
                  CommonText.textBoldWight500(
                      text: 'Softgel',
                      color: CommonColor.blackColor353535,
                      fontSize: 14.sp),
                ]),
                Row(
                  children: [
                    CommonText.textBoldWight500(
                        text: '09:28 AM',
                        color: CommonColor.blackColor353535,
                        fontSize: 13.sp),
                    CommonWidget.commonSvgPitcher(
                      image: ImageConst.verified,
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row tabWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            index = 0;
            setState(() {});
          },
          child: Container(
            alignment: Alignment.center,
            width: 100,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
                color: Colors.red,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: index == 0
                        ? [
                            // 45C42C
                            // 06A0BF
                            Color(0xff45C42C),
                            Color(0xff06A0BF),
                          ]
                        : [
                            Colors.white,
                            Colors.white,
                          ]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    topLeft: Radius.circular(8))),
            child: CommonText.textBoldWight500(
                text: 'Taked',
                fontSize: 12.sp,
                color:
                    index == 0 ? Colors.white : CommonColor.blackColor4C4C4C),
          ),
        ),
        GestureDetector(
          onTap: () {
            index = 1;
            setState(() {});
          },
          child: Container(
            width: 100,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
                color: Colors.red,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: index == 1
                        ? [
                            // 45C42C
                            // 06A0BF
                            Color(0xff45C42C),
                            Color(0xff06A0BF),
                          ]
                        : [
                            Colors.white,
                            Colors.white,
                          ]),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
            child: CommonText.textBoldWight500(
                text: 'Not Taken',
                fontSize: 12.sp,
                color:
                    index == 1 ? Colors.white : CommonColor.blackColor4C4C4C),
          ),
        ),
      ],
    );
  }

  Row userProfileWidget() {
    return Row(
      children: [
        CommonWidget.commonSizedBox(width: 26),
        Container(
          height: 44.sp,
          decoration: BoxDecoration(
              border: Border.all(color: CommonColor.greenColor, width: 2),
              shape: BoxShape.circle),
          width: 44.sp,
          child: Image.asset(ImageConst.profile1),
        ),
        CommonWidget.commonSizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.textBoldWight500(
                text: 'Ellaa',
                fontSize: 12.sp,
                color: CommonColor.blackColor1B1B1B),
            CommonText.textBoldWight500(
                text: 'Daughter',
                fontSize: 9.sp,
                color: CommonColor.gery72777A),
          ],
        )
      ],
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
