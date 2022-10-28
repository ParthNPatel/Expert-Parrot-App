import 'package:dotted_line/dotted_line.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../components/common_widget.dart';

class WaterGraphScreen extends StatefulWidget {
  const WaterGraphScreen({Key? key}) : super(key: key);

  @override
  State<WaterGraphScreen> createState() => _WaterGraphScreenState();
}

class _WaterGraphScreenState extends State<WaterGraphScreen> {
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
            SizedBox(
              height: 23,
            ),
            Container(
                height: 500, child: Image.asset('assets/png/fl_chart.png'))
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
        CommonText.textBoldWight500(text: TextConst.water, fontSize: 18.sp),
        CommonWidget.commonBackButton(
          image: ImageConst.add,
          onTap: () {
            Get.back();
          },
        ),
      ],
    );
  }
}
