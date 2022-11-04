import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/controller/HandleFloatController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../components/common_widget.dart';
import '../constant/text_styel.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
      //extendBody: false,
      //primary: false,
      body: CommonWidget.commonBackGround(
          body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          header(),
          SizedBox(
            height: 13,
          ),
          CommonWidget.dottedLineWidget(),
          SizedBox(
            height: 23,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  CommonText.textBoldWight500(
                    text: 'Today',
                    color: Color(0xff939492),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/png/person1.png',
                              height: 40.sp,
                              width: 40.sp,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText.textBoldWight500(
                                    text: "Vill Parmar", fontSize: 12.sp),
                                CommonText.textBoldWight400(
                                    text: "ON, Canada",
                                    color: Color(0xffa1a1a1),
                                    fontSize: 10.sp),
                              ],
                            ),
                            Spacer(),
                            CommonText.textBoldWight400(
                                text: "1 hour ago",
                                color: Color(0xffa1a1a1),
                                fontSize: 10.sp),
                          ],
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText.textBoldWight400(
                                text:
                                    "anyone know softgel pill details? What is a softgel pill? What is inside a softgel?",
                                color: Color(0xffa1a1a1),
                                fontSize: 11.sp),
                            SizedBox(
                              height: 20,
                            ),
                            CommonText.textBoldWight400(
                                text:
                                    "If anyone have knowalge text in commment box.",
                                color: Color(0xffa1a1a1),
                                fontSize: 11.sp),
                          ],
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Divider(
                          thickness: 1.2,
                          color: Color(0xffE0E1E2),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        LikeAndCommentWidget(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/png/person1.png',
                              height: 40.sp,
                              width: 40.sp,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText.textBoldWight500(
                                    text: "Adam LR", fontSize: 12.sp),
                                CommonText.textBoldWight400(
                                    text: "QR, Canada",
                                    color: Color(0xffa1a1a1),
                                    fontSize: 10.sp),
                              ],
                            ),
                            Spacer(),
                            CommonText.textBoldWight400(
                                text: "2 hour ago",
                                color: Color(0xffa1a1a1),
                                fontSize: 10.sp),
                          ],
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText.textBoldWight400(
                                text: "anyone know softgel pill details?",
                                color: Color(0xffa1a1a1),
                                fontSize: 11.sp),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 130.sp,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: AssetImage(
                                      "assets/png/medicine.png",
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Divider(
                          thickness: 1.2,
                          color: Color(0xffE0E1E2),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        LikeAndCommentWidget(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CommonText.textBoldWight500(
                    text: 'Yesterday',
                    color: Color(0xff939492),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/png/person1.png',
                              height: 40.sp,
                              width: 40.sp,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText.textBoldWight500(
                                    text: "Vill Parmar", fontSize: 12.sp),
                                CommonText.textBoldWight400(
                                    text: "ON, Canada",
                                    color: Color(0xffa1a1a1),
                                    fontSize: 10.sp),
                              ],
                            ),
                            Spacer(),
                            CommonText.textBoldWight400(
                                text: "1 hour ago",
                                color: Color(0xffa1a1a1),
                                fontSize: 10.sp),
                          ],
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText.textBoldWight400(
                                text:
                                    "anyone know softgel pill details? What is a softgel pill? What is inside a softgel?",
                                color: Color(0xffa1a1a1),
                                fontSize: 11.sp),
                            SizedBox(
                              height: 20,
                            ),
                            CommonText.textBoldWight400(
                                text:
                                    "If anyone have knowalge text in commment box.",
                                color: Color(0xffa1a1a1),
                                fontSize: 11.sp),
                          ],
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Divider(
                          thickness: 1.2,
                          color: Color(0xffE0E1E2),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        LikeAndCommentWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
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
        CommonText.textBoldWight500(text: "Community", fontSize: 18.sp),
        Image.asset(
          'assets/png/chat1.png',
          height: 23.sp,
          width: 23.sp,
        )
      ],
    );
  }
}

class LikeAndCommentWidget extends StatefulWidget {
  const LikeAndCommentWidget({Key? key}) : super(key: key);

  @override
  State<LikeAndCommentWidget> createState() => _LikeAndCommentWidgetState();
}

class _LikeAndCommentWidgetState extends State<LikeAndCommentWidget> {
  bool isLiked = false;
  bool isCommentOpened = false;

  final commentController = TextEditingController();

  HandleFloatController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isLiked = !isLiked;
                });
              },
              child: Row(
                children: [
                  Image.asset(
                    isLiked == true
                        ? 'assets/png/like (2).png'
                        : "assets/png/like_outlined.png",
                    height: isLiked == true ? 17.sp : 15.sp,
                    width: isLiked == true ? 17.sp : 15.sp,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CommonText.textBoldWight400(text: "15", fontSize: 11.sp),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isCommentOpened = !isCommentOpened;
                });
              },
              child: Row(
                children: [
                  Image.asset(
                    "assets/png/comment.png",
                    height: 17.sp,
                    width: 17.sp,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CommonText.textBoldWight400(text: "2", fontSize: 11.sp),
                ],
              ),
            ),
          ],
        ),
        Visibility(
          visible: isCommentOpened,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/png/person1.png',
                    height: 40.sp,
                    width: 40.sp,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          onTap: () {
                            controller.changeVisibility(true);
                          },
                          controller: commentController,
                          maxLines: 2,
                          decoration: InputDecoration(
                            hintText: "Add a comment...",
                            hintStyle: TextStyle(
                              color: Color(0xffeaebed),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: BorderSide(
                                color: Color(0xffeaebed),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: BorderSide(
                                color: Color(0xffeaebed),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            if (commentController.text.isNotEmpty) {
                              setState(
                                () {},
                              );
                              isCommentOpened = false;
                              commentController.clear();
                              controller.changeVisibility(false);
                            } else {
                              controller.changeVisibility(false);

                              CommonWidget.getSnackBar(
                                  title: "Required",
                                  duration: 2,
                                  message: "Please enter your comment",
                                  color: Colors.red,
                                  colorText: Colors.white);
                            }
                          },
                          child: Container(
                            height: 28.sp,
                            width: 65,
                            decoration: BoxDecoration(
                              color: CommonColor.greenColor,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Center(
                              child: CommonText.textBoldWight500(
                                text: "Post",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/png/person2.png',
                    height: 40.sp,
                    width: 40.sp,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText.textBoldWight500(
                          text: "Courtney Henry", fontSize: 12.sp),
                      SizedBox(
                        height: 3,
                      ),
                      CommonText.textBoldWight400(
                          text:
                              "Ultricies ultricies interdum sodales.\nVitae feugiat vitae quis id",
                          color: Color(0xffa1a1a1),
                          fontSize: 10.sp),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/png/person1.png',
                    height: 40.sp,
                    width: 40.sp,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText.textBoldWight500(
                          text: "Robert Albert", fontSize: 12.sp),
                      SizedBox(
                        height: 3,
                      ),
                      CommonText.textBoldWight400(
                          text:
                              "Vitae feugiat vitae quis id Ultricies\n ultricies interdum sodales.",
                          color: Color(0xffa1a1a1),
                          fontSize: 10.sp),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
