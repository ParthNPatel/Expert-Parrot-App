import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:expert_parrot_app/Models/repo/login_repo.dart';
import 'package:expert_parrot_app/Models/requestModel/login_req_model.dart';
import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:country_picker/country_picker.dart';
import '../model/country_model.dart';
import 'otp_verification_screen.dart';

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

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CommonWidget.commonBackGround(
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
                    controller: _emailController, hintText: 'Enter Email')
                : CommonWidget.textFormField(
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
                              print('Select country: ${country.displayName}');
                              setState(() {
                                selectedCountry = country;
                              });
                            },
                          );
                        },
                        child: Container(
                            margin:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            alignment: Alignment.center,
                            height: 50.0,
                            width: 100,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  // LoginReqModel model = LoginReqModel();
                  //
                  // model.name = "Parth";
                  // model.fcmToken =
                  //     "e2kl8jtGQDWyp8nPm0O0u1:APA91bGIPIr8b4wSYiL_VEuz5I1HHE7VGH68tPi8X4AAxCAyl1Y5OW6cSnhMo1vMATj5kJEGmqWhGeabveOAQ7GxA3rOLLf3-GCJtKRPfsBJ_OM54Pm-G7zcPmDuaFXh04ZGvx7rtT3l";
                  // model.loginId = "${DateTime.now()}";
                  // model.loginType = "phone";
                  //
                  // LoginRepo.loginUserRepo(model: model);

                  var headers = {'Content-Type': 'application/json'};
                  var request = http.Request(
                      'POST', Uri.parse('http://3.109.139.48:5000/auth/login'));
                  request.body = json.encode({
                    "name": "Parth",
                    "loginType": "phone",
                    "loginId": "${DateTime.now()}",
                    "fcm_token":
                        "e2kl8jtGQDWyp8nPm0O0u1:APA91bGIPIr8b4wSYiL_VEuz5I1HHE7VGH68tPi8X4AAxCAyl1Y5OW6cSnhMo1vMATj5kJEGmqWhGeabveOAQ7GxA3rOLLf3-GCJtKRPfsBJ_OM54Pm-G7zcPmDuaFXh04ZGvx7rtT3l"
                  });

                  request.headers.addAll(headers);

                  http.StreamedResponse response = await request.send();

                  if (response.statusCode == 200) {
                    print(await response.stream.bytesToString());
                  } else {
                    print(response.reasonPhrase);
                  }

                  if (_emailController.text.isNotEmpty ||
                      _mobileController.text.isNotEmpty) {
                    Get.to(() => OtpVerificationScreen());
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
            )),
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
