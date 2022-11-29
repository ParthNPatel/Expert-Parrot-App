import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  List<String> menu = ['General', 'Account', 'Service', 'Application'];
  int selectMenu = 0;
  bool value = false;
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CommonWidget.commonBackGround(
        body: Center(
          child: Column(
            children: [
              CommonWidget.faqHeader(
                  backOnTap: () {
                    Get.back();
                  },
                  addOnTap: () {},
                  titleText: TextConst.faq),
              CommonWidget.commonSizedBox(height: 13),
              DottedLine(
                lineLength: double.infinity,
                lineThickness: 1.0,
                dashLength: 10.0,
                dashColor: Color(0xffbac2ba),
                dashRadius: 0.0,
                dashGapLength: 6.0,
                dashGapColor: Colors.transparent,
                dashGapRadius: 0.0,
              ),
              CommonWidget.commonSizedBox(height: 27.sp),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                      menu.length,
                      (index) {
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectMenu = index;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.sp, vertical: 8.sp),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000),
                                  color: selectMenu == index
                                      ? CommonColor.greenColor
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: CommonColor.greenColor,
                                  ),
                                ),
                                child: CommonText.textBoldWight600(
                                    text: '${menu[index]}',
                                    color: selectMenu == index
                                        ? CommonColor.whiteColorEDEDED
                                        : CommonColor.blackColor0D0D0D),
                              ),
                            ),
                            SizedBox(
                              width: 12.sp,
                            )
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
              CommonWidget.commonSizedBox(height: 20.sp),
              CommonWidget.textFormField(
                borderColor: Colors.transparent,
                controller: search,
                hintText: 'Search',
                prefix: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageConst.search),
                  ],
                ),
                suffix: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageConst.filter),
                  ],
                ),
              ),
              CommonWidget.commonSizedBox(height: 20.sp),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            textColor: CommonColor.blackColor0D0D0D,
                            collapsedTextColor: CommonColor.blackColor0D0D0D,
                            iconColor: Colors.white,
                            onExpansionChanged: (val) {
                              setState(() {
                                value = val;
                              });
                              log('VALUE $value');
                            },
                            trailing: value == false
                                ? Transform.rotate(
                                    angle: 3.1,
                                    child: SvgPicture.asset(ImageConst.arrow))
                                : SvgPicture.asset(ImageConst.arrow),
                            collapsedIconColor: Colors.white,
                            childrenPadding: EdgeInsets.only(
                                left: 10.sp, right: 10.sp, bottom: 10.sp),
                            children: [
                              CommonText.textBoldWight500(
                                  text:
                                      '''Lorem sum has been the industry's standard dummy text ever since the 1500s, when an unknown rinter ok a galley of type and scrambled it tomake a type specimen book.''',
                                  fontSize: 14),
                            ],
                            title: CommonText.textBoldWight500(
                              text: 'How Order charges calculate?',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.sp,
                      )
                    ]);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
