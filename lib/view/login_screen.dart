import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'otp_verification_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailOrMobileController = TextEditingController();
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
          CommonWidget.commonSizedBox(height: 8),
          CommonWidget.commonBackButton(onTap: () {
            Get.back();
          }),
          CommonWidget.commonSizedBox(height: 40),
          CommonText.textBoldWight500(
              text: 'Welcome back! Glad\n to see you, Again!', fontSize: 24.sp),
          CommonWidget.commonSizedBox(height: 28),
          CommonWidget.textFormField(
              controller: _emailOrMobileController,
              hintText: 'Enter Email Or Mobile No'),
          CommonWidget.commonSizedBox(height: 28),
          CommonWidget.commonButton(
              onTap: () {
                Get.to(() => OtpVerificationScreen());
              },
              text: 'Send OTP'),
          CommonWidget.commonSizedBox(height: 24),
          CommonWidget.commonSvgPitcher(
            image: 'assets/svg/Login with.svg',
          ),
          CommonWidget.commonSizedBox(height: 14),
          Row(
            children: [
              commonBackButton(
                image: 'assets/svg/facebook_ic.svg',
                onTap: () {},
              ),
              CommonWidget.commonSizedBox(width: 8),
              commonBackButton(
                image: 'assets/svg/google_ic.svg',
                onTap: () {},
              ),
              CommonWidget.commonSizedBox(width: 8),
              commonBackButton(
                image: 'assets/svg/cib_apple.svg',
                onTap: () {},
              ),
            ],
          )
        ],
      )),
    );
  }

  Widget commonBackButton({final onTap, required String image}) {
    return Expanded(
      child: Container(
        height: 42.sp,
        // width: 70.sp,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(image, fit: BoxFit.contain),
            )),
      ),
    );
  }
}
