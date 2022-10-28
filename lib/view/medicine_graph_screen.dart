import 'package:dotted_line/dotted_line.dart';
import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class MedicineGraphScreen extends StatefulWidget {
  const MedicineGraphScreen({Key? key}) : super(key: key);

  @override
  State<MedicineGraphScreen> createState() => _MedicineGraphScreenState();
}

class _MedicineGraphScreenState extends State<MedicineGraphScreen> {
  TextEditingController _emailOrMobileController = TextEditingController();
  String? verificationCode;
  DateTime dayOf = DateTime.now();
  List overViewData = [
    {
      'name': 'Water',
      'image': ImageConst.glassIcon,
      'name_of_count': '10',
      'name_of_subject': 'Glasses',
    },
    {
      'name': 'Weight',
      'image': ImageConst.weightIcon,
      'name_of_count': '78KG',
      'name_of_subject': 'This Week',
      'color': Color(0xffFAF0DB),
    },
    {
      'name': 'Heart Rate',
      'image': ImageConst.hartIcon,
      'name_of_count': '96',
      'name_of_subject': 'This Week',
    },
    {
      'name': 'BMI',
      'image': ImageConst.bmiIcon,
      'name_of_count': '20.1',
      'name_of_subject': 'Kg/m2',
    },
  ];
  List medScheduleList = [
    {
      'image': ImageConst.med3Icon,
      'medName': 'Disprien',
      'medGm': '300 gm',
      'iconColor': Color(0xff21D200),
      'timeOfDay': 'Take 1 Pills (Daily)',
      'color': Color.fromRGBO(69, 196, 44, 0.13)
    },
    {
      'image': ImageConst.med2Icon,
      'medName': 'Novolin',
      'medGm': '10 gm',
      'iconColor': Color(0xff9255E5),
      'timeOfDay': 'Twice a Day',
      'color': Color.fromRGBO(111, 44, 196, 0.13)
    },
    {
      'image': ImageConst.med1Icon,
      'medName': 'Softgel',
      'medGm': '300 gm',
      'iconColor': Color(0xffFFDD2C),
      'timeOfDay': 'Daily',
      'color': Color.fromRGBO(193, 196, 44, 0.13)
    },
  ];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailOrMobileController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CommonWidget.commonBackGround(
        body: Column(
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
            dateShowWidet(),
            CommonWidget.commonSizedBox(height: 23),
            graphWidget(),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.commonSizedBox(height: 20),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: medScheduleList.length,
                      itemBuilder: (context, index) {
                        return medDetailsWidget(
                          image: medScheduleList[index]['image'],
                          medName: medScheduleList[index]['medName'],
                          medGm: medScheduleList[index]['medGm'],
                          iconColor: medScheduleList[index]['iconColor'],
                          timeOfDay: medScheduleList[index]['timeOfDay'],
                        );
                      },
                    ),
                    CommonWidget.commonSizedBox(height: 20),
                    CommonText.textBoldWight500(
                        text: TextConst.overview,
                        fontSize: 18.sp,
                        color: CommonColor.blackColor0D0D0D),
                    CommonWidget.commonSizedBox(height: 20),
                    CommonWidget.commonSizedBox(height: 30),
                    Align(
                      alignment: Alignment.center,
                      child: CommonText.textBoldWight500(
                          text: TextConst.dailyStepsReport,
                          fontSize: 18.sp,
                          color: CommonColor.blackColor0D0D0D),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget medDetailsWidget(
      {required String medName,
      required String medGm,
      required String timeOfDay,
      required Color iconColor,
      required String image}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
          height: 16.h,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Image.asset(
                    image,
                    scale: 5,
                  )),
              CommonWidget.commonSizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText.textBoldWight500(
                      text: medName,
                      color: CommonColor.blackColor0D0D0D,
                      fontSize: 18.sp),
                  CommonText.textBoldWight400(
                      text: medGm,
                      color: CommonColor.blackColor0D0D0D,
                      fontSize: 14.sp),
                  CommonWidget.commonSizedBox(height: 10),
                  CommonText.textBoldWight400(
                      text: timeOfDay,
                      color: CommonColor.blackColor0D0D0D,
                      fontSize: 12.sp),
                ],
              ),
              Spacer(),
              Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.more_vert, color: CommonColor.geryB4B4B4),
                    Container(
                        height: 18.sp,
                        width: 18.sp,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.check, size: 16,
                          color: iconColor,
                          //size: 18.sp,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: iconColor, width: 1.5),
                            shape: BoxShape.circle,
                            color: Colors.white)),
                  ]),
            ],
          )),
    );
  }

  Row dateShowWidet() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonWidget.commonBackButton(onTap: () {
          dayOf = DateTime.utc(
            dayOf.year,
            dayOf.month,
            dayOf.day - 1,
          );
          setState(() {});
        }),
        CommonWidget.commonSizedBox(width: 26),
        Column(children: [
          CommonText.textGradient(
              text: CommonWidget.convertDateForm(dayOf)!, fontSize: 20.sp),
          CommonText.textBoldWight400(
              color: Colors.black45,
              text: DateFormat('MMMEd').format(dayOf),
              //      text: DateFormat.yMMMMEEEEd().format(dayOf),
              fontSize: 12.sp),
        ]),
        CommonWidget.commonSizedBox(width: 26),
        RotatedBox(
          quarterTurns: 2,
          child: CommonWidget.commonBackButton(onTap: () {
            var difference = DateTime.now().difference(dayOf).inDays;
            if (difference != 0) {
              dayOf = DateTime.utc(
                dayOf.year,
                dayOf.month,
                dayOf.day + 1,
              );
            }
            print(difference);
            setState(() {});
          }),
        ),
      ],
    );
  }

  Widget graphWidget() {
    return Container(
        width: Get.width,
        height: 210,
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(12)),
        //height: 500,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/png/medicine_graph.png',
            fit: BoxFit.contain,
          ),
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
        CommonText.textBoldWight500(
            text: TextConst.medicineReport, fontSize: 18.sp),
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
