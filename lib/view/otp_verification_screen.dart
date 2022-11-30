import 'dart:developer';

import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/responseModel/log_in_res_model.dart';
import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:expert_parrot_app/get_storage_services/get_storage_service.dart';
import 'package:expert_parrot_app/view/bottom_nav_screen.dart';
import 'package:expert_parrot_app/viewModel/log_in_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:sizer/sizer.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String? verificationId;
  final String? logInId;
  const OtpVerificationScreen({Key? key, this.verificationId, this.logInId})
      : super(key: key);

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

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  LogInViewModel logInViewModel = Get.put(LogInViewModel());

  Future enterOtp(final progress) async {
    try {
      PhoneAuthCredential phoneAuthProvider =
          await PhoneAuthProvider.credential(
              verificationId: widget.verificationId!,
              smsCode: verificationCode!);
      if (phoneAuthProvider == null) {
        Get.snackbar('Empty', 'Enter OTP');
        progress.dismiss();
      }
      // if (firebaseAuth.currentUser!.uid.isNotEmpty) {
      await logInViewModel.logInViewModel(model: {
        "name": "Helo",
        "loginType": "mobile",
        "loginId": "${widget.logInId}",
        "water": 3,
        "weight": 65,
        // "height": 165,
        // "age": 25,
        "heartRate": 98,
        "bmi": 21.1,
        "fcm_token": "${GetStorageServices.getFcm()}",
        "userTime": "${DateTime.now()}"
      });

      if (logInViewModel.logInApiResponse.status.toString() ==
          Status.COMPLETE.toString()) {
        LogInResponseModel responseModel = logInViewModel.logInApiResponse.data;

        // print(
        //     'response weight ============== > ${responseModel.data!.userImage}');

        Get.offAll(() => BottomNavScreen());
        GetStorageServices.setUserLoggedIn();
        GetStorageServices.setBarrierToken(responseModel.token);
        GetStorageServices.setUserName(responseModel.data!.name!);
        // GetStorageServices.setUserHeight(responseModel.data!.height!);
        GetStorageServices.setUserWeight(responseModel.data!.weight!);
        // GetStorageServices.setAge(responseModel.data!.age!);
        // GetStorageServices.setUserImage(responseModel.data!.userImage!);
        GetStorageServices.setUserProfileSet(responseModel.data!.profileSet!);
        log('BARRIER TOKEN :- ${GetStorageServices.getBarrierToken()}');
        progress.dismiss();
      }
      if (logInViewModel.logInApiResponse.status.toString() ==
          Status.ERROR.toString()) {
        CommonWidget.getSnackBar(
          message: '',
          title: 'Failed',
          duration: 2,
          color: Colors.red,
        );
        progress.dismiss();
      }
      progress.dismiss();
      // }
    } catch (e) {
      progress.dismiss();
      CommonWidget.getSnackBar(
        message: '',
        title: 'Enter valid OTP',
        duration: 2,
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ProgressHUD(
        child: Builder(
          builder: (context) {
            final progress = ProgressHUD.of(context);

            return CommonWidget.commonBackGround(
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
                      length: 6,
                      width: 260.sp,
                      fieldWidth: 40,
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
                  // TextField(
                  //   controller: _emailOrMobileController,
                  // ),
                  CommonWidget.commonSizedBox(height: 28),
                  CommonWidget.commonButton(
                    onTap: () async {
                      if (_emailOrMobileController.text.toString().isNotEmpty ||
                          verificationCode != null) {
                        if (verificationCode.toString().length == 6) {
                          progress!.show();
                          await enterOtp(progress);
                        } else {
                          progress!.dismiss();
                          CommonWidget.getSnackBar(
                              duration: 2,
                              title: "Failed",
                              message: 'Otp must be 6 digit',
                              color: Colors.red,
                              colorText: Colors.white);
                        }
                      } else {
                        CommonWidget.getSnackBar(
                            duration: 2,
                            title: "Required",
                            message: 'Otp can not be empty',
                            color: Colors.red,
                            colorText: Colors.white);
                      }
                    },
                    text: 'Verify',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
