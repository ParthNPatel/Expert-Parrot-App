import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  TextEditingController _emailOrMobileController = TextEditingController();
  String? verificationCode;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailOrMobileController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CommonWidget.commonBackGround(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.commonSizedBox(height: 10),
          userNameWidget(),
          CommonWidget.commonSizedBox(height: 20),
          dateShowWidet(),
          CommonWidget.commonSizedBox(height: 30),
          Row(children: [
            CommonText.textBoldWight400(text: 'Med Schedule ', fontSize: 18.sp),
            Spacer(),
            Image.asset(
              ImageConst.addIcon,
              scale: 3,
            ),
            CommonWidget.commonSizedBox(width: 6),
            CommonText.textGradient(text: 'Add A Med', fontSize: 15.sp),
          ]),
          medDetailsWidget(
              image: 'assets/png/med1.png',
              medName: 'Disprien',
              medGm: '300gm',
              timeOfDay: 'Take 1 Pills (Daily)',
              color: Color(0xff21D200)),
        ],
      )),
    );
  }

  Container medDetailsWidget(
      {required String medName,
      required String medGm,
      required String timeOfDay,
      required Color color,
      required String image}) {
    return Container(
        height: 16.h,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Image.asset(
                  'assets/png/med1.png',
                  scale: 5,
                )),
            CommonWidget.commonSizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.textBoldWight500(
                    text: 'Disprien',
                    color: CommonColor.blackColor0D0D0D,
                    fontSize: 18.sp),
                CommonText.textBoldWight400(
                    text: '300gm',
                    color: CommonColor.blackColor0D0D0D,
                    fontSize: 14.sp),
                CommonWidget.commonSizedBox(height: 10),
                CommonText.textBoldWight400(
                    text: 'Take 1 Pills (Daily)',
                    color: CommonColor.blackColor0D0D0D,
                    fontSize: 12.sp),
              ],
            ),
            Spacer(),
            Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.more_vert, color: CommonColor.geryB4B4B4),
                  Container(),
                  Icon(
                    Icons.check_circle_outlined,
                    color: color,
                    size: 22.sp,
                  ),
                ]),
          ],
        ));
  }

  Row dateShowWidet() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonWidget.commonBackButton(onTap: () {
          Get.back();
        }),
        CommonWidget.commonSizedBox(width: 26),
        Column(children: [
          CommonText.textGradient(text: 'Today', fontSize: 20.sp),
          CommonText.textBoldWight400(
              color: Colors.black45, text: 'Wed 13 Sep', fontSize: 12.sp),
        ]),
        CommonWidget.commonSizedBox(width: 26),
        RotatedBox(
          quarterTurns: 2,
          child: CommonWidget.commonBackButton(onTap: () {
            Get.back();
          }),
        ),
      ],
    );
  }

  Row userNameWidget() {
    return Row(children: [
      CommonText.textBoldWight400(text: 'Good Moring, ', fontSize: 18.sp),
      CommonText.textBoldWight400(text: 'Alex!', fontSize: 18.sp),
      Spacer(),
      Image.asset('assets/png/notification.png'),
      CommonWidget.commonSizedBox(width: 6),
      Image.asset('assets/png/Face.png'),
    ]);
  }
}
