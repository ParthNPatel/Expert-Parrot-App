import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/get_storage_services/get_storage_service.dart';
import 'package:expert_parrot_app/view/depandent_screen.dart';
import 'package:expert_parrot_app/view/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constant/color_const.dart';
import '../constant/text_styel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonWidget.commonBackGround(
        body: Column(
          children: [
            header(),
            SizedBox(
              height: 13,
            ),
            CommonWidget.dottedLineWidget(),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/png/person.png'),
                            radius: 23.sp,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText.textBoldWight500(
                                  text: 'Manshi Sukla', fontSize: 15.sp),
                              SizedBox(
                                height: 5,
                              ),
                              CommonText.textBoldWight400(
                                text: 'Med Reminders',
                                fontSize: 12.sp,
                                color: Color(0xffa0a4a0),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            height: 25.sp,
                            width: 60.sp,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: CommonColor.greenColor),
                            child: Center(
                              child: Text(
                                "Edit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50.sp,
                            width: 63.sp,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade100,
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                      offset: Offset(1, 1))
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CommonText.textBoldWight500(
                                  text: '180cm',
                                  color: CommonColor.greenColor,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                CommonText.textBoldWight500(
                                  text: 'Height',
                                  fontSize: 10.sp,
                                  color: Color(0xff444444),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 50.sp,
                            width: 63.sp,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade100,
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                      offset: Offset(1, 1))
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CommonText.textBoldWight500(
                                  text: '65kg',
                                  color: CommonColor.greenColor,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                CommonText.textBoldWight500(
                                  text: 'Weight',
                                  fontSize: 10.sp,
                                  color: Color(0xff444444),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 50.sp,
                            width: 63.sp,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade100,
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                      offset: Offset(1, 1))
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CommonText.textBoldWight500(
                                  text: '22yo',
                                  color: CommonColor.greenColor,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                CommonText.textBoldWight500(
                                  text: 'Age',
                                  fontSize: 10.sp,
                                  color: Color(0xff444444),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      account(),
                      SizedBox(
                        height: 17,
                      ),
                      notification(),
                      SizedBox(
                        height: 17,
                      ),
                      other(),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container other() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 18, right: 18, top: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.textBoldWight500(text: 'Other', fontSize: 15.sp),
            SizedBox(
              height: 15,
            ),
            CommonListTile(
              onTap: () {},
              image: 'assets/svg/contact.svg',
              text: 'Contact Us',
            ),
            CommonListTile(
              onTap: () {},
              image: 'assets/svg/privacy (2).svg',
              text: 'Privacy Policy',
            ),
            CommonListTile(
              onTap: () {
                GetStorageServices.logOut();
                Get.offAll(() => SplashScreen());
              },
              image: 'assets/svg/setting.svg',
              text: 'Log Out',
            ),
            SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
    );
  }

  Container notification() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 18, right: 18, top: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.textBoldWight500(text: 'Notification', fontSize: 15.sp),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    CommonWidget.commonSvgPitcher(
                      image: 'assets/svg/notif.svg',
                      height: 18.sp,
                      width: 18.sp,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CommonText.textBoldWight400(text: 'Pop-up Notification'),
                    Spacer(),
                    SizedBox(
                      height: 23,
                      child: FittedBox(
                        child: CupertinoSwitch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
    );
  }

  Container account() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 18, right: 18, top: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.textBoldWight500(text: 'Account', fontSize: 15.sp),
            SizedBox(
              height: 15,
            ),
            CommonListTile(
              onTap: () {},
              image: 'assets/svg/personal.svg',
              text: 'Personal Data',
            ),
            CommonListTile(
              onTap: () {},
              image: 'assets/svg/achievement.svg',
              text: 'Achievement',
            ),
            CommonListTile(
              onTap: () {},
              image: 'assets/svg/activity.svg',
              text: 'Activity History',
            ),
            CommonListTile(
              onTap: () {
                Get.to(() => DependentScreen());
              },
              image: 'assets/svg/dependent.svg',
              text: 'Depandent',
            ),
            SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
    );
  }

  Row header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonWidget.commonBackButton(
          onTap: () {
            Get.back();
          },
        ),
        Spacer(),
        CommonText.textBoldWight500(text: "Profile", fontSize: 18.sp),
        SizedBox(
          width: 11.w,
        ),
        Spacer(),
      ],
    );
  }
}

class CommonListTile extends StatelessWidget {
  final image;
  final text;
  final VoidCallback onTap;

  const CommonListTile(
      {super.key,
      required this.image,
      required this.text,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            CommonWidget.commonSvgPitcher(
              image: image,
              height: 18.sp,
              width: 18.sp,
            ),
            SizedBox(
              width: 10,
            ),
            CommonText.textBoldWight400(text: text),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
