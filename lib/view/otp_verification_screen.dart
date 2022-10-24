import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:sizer/sizer.dart';

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
          Container(
            width: 280,
            child: OTPTextField(
              length: 4,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 60,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              otpFieldStyle: OtpFieldStyle(
                backgroundColor: Colors.white,
                borderColor: CommonColor.themColor35C2C1,
                disabledBorderColor: Colors.transparent,
                enabledBorderColor: CommonColor.themColor35C2C1,
                errorBorderColor: CommonColor.themColor35C2C1,
                focusBorderColor: CommonColor.themColor35C2C1,
              ),
              onCompleted: (pin) {
                verificationCode = pin;
              },
            ),
          ),
          CommonWidget.commonSizedBox(height: 28),
          CommonWidget.commonButton(onTap: () {}, text: 'Verify'),
        ],
      )),
    );
  }
}
