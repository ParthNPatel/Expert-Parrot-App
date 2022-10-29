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
          CommonText.textBoldWight500(
            text: 'Today',
            color: Color(0xff939492),
          ),
          SizedBox(
            height: 13,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
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
                            )
                          ],
                        )
                      ],
                    ),
                  )
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
