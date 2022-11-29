import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/get_storage_services/get_storage_service.dart';
import 'package:expert_parrot_app/view/depandent_screen.dart';
import 'package:expert_parrot_app/view/edit_profile_screen.dart';
import 'package:expert_parrot_app/view/faq_screen.dart';
import 'package:expert_parrot_app/view/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  TextEditingController nameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController ageController = TextEditingController();

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
                          InkWell(
                            onTap: () {
                              GetStorageServices.setUserBMI("15");
                              GetStorageServices.setUserHeight(height: "156");
                              GetStorageServices.setUserWeight("60");

                              Get.to(EditProfileScreen());
                              // Get.dialog(AlertDialog(
                              //   content: Column(
                              //     mainAxisSize: MainAxisSize.max,
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     children: <Widget>[
                              //       SizedBox(
                              //         height: 10,
                              //       ),
                              //       Container(
                              //         margin: const EdgeInsets.fromLTRB(
                              //             20.0, 0.0, 20.0, 20.0),
                              //         child: Text(
                              //           "Profile",
                              //         ),
                              //       ),
                              //       Stack(
                              //         alignment: Alignment.bottomRight,
                              //         children: [
                              //           Container(
                              //             height: 70,
                              //             width: 70,
                              //             decoration: BoxDecoration(
                              //                 shape: BoxShape.circle,
                              //                 color:
                              //                     Colors.grey.withOpacity(0.5)),
                              //           ),
                              //           Positioned(
                              //             //bottom: 20,
                              //             // right: 10,
                              //             child: CircleAvatar(
                              //                 backgroundColor: CommonColor
                              //                     .blackButtonColor1E232C,
                              //                 radius: 13,
                              //                 child: IconButton(
                              //                     onPressed: () {},
                              //                     icon: Icon(
                              //                       Icons.edit,
                              //                       color: Colors.white,
                              //                       size: 11,
                              //                     ))),
                              //           )
                              //         ],
                              //       ),
                              //       SizedBox(
                              //         height: 15,
                              //       ),
                              //       Padding(
                              //         padding: const EdgeInsets.symmetric(
                              //             horizontal: 16),
                              //         child: Align(
                              //           alignment: Alignment.centerLeft,
                              //           child: Text('User Name'),
                              //         ),
                              //       ),
                              //       Padding(
                              //         padding: const EdgeInsets.all(16.0),
                              //         child: TextField(
                              //           controller: nameController,
                              //           decoration: InputDecoration(
                              //             contentPadding:
                              //                 const EdgeInsets.all(8.0),
                              //             hintText: 'User Name',
                              //             // border: OutlineInputBorder(
                              //             //   borderRadius: BorderRadius.circular(5.0),
                              //             //   borderSide: const BorderSide(
                              //             //       color: ConstColors.widgetDividerColor, width: 1.0),
                              //             // ),
                              //             enabledBorder: OutlineInputBorder(
                              //               borderRadius:
                              //                   BorderRadius.circular(5.0),
                              //               borderSide: BorderSide(
                              //                   color: Colors.grey.shade300,
                              //                   width: 1.5),
                              //             ),
                              //             focusedBorder: OutlineInputBorder(
                              //               borderRadius:
                              //                   BorderRadius.circular(5.0),
                              //               borderSide: BorderSide(width: 1.5),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //       Padding(
                              //         padding: const EdgeInsets.symmetric(
                              //             horizontal: 16),
                              //         child: Align(
                              //           alignment: Alignment.centerLeft,
                              //           child: Text('Full Name'),
                              //         ),
                              //       ),
                              //       Padding(
                              //         padding: const EdgeInsets.all(12.0),
                              //         child: TextField(
                              //           controller: heightController,
                              //           decoration: InputDecoration(
                              //             contentPadding:
                              //                 const EdgeInsets.all(8.0),
                              //             hintText: 'Weight',
                              //             enabledBorder: OutlineInputBorder(
                              //               borderRadius:
                              //                   BorderRadius.circular(5.0),
                              //               borderSide: BorderSide(
                              //                   color: Colors.grey.shade300,
                              //                   width: 1.5),
                              //             ),
                              //             focusedBorder: OutlineInputBorder(
                              //               borderRadius:
                              //                   BorderRadius.circular(5.0),
                              //               borderSide: BorderSide(width: 1.5),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //       Padding(
                              //         padding: const EdgeInsets.symmetric(
                              //             horizontal: 16),
                              //         child: Align(
                              //           alignment: Alignment.centerLeft,
                              //           child: Text('Weight'),
                              //         ),
                              //       ),
                              //       Padding(
                              //         padding: const EdgeInsets.all(12.0),
                              //         child: TextField(
                              //           controller: weightController,
                              //           decoration: InputDecoration(
                              //             contentPadding:
                              //                 const EdgeInsets.all(8.0),
                              //             hintText: 'Email',
                              //             enabledBorder: OutlineInputBorder(
                              //               borderRadius:
                              //                   BorderRadius.circular(5.0),
                              //               borderSide: BorderSide(
                              //                   color: Colors.grey.shade300,
                              //                   width: 1.5),
                              //             ),
                              //             focusedBorder: OutlineInputBorder(
                              //               borderRadius:
                              //                   BorderRadius.circular(5.0),
                              //               borderSide: BorderSide(width: 1.5),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //       Padding(
                              //         padding: const EdgeInsets.symmetric(
                              //             horizontal: 16),
                              //         child: Align(
                              //           alignment: Alignment.centerLeft,
                              //           child: Text('Weight'),
                              //         ),
                              //       ),
                              //       Padding(
                              //         padding: const EdgeInsets.all(12.0),
                              //         child: TextField(
                              //           controller: ageController,
                              //           decoration: InputDecoration(
                              //             contentPadding:
                              //                 const EdgeInsets.all(8.0),
                              //             hintText: 'Age',
                              //             enabledBorder: OutlineInputBorder(
                              //               borderRadius:
                              //                   BorderRadius.circular(5.0),
                              //               borderSide: BorderSide(
                              //                   color: Colors.grey.shade300,
                              //                   width: 1.5),
                              //             ),
                              //             focusedBorder: OutlineInputBorder(
                              //               borderRadius:
                              //                   BorderRadius.circular(5.0),
                              //               borderSide: BorderSide(width: 1.5),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //       InkWell(
                              //         // onTap: () async {
                              //         //   print('enter thg escree ');
                              //         //
                              //         //   if (image != null ||
                              //         //       nameController.text.isNotEmpty &&
                              //         //           fullNameController.text.isNotEmpty) {
                              //         //     try {
                              //         //       print('enter thg escree ');
                              //         //       progress!.show();
                              //         //       if (image != null) {
                              //         //         var snapshot = await FirebaseStorage.instance
                              //         //             .ref()
                              //         //             .child(
                              //         //             'AllUserImage/${DateTime.now().microsecondsSinceEpoch}')
                              //         //             .putFile(image!);
                              //         //         liveImageURL = await snapshot.ref.getDownloadURL();
                              //         //       } else {
                              //         //         liveImageURL = '';
                              //         //       }
                              //         //       await FirebaseFirestore.instance
                              //         //           .collection('All_User_Details')
                              //         //           .doc(GetStorageServices.getToken())
                              //         //           .update({
                              //         //         'profile_image': liveImageURL,
                              //         //         'user_name': nameController.text.toString(),
                              //         //         'is_Profile_check': true,
                              //         //         'email': emailController!.text.isNotEmpty
                              //         //             ? emailController!.text.trim().toString()
                              //         //             : '',
                              //         //         'phone_no': mobileController!.text.isNotEmpty
                              //         //             ? mobileController!.text.trim().toString()
                              //         //             : '',
                              //         //         'full_name': fullNameController.text.toString(),
                              //         //       });
                              //         //
                              //         //       CommonMethode.setProfileAllDetails(
                              //         //           uid: await FirebaseAuth.instance.currentUser!.uid,
                              //         //           fullName: fullNameController.text.toString(),
                              //         //           email: emailController!.text.trim(),
                              //         //           mobile: mobileController!.text.trim(),
                              //         //           imageUrl: liveImageURL!,
                              //         //           name: nameController.text.toString());
                              //         //       Navigator.pushAndRemoveUntil(
                              //         //         context,
                              //         //         MaterialPageRoute(
                              //         //             builder: (context) => const MyLocation()),
                              //         //             (Route<dynamic> route) => false,
                              //         //       );
                              //         //       progress.dismiss();
                              //         //     } catch (e) {
                              //         //       progress!.dismiss();
                              //         //
                              //         //       return CommonWidget.getSnackBar(
                              //         //           message: 'went-wrong',
                              //         //           title: 'Failed',
                              //         //           duration: 2,
                              //         //           color: Colors.red);
                              //         //     }
                              //         //   } else {
                              //         //     CommonWidget.getSnackBar(
                              //         //         message: 'All fields are required',
                              //         //         title: 'Required',
                              //         //         duration: 2,
                              //         //         color: Colors.red);
                              //         //   }
                              //         // },
                              //         child: Container(
                              //           height: 40,
                              //           decoration: BoxDecoration(
                              //               color: CommonColor.themColor35C2C1,
                              //               borderRadius:
                              //                   BorderRadius.circular(10)),
                              //           margin: const EdgeInsets.all(10.0),
                              //           child: Center(
                              //             child: Text(
                              //               'Next',
                              //               style: TextStyle(
                              //                   color: Colors.white,
                              //                   fontSize: 16),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         height: 20,
                              //       ),
                              //     ],
                              //   ),
                              // ));

                              //
                              // Get.dialog(StatefulBuilder(
                              //     builder: (context, setState) => ));
                            },
                            child: Container(
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
              onTap: () {
                Get.to(() => FAQScreen());
              },
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
                try {
                  FirebaseAuth.instance.signOut();
                } catch (e) {}
                GetStorageServices.logOut();
                Get.offAll(() => LoginScreen());
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

//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _ProfileScreenState();
//   }
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController fullNameController = TextEditingController();
//   TextEditingController? emailController;
//   TextEditingController? mobileController;
//
//   String? liveImageURL;
//
//   bool isSignIn = false;
//   bool google = false;
//   File? image;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // print(
//     //     'getIsEmailOrPhone set prof   ${GetStorageServices.getIsEmailOrPhone()}');
//     // if (GetStorageServices.getIsEmailOrPhone() != null) {
//     //   if (GetStorageServices.getIsEmailOrPhone() == true) {
//     //     emailController =
//     //         TextEditingController(text: GetStorageServices.getEmail());
//     //     mobileController = TextEditingController();
//     //   } else {
//     //     mobileController =
//     //         TextEditingController(text: GetStorageServices.getMobile());
//     //     emailController = TextEditingController();
//     //   }
//     // } else {
//     //   mobileController = TextEditingController();
//     //   emailController = TextEditingController();
//     // }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         //resizeToAvoidBottomInset: false,
//           backgroundColor: ConstColors.backgroundColor,
//           body: _body()),
//     );
//   }
//
//   Widget _body() {
//     var width = MediaQuery.of(context).size.width;
//     var safearea = MediaQuery.of(context).padding.top;
//
//     return ProgressHUD(child: Builder(
//       builder: (context) {
//         final progress = ProgressHUD.of(context);
//
//         return SingleChildScrollView(
//           child: Container(
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
//                   child: Text(
//                     "Profile",
//                     style: GoogleFonts.urbanist(
//                         fontWeight: FontWeight.w700,
//                         fontSize: 26.0,
//                         color: Colors.black),
//                   ),
//                 ),
//                 Stack(
//                   alignment: Alignment.bottomRight,
//                   children: [
//                     Container(
//                       height: 150,
//                       width: 150,
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Colors.grey.withOpacity(0.5)),
//                       child: image == null
//                           ? Icon(
//                         color: Colors.grey,
//                         Icons.person,
//                         size: 120,
//                       )
//                           : ClipRRect(
//                           borderRadius: BorderRadius.circular(500),
//                           child: Image.file(image!, fit: BoxFit.cover)),
//                     ),
//                     Positioned(
//                       //bottom: 20,
//                       right: 10,
//                       child: CircleAvatar(
//                           backgroundColor: ConstColors.darkColor,
//                           child: IconButton(
//                               onPressed: () {
//                                 showDialogWidget();
//                               },
//                               icon: Icon(
//                                 Icons.edit,
//                                 color: Colors.white,
//                               ))),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: CommonWidget.textBoldWight500(text: 'User Name'),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: TextField(
//                     controller: nameController,
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.all(8.0),
//                       hintText: 'User Name',
//                       // border: OutlineInputBorder(
//                       //   borderRadius: BorderRadius.circular(5.0),
//                       //   borderSide: const BorderSide(
//                       //       color: ConstColors.widgetDividerColor, width: 1.0),
//                       // ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                         borderSide:
//                         BorderSide(color: Colors.grey.shade300, width: 1.5),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                         borderSide:
//                         BorderSide(color: themColors309D9D, width: 1.5),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: CommonWidget.textBoldWight500(text: 'Full Name'),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: TextField(
//                     controller: fullNameController,
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.all(8.0),
//                       hintText: 'Full Name',
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                         borderSide:
//                         BorderSide(color: Colors.grey.shade300, width: 1.5),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                         borderSide:
//                         BorderSide(color: themColors309D9D, width: 1.5),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: CommonWidget.textBoldWight500(text: 'Email'),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: TextField(
//                     controller: emailController,
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.all(8.0),
//                       hintText: 'Email',
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                         borderSide:
//                         BorderSide(color: Colors.grey.shade300, width: 1.5),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                         borderSide:
//                         BorderSide(color: themColors309D9D, width: 1.5),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: CommonWidget.textBoldWight500(text: 'Phone no'),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: TextField(
//                     controller: mobileController,
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.all(8.0),
//                       hintText: 'Phone no',
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                         borderSide:
//                         BorderSide(color: Colors.grey.shade300, width: 1.5),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                         borderSide:
//                         BorderSide(color: themColors309D9D, width: 1.5),
//                       ),
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () async {
//                     print('enter thg escree ');
//
//                     if (image != null ||
//                         nameController.text.isNotEmpty &&
//                             fullNameController.text.isNotEmpty) {
//                       try {
//                         print('enter thg escree ');
//                         progress!.show();
//                         if (image != null) {
//                           var snapshot = await FirebaseStorage.instance
//                               .ref()
//                               .child(
//                               'AllUserImage/${DateTime.now().microsecondsSinceEpoch}')
//                               .putFile(image!);
//                           liveImageURL = await snapshot.ref.getDownloadURL();
//                         } else {
//                           liveImageURL = '';
//                         }
//                         await FirebaseFirestore.instance
//                             .collection('All_User_Details')
//                             .doc(GetStorageServices.getToken())
//                             .update({
//                           'profile_image': liveImageURL,
//                           'user_name': nameController.text.toString(),
//                           'is_Profile_check': true,
//                           'email': emailController!.text.isNotEmpty
//                               ? emailController!.text.trim().toString()
//                               : '',
//                           'phone_no': mobileController!.text.isNotEmpty
//                               ? mobileController!.text.trim().toString()
//                               : '',
//                           'full_name': fullNameController.text.toString(),
//                         });
//
//                         CommonMethode.setProfileAllDetails(
//                             uid: await FirebaseAuth.instance.currentUser!.uid,
//                             fullName: fullNameController.text.toString(),
//                             email: emailController!.text.trim(),
//                             mobile: mobileController!.text.trim(),
//                             imageUrl: liveImageURL!,
//                             name: nameController.text.toString());
//                         Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const MyLocation()),
//                               (Route<dynamic> route) => false,
//                         );
//                         progress.dismiss();
//                       } catch (e) {
//                         progress!.dismiss();
//
//                         return CommonWidget.getSnackBar(
//                             message: 'went-wrong',
//                             title: 'Failed',
//                             duration: 2,
//                             color: Colors.red);
//                       }
//                     } else {
//                       CommonWidget.getSnackBar(
//                           message: 'All fields are required',
//                           title: 'Required',
//                           duration: 2,
//                           color: Colors.red);
//                     }
//                   },
//                   child: Container(
//                     height: 40,
//                     decoration: BoxDecoration(
//                         color: ConstColors.darkColor,
//                         borderRadius: BorderRadius.circular(10)),
//                     margin: const EdgeInsets.all(10.0),
//                     child: Center(
//                       child: Text(
//                         'Next',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     ));
//   }
//
//   imageUpload() async {
//     var snapshot = await FirebaseStorage.instance
//         .ref()
//         .child('AllUserImage/${DateTime.now().microsecondsSinceEpoch}')
//         .putFile(image!);
//     liveImageURL = await snapshot.ref.getDownloadURL();
//   }
//
//   showDialogWidget() {
//     return showDialog(
//         context: context,
//         builder: (_) => SimpleDialog(
//           children: [
//             Column(
//               children: [
//                 InkWell(
//                   onTap: () async {
//                     Navigator.of(context).pop();
//                     await imageFromGallery();
//                   },
//                   child: Container(
//                     height: 40,
//                     width: 160,
//                     decoration: BoxDecoration(
//                         color: ConstColors.darkColor,
//                         borderRadius: BorderRadius.circular(16)),
//                     margin: const EdgeInsets.all(10.0),
//                     child: Center(
//                       child: Text(
//                         'Gallery',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () async {
//                     Navigator.of(context).pop();
//                     await imageFromCamera();
//                   },
//                   child: Container(
//                     height: 40,
//                     width: 160,
//                     decoration: BoxDecoration(
//                         color: ConstColors.darkColor,
//                         borderRadius: BorderRadius.circular(16)),
//                     margin: const EdgeInsets.all(10.0),
//                     child: Center(
//                       child: Text(
//                         'Camera',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ));
//   }
//
//   imageFromGallery() async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? pickImage =
//     await _picker.pickImage(source: ImageSource.gallery);
//     image = File(pickImage!.path);
//     setState(() {});
//   }
//
//   imageFromCamera() async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? pickImage =
//     await _picker.pickImage(source: ImageSource.camera);
//     image = File(pickImage!.path);
//     setState(() {});
//   }
// }
