import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  TextEditingController _emailOrMobileController = TextEditingController();
  String? verificationCode;
  DateTime dayOf = DateTime.now();
  List overViewData = [
    {
      'name': 'Water',
      'image': ImageConst.glassIcon,
      'name_of_count': '10',
      'name_of_subject': 'Glasses',
      'color': Color(0xffF5E1E9),
    },
    {
      'name': 'Weight',
      'image': ImageConst.weightIcon,
      'name_of_count': '78KG',
      'name_of_subject': 'This Week',
      'color': Color(0xffFAF0DB),
    },
    {
      'name': 'Weight',
      'image': ImageConst.hartIcon,
      'name_of_count': '78',
      'name_of_subject': 'This Week',
      'color': Color(0xffDCEDF9),
    },
    {
      'name': 'BMI',
      'image': ImageConst.bmiIcon,
      'name_of_count': '78',
      'name_of_subject': 'Kg/m2',
      'color': Color.fromRGBO(242, 255, 159, 0.52),
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
            userNameWidget(),
            CommonWidget.commonSizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    dateShowWidet(),
                    CommonWidget.commonSizedBox(height: 30),
                    Row(children: [
                      CommonText.textBoldWight400(
                          text: 'Med Schedule ', fontSize: 18.sp),
                      Spacer(),
                      Image.asset(
                        ImageConst.addIcon,
                        scale: 3,
                      ),
                      CommonWidget.commonSizedBox(width: 6),
                      CommonText.textGradient(
                          text: 'Add A Med', fontSize: 15.sp),
                    ]),
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
                          color: medScheduleList[index]['color'],
                        );
                      },
                    ),
                    CommonWidget.commonSizedBox(height: 20),
                    CommonText.textBoldWight500(
                        text: 'Overview',
                        fontSize: 18.sp,
                        color: CommonColor.blackColor0D0D0D),
                    CommonWidget.commonSizedBox(height: 20),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 16,
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 1.5),
                      itemBuilder: (context, index) {
                        // 'name': 'Weight',
                        // 'image': 'assets/png/glass_icon.png.png',
                        // 'name_of_count': '78KG',
                        // 'name_of_subject': 'This Week',
                        // 'color': Color(0xffFAF0DB),
                        return overViewWidget(
                          name: overViewData[index]['name'],
                          image: overViewData[index]['image'],
                          medGm: overViewData[index]['name_of_count'],
                          type: overViewData[index]['name_of_subject'],
                          color: overViewData[index]['color'],
                        );
                      },
                    ),
                    CommonWidget.commonSizedBox(height: 30),
                    Align(
                      alignment: Alignment.center,
                      child: CommonText.textBoldWight500(
                          text: 'Daily Steps Report',
                          fontSize: 18.sp,
                          color: CommonColor.blackColor0D0D0D),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 320,
                        width: 400,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset('assets/png/report_circle.png',
                                fit: BoxFit.contain),
                            Positioned(
                                top: 70,
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/png/steps_icon.png',
                                      scale: 4,
                                    ),
                                    CommonText.textBoldWight500(
                                        text: '2508',
                                        fontSize: 18.sp,
                                        color: CommonColor.blackColor434343),
                                  ],
                                )),
                            Positioned(
                              top: 180,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    reportEventWidget(
                                        height: 33,
                                        padding: 10,
                                        text: '31 kcal',
                                        image: ImageConst.kcalIcon),
                                    reportEventWidget(
                                        padding: 4,
                                        text: '50 min',
                                        image: ImageConst.timeIcon),
                                    reportEventWidget(
                                        padding: 0,
                                        height: 43,
                                        text: '2 km ',
                                        image: ImageConst.locationIcon),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget reportEventWidget(
      {required String image,
      required String text,
      double height = 40,
      double padding = 4,
      double width = 50}) {
    return Container(
      height: 60,
      // color: Colors.lightGreen,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: height,
            width: width,
            child: Image.asset(
              image,
              // scale: 3.5,
            ),
          ),
          Positioned(
              top: 50,
              child: CommonText.textBoldWight500(
                  text: text,
                  fontSize: 9.sp,
                  color: CommonColor.blackColor616161.withOpacity(0.7)))
        ],
      ),
    );
  }

  Widget medDetailsWidget(
      {required String medName,
      required String medGm,
      required String timeOfDay,
      required Color color,
      required Color iconColor,
      required String image}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
          height: 16.h,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16)),
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

  Container overViewWidget({
    required String name,
    required String medGm,
    required String type,
    required String image,
    required Color color,
  }) {
    return Container(
        height: 16.h,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonWidget.commonSizedBox(width: 12),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CommonText.textBoldWight400(
                      text: name,
                      color: CommonColor.blackColor0D0D0D,
                      fontSize: 14.sp),
                  CommonWidget.commonSizedBox(height: 12),
                  CommonText.textBoldWight700(
                      text: medGm,
                      color: CommonColor.blackColor1D253C,
                      fontSize: 18.sp),
                  CommonText.textBoldWight500(
                      text: type,
                      color: CommonColor.blackColor1D253C.withOpacity(0.5),
                      fontSize: 10.sp),
                ],
              ),
            ),
            CommonWidget.commonSizedBox(width: 12),
            Expanded(
              flex: 2,
              child: Image.asset(
                image,
                scale: 5,
              ),
            )
          ],
        ));
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

  Row userNameWidget() {
    return Row(children: [
      CommonText.textBoldWight400(text: 'Good Morning, ', fontSize: 18.sp),
      CommonText.textBoldWight400(text: 'Alex!', fontSize: 18.sp),
      Spacer(),
      Image.asset(
        ImageConst.notification,
        scale: 4,
      ),
      CommonWidget.commonSizedBox(width: 6),
      Image.asset(
        'assets/png/Face.png',
        scale: 4,
      ),
    ]);
  }
}
