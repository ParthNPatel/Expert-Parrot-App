import 'package:dotted_line/dotted_line.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../components/common_widget.dart';
import '../constant/color_const.dart';

class WaterGraphScreen extends StatefulWidget {
  const WaterGraphScreen({Key? key}) : super(key: key);

  @override
  State<WaterGraphScreen> createState() => _WaterGraphScreenState();
}

class _WaterGraphScreenState extends State<WaterGraphScreen> {
  List dayList = ["Sat", 'Fri', 'Thu', 'Wed', 'Tue', 'Mon'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonWidget.commonBackGround(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CommonWidget.commonSizedBox(height: 10),
              header(),
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
              CommonWidget.commonSizedBox(height: 23),
              graphWidget(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: CommonText.textBoldWight500(
                    text: TextConst.quickAddForToady,
                    fontSize: 18.sp,
                    color: CommonColor.blackColor0D0D0D),
              ),
              waterBottleWidget(),
              CommonWidget.commonSizedBox(height: 20),
              Align(
                  alignment: Alignment.centerLeft,
                  child: CommonText.textBoldWight500(
                      text: TextConst.today,
                      fontSize: 15.sp,
                      color: CommonColor.blackColor1D253C)),
              CommonWidget.commonSizedBox(height: 20),
              Row(
                children: [
                  Image.asset(
                    ImageConst.glassOfWater,
                    scale: 4,
                  ),
                  CommonText.textBoldWight600(
                      text: 'O',
                      fontSize: 18.sp,
                      color: CommonColor.blackColor1D253C),
                  CommonText.textBoldWight400(
                      text: ' fl oz of your ',
                      fontSize: 13.sp,
                      color: CommonColor.gery727272),
                  CommonText.textBoldWight500(
                      text: '64 ',
                      fontSize: 16.sp,
                      color: CommonColor.blackColor1D253C),
                  CommonText.textBoldWight400(
                      text: 'fl oz goal',
                      fontSize: 13.sp,
                      color: CommonColor.gery727272),
                ],
              ),
              CommonWidget.commonSizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: dayList.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonWidget.commonSvgPitcher(
                        image: 'assets/svg/Line 5.svg',
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 55.sp,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: CommonText.textBoldWight500(
                                  text: dayList[index],
                                  fontSize: 15.sp,
                                  color: CommonColor.blackColor1D253C),
                            ),
                          ),
                          CommonWidget.commonSizedBox(width: 20),
                          CommonText.textBoldWight500(
                              text: '0 ',
                              fontSize: 15.sp,
                              color: CommonColor.blackColor1D253C),
                          CommonText.textBoldWight500(
                              text: 'fl oz',
                              fontSize: 15.sp,
                              color: CommonColor.gery696969)
                        ],
                      ),
                    ],
                  );
                },
              ),
              CommonWidget.commonSizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Container graphWidget() {
    return Container(
        width: Get.width,
        height: 210,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        //height: 500,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/png/fl_chart.png',
            fit: BoxFit.contain,
          ),
        ));
  }

  Padding waterBottleWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          bottleWidget(
              oz: '(8 fl oz)',
              image: ImageConst.glassOfWater,
              typeOfBottle: '1 Glass'),
          bottleWidget(
              oz: '(8 fl oz)',
              image: ImageConst.plasticBottle,
              typeOfBottle: '1 Glass'),
          bottleWidget(
              oz: '(8 fl oz)',
              image: ImageConst.water1Icon,
              typeOfBottle: '1 Glass'),
        ],
      ),
    );
  }

  Container bottleWidget(
      {required String image,
      required String typeOfBottle,
      required String oz}) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14), color: Colors.white),
        child: Column(
          children: [
            SizedBox(height: 40, child: Image.asset(image)),
            CommonWidget.commonSizedBox(height: 20),
            CommonText.textBoldWight500(
                text: typeOfBottle,
                fontSize: 15.sp,
                color: CommonColor.blackColor1D253C),
            CommonText.textBoldWight400(
                text: oz, fontSize: 12.sp, color: CommonColor.gery727272),
          ],
        ));
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
