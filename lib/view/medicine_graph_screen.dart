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
  List medScheduleList = [
    {
      'image': ImageConst.capsule1,
      'medName': 'Softgel',
      'medGm': '(100MG)',
      'iconColor': Color(0xff21D200),
      'dose': '3 Dose',
      'color': Color.fromRGBO(69, 196, 44, 0.13)
    },
    {
      'image': ImageConst.capsule2,
      'medName': 'Ativan',
      'medGm': '(50MG)',
      'iconColor': Color(0xff9255E5),
      'dose': '2 Dose',
      'color': Color.fromRGBO(111, 44, 196, 0.13)
    },
    {
      'image': ImageConst.capsule3,
      'medName': 'Invokana',
      'medGm': '(100MG)',
      'iconColor': Color(0xffFFDD2C),
      'dose': '2 Dose',
      'color': Color.fromRGBO(193, 196, 44, 0.13)
    },
    {
      'image': ImageConst.capsule4,
      'medName': 'Xanax',
      'medGm': '(200MG)',
      'iconColor': Color(0xffFFDD2C),
      'dose': '1 Dose',
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
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.commonSizedBox(height: 23),
                    dateShowWidet(),
                    CommonWidget.commonSizedBox(height: 23),
                    graphWidget(),
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
                          dose: medScheduleList[index]['dose'],
                        );
                      },
                    ),
                    CommonWidget.commonSizedBox(height: 100),
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
      required String dose,
      required Color iconColor,
      required String image}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              Container(
                  height: 38.sp,
                  width: 38.sp,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 20.0,
                      ),
                    ],
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: CommonWidget.commonSvgPitcher(
                      image:
                          image) /* Image.asset(
                    image,
                    scale: 5,
                  )*/
                  ),
              CommonWidget.commonSizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CommonText.textBoldWight500(
                                text: medName,
                                color: CommonColor.blackColor353535,
                                fontSize: 15.sp),
                            CommonWidget.commonSizedBox(width: 5),
                            CommonText.textBoldWight400(
                                text: medGm,
                                color: CommonColor.gery8A8A8A,
                                fontSize: 11.sp),
                          ],
                        ),
                        CommonText.textBoldWight500(
                            text: dose,
                            color: CommonColor.blackColor353535,
                            fontSize: 13.sp),
                      ],
                    ),
                    CommonWidget.commonSizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              int.parse(dose.split(' ').first), (index) {
                            return index + 1 < int.parse(dose.split(' ').first)
                                ? Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Image.asset(
                                      ImageConst.doubleTickIcon,
                                      scale: 4.5,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Image.asset(
                                        ImageConst.doubleTickIcon,
                                        scale: 4.5,
                                        color: CommonColor.geryD9D9D9),
                                  );
                          }),
                        ),
                        Row(
                          children: [
                            Image.asset(ImageConst.eyesIcon, scale: 3.5),
                            CommonWidget.commonSizedBox(width: 4),
                            CommonText.textGradient(
                                text: 'View', fontSize: 13.sp),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
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
