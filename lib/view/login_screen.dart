import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:expert_parrot_app/Models/repo/email_otp_repo.dart';
import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:expert_parrot_app/get_storage_services/get_storage_service.dart';
import 'package:expert_parrot_app/services/app_notification.dart';
import 'package:expert_parrot_app/view/otp_verification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';

import '../Models/repo/login_repo.dart';
import '../model/country_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();

  TextEditingController searchTextEditing = new TextEditingController();

  String? countryCode = "+91";

  List<CountryModel> _searchResult = [];

  List<CountryModel> _countryList = [];

  CountryModel? seletedCountry;

  Future<List<CountryModel>> loadCountry() async {
    String jsonString = await _loadAStudentAsset();
    final jsonResponse = json.decode(jsonString);

    List<CountryModel> listData = jsonResponse
        .map<CountryModel>((json) => CountryModel.fromJson(json))
        .toList();
    return listData;
  }

  Country? selectedCountry;
  @override
  void initState() {
    loadCountry();
    seletedCountry = CountryModel("India", "🇮🇳", "IN", "+91");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future sendOtp(final progress) async {
    progress.show();

    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: countryCode! + _mobileController.text,
      codeSent: (String verificationId, int? forceResendingToken) {
        setState(() {
          Get.to(() => OtpVerificationScreen(
                verificationId: verificationId,
                logInId: _mobileController.text.trim(),
                logInType: "mobile",
              ));
        });
        progress.dismiss();
      },
      verificationFailed: (FirebaseAuthException verificationFailed) {
        print('----verificationFailed---${verificationFailed.message}');
        CommonWidget.getSnackBar(
          message: verificationFailed.message!,
          title: 'Failed',
          duration: 2,
          color: Colors.red,
        );
        progress.dismiss();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
        print('Done');
        progress.dismiss();
      },
    );
  }

  Future googleAuthMethod(final progress) async {
    progress.show();

    if (GetStorageServices.getFcm() == null ||
        GetStorageServices.getFcm() == '') {
      await AppNotificationHandler.getFcmToken();
    }

    final GoogleSignIn _googleSignIn = GoogleSignIn();

    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    log('AUTH DETAILS :- ${credential}');
    progress.dismiss();
    try {
      await LoginRepo.loginUserRepo(
          model: {
            "loginType": "google",
            "loginId": "${credential.signInMethod}",
            "fcm_token": "${GetStorageServices.getFcm()}",
            "userTime": "${DateTime.now()}"
          },
          progress: progress,
          loginType: 'google',
          logInId: "${credential.signInMethod}");
    } catch (e) {
      progress.dismiss();

      CommonWidget.getSnackBar(
        message: '',
        title: 'Something went wrong',
        duration: 2,
        color: Colors.red,
      );
    }
  }

  Future facebookAuthMethod(final progress) async {
    try {
      progress.show();
      final result = await FacebookAuth.instance
          .login(permissions: ['public_profile', 'email']);

      if (result.status == LoginStatus.success) {
        log('RESPONSE');
        OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        log('RESPONSE1');

        final userData = await FacebookAuth.instance.getUserData();

        log('RESPONSE2');

        try {
          await LoginRepo.loginUserRepo(
              model: {
                "loginType": "facebook",
                "loginId": "${userData['id']}",
                "fcm_token": "${GetStorageServices.getFcm()}",
                "userTime": "${DateTime.now()}"
              },
              loginType: "facebook",
              logInId: "${userData['id']}",
              progress: progress);
        } catch (e) {
          progress.dismiss();

          CommonWidget.getSnackBar(
            message: '',
            title: 'Something went wrong',
            duration: 2,
            color: Colors.red,
          );
        }
      }
    } catch (error) {
      progress.dismiss();
      print('ERRORRRRRR $error');
    }
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    log('DATE TIME :- ${DateTime.now()}');
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
                  // CommonWidget.commonBackButton(onTap: () {
                  //   Get.back();
                  // }),
                  CommonWidget.commonSizedBox(height: 20),
                  CommonText.textBoldWight500(
                      text: 'Welcome back! Glad\nto see you, Again!',
                      fontSize: 22.sp),
                  CommonWidget.commonSizedBox(height: 28),
                  isChecked == true
                      ? CommonWidget.textFormField(
                          borderColor: Colors.grey.withOpacity(0.3),
                          controller: _emailController,
                          keyBoardType: TextInputType.emailAddress,
                          hintText: 'Enter Email')
                      : CommonWidget.textFormField(
                          borderColor: Colors.grey.withOpacity(0.3),
                          prefix: SizedBox(
                            width: 60.sp,
                            child: InkWell(
                              onTap: () {
                                // _displayDialog(context);
                                showCountryPicker(
                                  context: context,
                                  showPhoneCode:
                                      true, // optional. Shows phone code before the country name.
                                  onSelect: (Country country) {
                                    print(
                                        'Select country: ${country.displayName}');
                                    setState(() {
                                      selectedCountry = country;
                                    });
                                  },
                                );
                              },
                              child: Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  alignment: Alignment.center,
                                  height: 50.0,
                                  width: 100,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        selectedCountry != null
                                            ? "+ ${selectedCountry!.phoneCode}"
                                            : "+91",
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ),
                          keyBoardType: TextInputType.number,
                          controller: _mobileController,
                          hintText: 'Enter Mobile No'),
                  Row(
                    children: [
                      SizedBox(
                        height: 45,
                        width: 45,
                        child: FittedBox(
                          child: Checkbox(
                            value: isChecked,
                            activeColor: CommonColor.greenColor,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });

                              log('VALUE OF LOGIN :- $isChecked');
                            },
                          ),
                        ),
                      ),
                      CommonText.textBoldWight500(text: "Continue with Email")
                    ],
                  ),
                  CommonWidget.commonSizedBox(height: 28),
                  CommonWidget.commonButton(
                      onTap: () async {
                        if (_emailController.text.isNotEmpty ||
                            _mobileController.text.isNotEmpty) {
                          if (isChecked == false) {
                            /// Mobile
                            ///
                            await sendOtp(progress);
                          } else {
                            /// Email
                            ///

                            var resp = await EmailOTPRepo.emailOTPRepo(model: {
                              "email": "${_emailController.text.trim()}"
                            });

                            if (resp["flag"]!) {
                              Get.to(() => OtpVerificationScreen(
                                    logInId: _emailController.text.trim(),
                                    logInType: "email",
                                  ));

                              CommonWidget.getSnackBar(
                                message: resp["message"]!,
                                title: 'Failed',
                                duration: 2,
                                color: CommonColor.greenColor.withOpacity(.4),
                              );
                            } else {
                              CommonWidget.getSnackBar(
                                message:
                                    "Something went wrong please try again",
                                title: 'Failed',
                                duration: 2,
                                color: Colors.red,
                              );
                            }
                          }
                        } else {
                          CommonWidget.getSnackBar(
                              duration: 2,
                              title: "Required",
                              message: 'Please enter email or mobile no',
                              color: Colors.red,
                              colorText: Colors.white);
                        }
                      },
                      text: 'Send OTP'),
                  CommonWidget.commonSizedBox(height: 24),
                  CommonWidget.commonSvgPitcher(
                    image: 'assets/svg/Login with.svg',
                  ),
                  CommonWidget.commonSizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      commonBackButton(
                        image: 'assets/svg/facebook_ic.svg',
                        onTap: () async {
                          await facebookAuthMethod(progress);
                        },
                      ),
                      CommonWidget.commonSizedBox(width: 8),
                      commonBackButton(
                        image: 'assets/svg/google_ic.svg',
                        onTap: () async {
                          await googleAuthMethod(progress);
                        },
                      ),
                      CommonWidget.commonSizedBox(width: 8),
                      Platform.isIOS
                          ? commonBackButton(
                              image: 'assets/svg/cib_apple.svg',
                              onTap: () {},
                            )
                          : SizedBox(),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
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
          ),
        ),
      ),
    );
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter modalSetState) {
            return AlertDialog(
              content: SizedBox(
                width: double.maxFinite,
                height: 360.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Theme.of(context).primaryColor,
                      child: Card(
                        child: ListTile(
                          leading: const Icon(Icons.search),
                          title: TextField(
                            controller: searchTextEditing,
                            decoration: const InputDecoration(
                                hintText: 'Search', border: InputBorder.none),
                            onChanged: (value) {
                              onSearchTextChanged(value, modalSetState);
                            },
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.cancel),
                            onPressed: () {
                              searchTextEditing.clear();
                              onSearchTextChanged('', modalSetState);
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: _searchResult.isNotEmpty ||
                              searchTextEditing.text.isNotEmpty
                          ? ListView.builder(
                              itemCount: _searchResult.length,
                              itemBuilder: (context, i) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      seletedCountry = _searchResult[i];
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Card(
                                    margin: const EdgeInsets.all(6.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 10.0),
                                            child: Text(
                                              _searchResult[i].flag,
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            _searchResult[i].name,
                                            maxLines: 2,
                                            textAlign: TextAlign.justify,
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : ListView.builder(
                              itemCount: _countryList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      seletedCountry = _countryList[index];
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 10.0),
                                            child: Text(
                                              _countryList[index].flag,
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            _countryList[index].name,
                                            maxLines: 2,
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    child: const Text('CANCEL'),
                  ),
                )
              ],
            );
          });
        });
  }

  Future<String> _loadAStudentAsset() async {
    return await rootBundle.loadString('assets/country.JSON');
  }

  onSearchTextChanged(String text, StateSetter modalSetState) async {
    _searchResult.clear();
    if (text.isEmpty) {
      modalSetState(() {});
      return;
    }
    for (var value in _countryList) {
      if (value.name.toLowerCase().contains(text.toLowerCase()))
        _searchResult.add(value);
    }

    modalSetState(() {});
  }
}
