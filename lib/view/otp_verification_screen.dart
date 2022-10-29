import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:expert_parrot_app/get_storage_services/get_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:sizer/sizer.dart';

import 'dashboard_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
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
          CommonWidget.commonSizedBox(height: 8),
          CommonWidget.commonBackButton(onTap: () {
            Get.back();
          }),
          CommonWidget.commonSizedBox(height: 40),
          CommonText.textBoldWight500(
              text: 'OTP Verification', fontSize: 24.sp),
          CommonWidget.commonSizedBox(height: 8),
          CommonText.textBoldWight400(
              color: CommonColor.hintTextColor8391A1,
              text:
                  'Enter the verification code we just sent on your email address.',
              fontSize: 12.sp),
          CommonWidget.commonSizedBox(height: 20),
          Center(
            child: OTPTextField(
              length: 4,
              width: 280.sp,
              fieldWidth: 60,
              keyboardType: TextInputType.number,
              contentPadding: EdgeInsets.symmetric(vertical: 5),
              style: TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              outlineBorderRadius: 7,
              otpFieldStyle: OtpFieldStyle(
                backgroundColor: Colors.white,
                borderColor: CommonColor.themColor35C2C1,
                disabledBorderColor: Color(0xffE8ECF4),
                enabledBorderColor: CommonColor.themColor35C2C1,
                errorBorderColor: CommonColor.themColor35C2C1,
                focusBorderColor: CommonColor.themColor35C2C1,
              ),
              onChanged: (value) {
                setState(() {});
                verificationCode = value;
              },
              onCompleted: (pin) {
                setState(
                  () {},
                );
                verificationCode = pin;
              },
            ),
          ),
          CommonWidget.commonSizedBox(height: 28),
          CommonWidget.commonButton(
              onTap: () {
                if (verificationCode != null && verificationCode!.length == 4) {
                  if (verificationCode!.length == 4) {
                    GetStorageServices.setUserLoggedIn();
                    Get.offAll(() => DashBoardScreen());
                  } else {
                    CommonWidget.getSnackBar(
                        duration: 2,
                        title: "Failed",
                        message: 'Otp must be 4 digit',
                        color: Colors.red,
                        colorText: Colors.white);
                  }
                }
              },
              text: 'Verify'),
        ],
      )),
    );
  }
}
