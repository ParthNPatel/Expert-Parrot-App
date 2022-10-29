import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../controller/HandleFloatController.dart';

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
      'name': 'Heart Rate',
      'image': ImageConst.hartIcon,
      'name_of_count': '96',
      'name_of_subject': 'This Week',
      'color': Color(0xffDCEDF9),
    },
    {
      'name': 'BMI',
      'image': ImageConst.bmiIcon,
      'name_of_count': '20.1',
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

  int medicineSelected = 0;
  int strengthSelected = 0;
  int daysSelected = 0;
  int appearanceSelected = 0;
  int frequencySelected = 0;
  int timeSelected = 0;

  List<String> medicines = [
    'Duloxetine',
    'Disprin',
    'Duloxetine',
    'Dicyclomine',
    'Desvenla',
  ];

  List strength = [
    '100 mg',
    '200 mg',
    '300 mg',
    '400 mg',
    '500 mg',
  ];

  List days = [
    '10 days',
    '20 days',
    '30 days',
    '40 days',
    '40 days',
  ];

  List appearance = [
    'Pills',
    'Gel',
    'Syrup',
    'Syringe',
  ];

  List frequency = [
    'Everyday',
    'Once a week',
    'Twice a week',
    'Thrice a week',
  ];

  List times = [
    'Once a day',
    'Twice a day',
    'Thrice a day',
  ];

  HandleFloatController controller = Get.find();

  @override
  void initState() {
    controller.isVisible = false;
    super.initState();
  }

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
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    dateShowWidet(),
                    CommonWidget.commonSizedBox(height: 30),
                    Row(children: [
                      CommonText.textBoldWight500(
                          text: TextConst.medSchedule, fontSize: 18.sp),
                      Spacer(),
                      InkWell(
                          onTap: () {
                            Get.dialog(StatefulBuilder(
                              builder: (context, setState) =>
                                  addMedicineDialog(context, setState),
                            )).then((value) {
                              setState(() {});
                            });
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                ImageConst.addIcon,
                                scale: 3,
                              ),
                              CommonWidget.commonSizedBox(width: 6),
                              CommonText.textGradient(
                                  text: TextConst.addAMed, fontSize: 15.sp),
                            ],
                          ))
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
                        text: TextConst.overview,
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
                          onTap: () {
                            if (index == 3) {
                              Get.dialog(
                                bmiDialog(),
                              );
                            }
                          },
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
                          text: TextConst.dailyStepsReport,
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

  Dialog addMedicineDialog(BuildContext context, StateSetter setState) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 400.sp,
        width: 300.sp,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 20, top: 13, right: 20, bottom: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText.textBoldWight500(
                    text: "Add Medicine",
                    fontSize: 17.sp,
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: CommonWidget.commonSvgPitcher(
                      image: ImageConst.close,
                    ),
                  )
                ],
              ),
            ),
            CommonWidget.dottedLineWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          CommonText.textBoldWight500(
                              text: "Med Info",
                              fontSize: 13.sp,
                              color: Colors.black),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            //height: 40.sp,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffF8F8F6),
                            ),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                  iconColor: CommonColor.greenColor,
                                  title: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/pills.svg',
                                        height: 15.sp,
                                        width: 15.sp,
                                        color: Color(0xff9B9B9B),
                                      ),
                                      SizedBox(
                                        width: 18,
                                      ),
                                      CommonText.textBoldWight500(
                                          text:
                                              "${medicines[medicineSelected]}",
                                          fontSize: 13.sp,
                                          color: Colors.black),
                                    ],
                                  ),
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      child: Column(
                                        children: List.generate(
                                            medicines.length,
                                            (index) => GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      medicineSelected = index;
                                                    });
                                                  },
                                                  child: Container(
                                                    color: medicineSelected ==
                                                            index
                                                        ? Color(0xffe1f9ea)
                                                        : Colors.white,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: 18,
                                                          width: 18,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: medicineSelected ==
                                                                        index
                                                                    ? Colors
                                                                        .transparent
                                                                    : Color(
                                                                        0xffd8d8d8)),
                                                            color: medicineSelected ==
                                                                    index
                                                                ? CommonColor
                                                                    .greenColor
                                                                : Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                          ),
                                                          child: Center(
                                                              child: Icon(
                                                            Icons.check,
                                                            size: 10,
                                                            color: Colors.white,
                                                          )),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        CommonText
                                                            .textBoldWight500(
                                                                text: medicines[
                                                                    index])
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CommonText.textBoldWight500(
                              text: "Strength",
                              fontSize: 13.sp,
                              color: Colors.black),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  //height: 40.sp,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(0xffF8F8F6),
                                  ),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent),
                                    child: ExpansionTile(
                                      collapsedIconColor: Colors.transparent,
                                      iconColor: Colors.transparent,
                                      title: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/svg/network.svg',
                                            height: 15.sp,
                                            width: 15.sp,
                                            color: Color(0xff9B9B9B),
                                          ),
                                          SizedBox(
                                            width: 18,
                                          ),
                                          CommonText.textBoldWight500(
                                              text:
                                                  "${strength[strengthSelected]}",
                                              fontSize: 13.sp,
                                              color: Colors.black),
                                        ],
                                      ),
                                      children: [
                                        Container(
                                          color: Colors.white,
                                          child: Column(
                                            children: List.generate(
                                                strength.length,
                                                (index) => GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          strengthSelected =
                                                              index;
                                                        });
                                                      },
                                                      child: Container(
                                                        color:
                                                            strengthSelected ==
                                                                    index
                                                                ? Color(
                                                                    0xffe1f9ea)
                                                                : Colors.white,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 10),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              height: 18,
                                                              width: 18,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: strengthSelected ==
                                                                            index
                                                                        ? Colors
                                                                            .transparent
                                                                        : Color(
                                                                            0xffd8d8d8)),
                                                                color: strengthSelected ==
                                                                        index
                                                                    ? CommonColor
                                                                        .greenColor
                                                                    : Colors
                                                                        .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3),
                                                              ),
                                                              child: Center(
                                                                  child: Icon(
                                                                Icons.check,
                                                                size: 10,
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            CommonText
                                                                .textBoldWight500(
                                                                    text: strength[
                                                                        index])
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  //height: 40.sp,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(0xffF8F8F6),
                                  ),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent),
                                    child: ExpansionTile(
                                      collapsedIconColor: Colors.transparent,
                                      iconColor: Colors.transparent,
                                      title: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/svg/calender.svg',
                                            height: 15.sp,
                                            width: 15.sp,
                                            color: Color(0xff9B9B9B),
                                          ),
                                          SizedBox(
                                            width: 18,
                                          ),
                                          CommonText.textBoldWight500(
                                              text: "${days[daysSelected]}",
                                              fontSize: 13.sp,
                                              color: Colors.black),
                                        ],
                                      ),
                                      children: [
                                        Container(
                                          color: Colors.white,
                                          child: Column(
                                            children: List.generate(
                                                days.length,
                                                (index) => GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          daysSelected = index;
                                                        });
                                                      },
                                                      child: Container(
                                                        color: daysSelected ==
                                                                index
                                                            ? Color(0xffe1f9ea)
                                                            : Colors.white,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 10),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              height: 18,
                                                              width: 18,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: daysSelected ==
                                                                            index
                                                                        ? Colors
                                                                            .transparent
                                                                        : Color(
                                                                            0xffd8d8d8)),
                                                                color: daysSelected ==
                                                                        index
                                                                    ? CommonColor
                                                                        .greenColor
                                                                    : Colors
                                                                        .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3),
                                                              ),
                                                              child: Center(
                                                                  child: Icon(
                                                                Icons.check,
                                                                size: 10,
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            CommonText
                                                                .textBoldWight500(
                                                                    text: days[
                                                                        index])
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CommonText.textBoldWight500(
                              text: "Appearance",
                              fontSize: 13.sp,
                              color: Colors.black),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            //height: 40.sp,
                            width: 130.sp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffF8F8F6),
                            ),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                collapsedIconColor: Colors.transparent,
                                iconColor: Colors.transparent,
                                title: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/pills.svg',
                                      height: 15.sp,
                                      width: 15.sp,
                                      color: Color(0xff9B9B9B),
                                    ),
                                    SizedBox(
                                      width: 18,
                                    ),
                                    CommonText.textBoldWight500(
                                        text:
                                            "${appearance[appearanceSelected]}",
                                        fontSize: 13.sp,
                                        color: Colors.black),
                                  ],
                                ),
                                children: [
                                  Container(
                                    color: Colors.white,
                                    child: Column(
                                      children: List.generate(
                                        appearance.length,
                                        (index) => GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              appearanceSelected = index;
                                            });
                                          },
                                          child: Container(
                                            color: appearanceSelected == index
                                                ? Color(0xffe1f9ea)
                                                : Colors.white,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 18,
                                                  width: 18,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            appearanceSelected ==
                                                                    index
                                                                ? Colors
                                                                    .transparent
                                                                : Color(
                                                                    0xffd8d8d8)),
                                                    color: appearanceSelected ==
                                                            index
                                                        ? CommonColor.greenColor
                                                        : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                  ),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.check,
                                                    size: 10,
                                                    color: Colors.white,
                                                  )),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                CommonText.textBoldWight500(
                                                    text: appearance[index])
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          CommonWidget.commonButton(
                              color: CommonColor.greenColor,
                              radius: 10,
                              onTap: () {
                                Get.back();
                                Get.dialog(StatefulBuilder(
                                  builder: (context, setState) => Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Container(
                                      height: 400.sp,
                                      width: 300.sp,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 20,
                                                top: 13,
                                                right: 20,
                                                bottom: 13),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CommonText.textBoldWight500(
                                                  text: "Schedule",
                                                  fontSize: 17.sp,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: CommonWidget
                                                      .commonSvgPitcher(
                                                    image: ImageConst.close,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          CommonWidget.dottedLineWidget(),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        CommonText
                                                            .textBoldWight500(
                                                                text:
                                                                    "Frequency",
                                                                fontSize: 13.sp,
                                                                color: Colors
                                                                    .black),
                                                        SizedBox(
                                                          height: 12,
                                                        ),
                                                        Container(
                                                          //height: 40.sp,
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            color: Color(
                                                                0xffF8F8F6),
                                                          ),
                                                          child: Theme(
                                                            data: Theme.of(
                                                                    context)
                                                                .copyWith(
                                                                    dividerColor:
                                                                        Colors
                                                                            .transparent),
                                                            child:
                                                                ExpansionTile(
                                                                    iconColor:
                                                                        CommonColor
                                                                            .greenColor,
                                                                    title: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              18,
                                                                        ),
                                                                        CommonText.textBoldWight500(
                                                                            text:
                                                                                "${frequency[frequencySelected]}",
                                                                            fontSize:
                                                                                13.sp,
                                                                            color: Colors.black),
                                                                      ],
                                                                    ),
                                                                    children: [
                                                                  Container(
                                                                    color: Colors
                                                                        .white,
                                                                    child:
                                                                        Column(
                                                                      children: List.generate(
                                                                          frequency.length,
                                                                          (index) => GestureDetector(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    frequencySelected = index;
                                                                                  });
                                                                                },
                                                                                child: Container(
                                                                                  color: frequencySelected == index ? Color(0xffe1f9ea) : Colors.white,
                                                                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Container(
                                                                                        height: 18,
                                                                                        width: 18,
                                                                                        decoration: BoxDecoration(
                                                                                          border: Border.all(color: frequencySelected == index ? Colors.transparent : Color(0xffd8d8d8)),
                                                                                          color: frequencySelected == index ? CommonColor.greenColor : Colors.white,
                                                                                          borderRadius: BorderRadius.circular(3),
                                                                                        ),
                                                                                        child: Center(
                                                                                            child: Icon(
                                                                                          Icons.check,
                                                                                          size: 10,
                                                                                          color: Colors.white,
                                                                                        )),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 10,
                                                                                      ),
                                                                                      CommonText.textBoldWight500(text: frequency[index])
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              )),
                                                                    ),
                                                                  )
                                                                ]),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        CommonText.textBoldWight500(
                                                            text:
                                                                "How Many Times A Day?",
                                                            fontSize: 13.sp,
                                                            color:
                                                                Colors.black),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          //height: 40.sp,
                                                          width: 140.sp,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            color: Color(
                                                                0xffF8F8F6),
                                                          ),
                                                          child: Theme(
                                                            data: Theme.of(
                                                                    context)
                                                                .copyWith(
                                                                    dividerColor:
                                                                        Colors
                                                                            .transparent),
                                                            child:
                                                                ExpansionTile(
                                                              collapsedIconColor:
                                                                  Colors
                                                                      .transparent,
                                                              iconColor: Colors
                                                                  .transparent,
                                                              title: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width: 18,
                                                                  ),
                                                                  CommonText.textBoldWight500(
                                                                      text:
                                                                          "${times[timeSelected]}",
                                                                      fontSize:
                                                                          13.sp,
                                                                      color: Colors
                                                                          .black),
                                                                ],
                                                              ),
                                                              children: [
                                                                Container(
                                                                  color: Colors
                                                                      .white,
                                                                  child: Column(
                                                                    children: List.generate(
                                                                        times.length,
                                                                        (index) => GestureDetector(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  timeSelected = index;
                                                                                });
                                                                              },
                                                                              child: Container(
                                                                                color: timeSelected == index ? Color(0xffe1f9ea) : Colors.white,
                                                                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Container(
                                                                                      height: 18,
                                                                                      width: 18,
                                                                                      decoration: BoxDecoration(
                                                                                        border: Border.all(color: timeSelected == index ? Colors.transparent : Color(0xffd8d8d8)),
                                                                                        color: timeSelected == index ? CommonColor.greenColor : Colors.white,
                                                                                        borderRadius: BorderRadius.circular(3),
                                                                                      ),
                                                                                      child: Center(
                                                                                          child: Icon(
                                                                                        Icons.check,
                                                                                        size: 10,
                                                                                        color: Colors.white,
                                                                                      )),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    CommonText.textBoldWight500(text: times[index])
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            )),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        CommonText.textBoldWight500(
                                                            text:
                                                                "Set Date & Time",
                                                            fontSize: 13.sp,
                                                            color:
                                                                Colors.black),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 40.sp,
                                                              width: 170.sp,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                color: Color(
                                                                    0xffF8F8F6),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width: 18,
                                                                  ),
                                                                  SvgPicture
                                                                      .asset(
                                                                    'assets/svg/notification2.svg',
                                                                    height:
                                                                        15.sp,
                                                                    width:
                                                                        15.sp,
                                                                    color: Color(
                                                                        0xff9B9B9B),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 18,
                                                                  ),
                                                                  CommonText.textBoldWight500(
                                                                      text:
                                                                          "10:00 AM",
                                                                      fontSize:
                                                                          13.sp,
                                                                      color: Colors
                                                                          .black),
                                                                ],
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            Container(
                                                              height: 40.sp,
                                                              width: 40.sp,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xffeffcf4),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                              ),
                                                              child: Center(
                                                                child: Icon(
                                                                  Icons.add,
                                                                  size: 15,
                                                                  color: CommonColor
                                                                      .greenColor,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(height: 20),
                                                        CommonWidget
                                                            .commonButton(
                                                                color: CommonColor
                                                                    .greenColor,
                                                                radius: 10,
                                                                onTap: () {
                                                                  Get.back();
                                                                  CommonWidget.getSnackBar(
                                                                      title:
                                                                          "Added!",
                                                                      message:
                                                                          'Your medicine has been added successfully.',
                                                                      color: CommonColor
                                                                          .greenColor,
                                                                      colorText:
                                                                          Colors
                                                                              .white);
                                                                },
                                                                text: "Add")
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )).then((value) {
                                  setState(
                                    () {},
                                  );
                                });
                              },
                              text: "Next")
                        ],
                      ),
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

  Dialog bmiDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 300.sp,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText.textBoldWight500(
                    text: "Calculating BMI",
                    fontSize: 17.sp,
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: CommonWidget.commonSvgPitcher(
                      image: ImageConst.close,
                    ),
                  )
                ],
              ),
            ),
            CommonWidget.dottedLineWidget(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  CommonText.textBoldWight500(
                      text: "Formula:", fontSize: 13.sp, color: Colors.black),
                  SizedBox(
                    height: 12,
                  ),
                  CommonText.textBoldWight400(
                      text: "weight (kg) / [height (m)]2",
                      fontSize: 11.sp,
                      color: Colors.black),
                  SizedBox(
                    height: 5,
                  ),
                  CommonText.textBoldWight400(
                      text: "or", fontSize: 11.sp, color: Color(0xff979797)),
                  SizedBox(
                    height: 5,
                  ),
                  CommonText.textBoldWight400(
                      text:
                          "[weight (kg) / height (cm) / height (cm)] x 10,000",
                      fontSize: 11.sp,
                      color: Colors.black),
                  SizedBox(
                    height: 13,
                  ),
                  CommonText.textBoldWight500(
                      text: "Strength", fontSize: 13.sp, color: Colors.black),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
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
                      SizedBox(
                        width: 15,
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
                      Spacer(),
                      Container(
                        height: 23.sp,
                        width: 55.sp,
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
                    height: 13,
                  ),
                  CommonText.textBoldWight500(
                      text: "Result", fontSize: 13.sp, color: Colors.black),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      CommonText.textBoldWight500(
                        text: '20.1',
                        color: CommonColor.greenColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CommonText.textBoldWight500(
                        text: 'BMI',
                        fontSize: 10.sp,
                        color: Color(0xff444444),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        ImageConst.bmiIcon,
                        scale: 5,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CommonWidget.commonButton(
                      color: CommonColor.greenColor,
                      radius: 10,
                      onTap: () {
                        Get.back();
                      },
                      text: "Next")
                ],
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
              top: 45,
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
          // height: 16.h,

          padding: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 8),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText.textBoldWight500(
                              text: medName,
                              color: CommonColor.blackColor0D0D0D,
                              fontSize: 18.sp),
                          Icon(Icons.more_vert, color: CommonColor.geryB4B4B4),
                        ]),
                    CommonText.textBoldWight400(
                        text: medGm,
                        color: CommonColor.blackColor0D0D0D,
                        fontSize: 14.sp),
                    CommonWidget.commonSizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText.textBoldWight400(
                              text: timeOfDay,
                              color: CommonColor.blackColor0D0D0D,
                              fontSize: 12.sp),
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
                                  border:
                                      Border.all(color: iconColor, width: 1.5),
                                  shape: BoxShape.circle,
                                  color: Colors.white)),
                        ]),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget overViewWidget({
    required String name,
    required String medGm,
    required String type,
    required String image,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 16.h,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText.textBoldWight400(
                  text: name,
                  color: CommonColor.blackColor0D0D0D,
                  fontSize: 14.sp),
              CommonWidget.commonSizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText.textBoldWight700(
                              text: medGm,
                              color: CommonColor.blackColor1D253C,
                              fontSize: 18.sp),
                          CommonText.textBoldWight500(
                              text: type,
                              color:
                                  CommonColor.blackColor1D253C.withOpacity(0.5),
                              fontSize: 10.sp),
                        ]),
                  ),
                  Expanded(
                    child: Image.asset(
                      image,
                      scale: 5,
                    ),
                  ),
                ],
              )
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

  Row userNameWidget() {
    return Row(children: [
      CommonText.textBoldWight400(text: 'Good Morning, ', fontSize: 16.sp),
      CommonText.textBoldWight500(text: 'Alex!', fontSize: 18.sp),
      Spacer(),
      Image.asset(
        ImageConst.notification,
        scale: 4,
      ),
      CommonWidget.commonSizedBox(width: 6),
      Image.asset(
        'assets/png/face.png',
        scale: 4,
      ),
    ]);
  }
}
