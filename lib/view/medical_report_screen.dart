import 'package:dotted_line/dotted_line.dart';
import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/responseModel/get_record_medicine_res_model.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:expert_parrot_app/viewModel/get_record_medicine_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../Models/responseModel/get_week_record_medicine_response_model.dart';
import '../components/common_widget.dart';
import '../viewModel/get_week_record_medicine_view_model.dart';

class MedicalReportScreen extends StatefulWidget {
  final String userName;
  final String userImg;
  final String userRelation;
  final String userDepndentId;

  MedicalReportScreen(
      {Key? key,
      required this.userName,
      required this.userImg,
      required this.userDepndentId,
      required this.userRelation})
      : super(key: key);

  @override
  State<MedicalReportScreen> createState() => _MedicalReportScreenState();
}

class _MedicalReportScreenState extends State<MedicalReportScreen> {
  int index = 0;

  bool isDaily = true;

  List medScheduleList = [
    {
      'image': ImageConst.capsule4,
      'medName': 'Xanax',
      'medGm': '(200MG)',
      'iconColor': Color(0xffFFDD2C),
      'dose': [2],
      'color': Color.fromRGBO(193, 196, 44, 0.13)
    },
    {
      'image': ImageConst.capsule3,
      'medName': 'Invokana',
      'medGm': '(100MG)',
      'iconColor': Color(0xffFFDD2C),
      'dose': [2],
      'color': Color.fromRGBO(193, 196, 44, 0.13)
    },
    {
      'image': ImageConst.capsule4,
      'medName': 'Xanax',
      'medGm': '(200MG)',
      'iconColor': Color(0xffFFDD2C),
      'dose': [2],
      'color': Color.fromRGBO(193, 196, 44, 0.13)
    },
    {
      'image': ImageConst.capsule2,
      'medName': 'Ativan',
      'medGm': '(50MG)',
      'iconColor': Color(0xff9255E5),
      'dose': [2],
      'color': Color.fromRGBO(111, 44, 196, 0.13)
    },
    {
      'image': ImageConst.capsule1,
      'medName': 'Softgel',
      'medGm': '(100MG)',
      'iconColor': Color(0xff21D200),
      'dose': [2],
      'color': Color.fromRGBO(69, 196, 44, 0.13)
    },
    null,
  ];
  DateTime dayOf = DateTime.now();

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

  int limitData = 0;

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
  List<String> listOfWeak = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  List<List> listOfPiles = [
    [0],
    [0, 1],
    [0],
    [0, 1],
    [0, 1, 1],
    [0, 0],
    [0]
  ];
  int selectedPilesDose = 0;
  int selectedPillIndex = 0;

  String tmpID = "";
  int weekTotal = 0;
  int weekTaken = 0;
  int weekSnoozed = 4;
  int weekMissed = 0;
  bool isFirst = true;
  String weekMedName = "";
  String weekGm = "";

  GetRecordMedicineViewModel getRecordMedicineViewModel =
      Get.put(GetRecordMedicineViewModel());

  GetWeekRecordMedicineViewModel getWeekRecordMedicineViewModel =
      Get.put(GetWeekRecordMedicineViewModel());

  DateTime startDate = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day - 6);

  DateTime endDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    getWeekRecordMedicineViewModel.getWeekRecordMedicineViewModel(body: {
      "startDate": "${startDate.toString().split(" ").first}",
      "endDate": "${endDate.toString().split(" ").first}"
    }, isForDependent: true, dependentId: widget.userDepndentId);

    getRecordMedicineViewModel.getRecordMedicineViewModel(
        dependentId: "&dependentId=" + widget.userDepndentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonWidget.commonBackGround(
        body: Column(
          children: [
            header(),
            CommonWidget.commonSizedBox(height: 6),
            CommonWidget.dottedLineWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  CommonWidget.commonSizedBox(height: 23),
                  userProfileWidget(),
                  GetBuilder<GetRecordMedicineViewModel>(
                      builder: (controllerRM) {
                    if (controllerRM.getRecordMedicineApiResponse.status ==
                        Status.LOADING) {
                      return SizedBox();
                    }
                    if (controllerRM.getRecordMedicineApiResponse.status ==
                        Status.COMPLETE) {
                      GetRecordMedicineResponseModel respRM =
                          controllerRM.getRecordMedicineApiResponse.data;

                      if (tmpID == "") {
                        tmpID = respRM.data![0].records![0].sId!;
                      }

                      limitData = 0;
                      for (int i = 0; i < respRM.data!.length; i++) {
                        for (int j = 0;
                            j < respRM.data![i].records!.length;
                            j++) {
                          if (respRM.data![i].records![j].sId == tmpID) {
                            limitData += 1;
                          }
                        }
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonWidget.commonSizedBox(height: 23),
                          !isDaily
                              ? GetBuilder<GetWeekRecordMedicineViewModel>(
                                  builder: (controllerWeek) {
                                  if (controllerWeek
                                          .getWeekRecordMedicineApiResponse
                                          .status ==
                                      Status.LOADING) {
                                    return Column(
                                      children: [
                                        weekShowWidget(),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 30.sp),
                                          child: CircularProgressIndicator(
                                              strokeWidth: 1.5,
                                              color: CommonColor.greenColor),
                                        )
                                      ],
                                    );
                                  }

                                  if (controllerWeek
                                          .getWeekRecordMedicineApiResponse
                                          .status ==
                                      Status.COMPLETE) {
                                    GetWeekRecordMedicineResponseModel respWK =
                                        controllerWeek
                                            .getWeekRecordMedicineApiResponse
                                            .data;

                                    if (respWK.data.isNotEmpty &&
                                        respWK.data != []) {
                                      if (isFirst) {
                                        for (int i = 0;
                                            i < respWK.data.length;
                                            i++) {
                                          for (int j = 0;
                                              j < respWK.data[i].records.length;
                                              j++) {
                                            if (respWK.data[i].records[j].id ==
                                                tmpID) {
                                              weekTotal += respWK.data[i]
                                                  .records[j].totalTimes;
                                              weekTaken += respWK.data[i]
                                                  .records[j].doses.length;
                                            }
                                          }
                                        }
                                        isFirst = false;
                                        weekMissed = weekTotal - weekTaken;
                                        weekMedName =
                                            respWK.data[0].records[0].name;
                                        weekGm = respWK
                                            .data[0].records[0].strength
                                            .toString();
                                      }

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          weekShowWidget(),
                                          CommonWidget.commonSizedBox(
                                              height: 23),
                                          weekGraph(),
                                        ],
                                      );
                                    } else
                                      return Column(
                                        children: [
                                          weekShowWidget(),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 30.sp),
                                            child: CommonText.textBoldWight500(
                                                text: "No data in this week"),
                                          )
                                        ],
                                      );
                                  } else
                                    return Column(children: [
                                      weekShowWidget(),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 30.sp),
                                          child: CommonText.textBoldWight500(
                                              text: "Something went wrong"))
                                    ]);
                                })
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    dateShowWidget(),
                                    CommonWidget.commonSizedBox(height: 23),
                                    dailyGraph(respRM),
                                  ],
                                ),
                          buildDottedLine(),
                          CommonWidget.commonSizedBox(height: 10),
                          Align(
                              alignment: Alignment.center,
                              child: CommonText.textBoldWight500(
                                  text: 'Pill List',
                                  fontSize: 18.sp,
                                  color: CommonColor.blackColor0D0D0D)),
                          CommonWidget.commonSizedBox(height: 4),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            reverse: true,
                            itemCount:
                                respRM.data![selectedPilesDose].records!.length,
                            itemBuilder: (context, index) {
                              return medScheduleList[index] == null
                                  ? SizedBox()
                                  : medDetailsWidget(
                                      medId: respRM.data![selectedPilesDose]
                                          .records![index].sId!,
                                      totalTimes: respRM
                                          .data![selectedPilesDose]
                                          .records![index]
                                          .totalTimes!,
                                      pilesList: listOfPiles[index],
                                      image: respRM.data![selectedPilesDose]
                                                  .records![index].appearance!
                                                  .toLowerCase() ==
                                              'Tablet'
                                          ? ImageConst.med3Icon
                                          : respRM
                                                      .data![selectedPilesDose]
                                                      .records![index]
                                                      .appearance!
                                                      .toLowerCase() ==
                                                  'Cream'
                                              ? ImageConst.med1Icon
                                              : respRM.data![selectedPilesDose].records![index].appearance!.toLowerCase() ==
                                                      'Syrup'
                                                  ? ImageConst.med2Icon
                                                  : ImageConst.med2Icon,
                                      medName: respRM.data![selectedPilesDose]
                                          .records![index].name!,
                                      medGm:
                                          '${respRM.data![selectedPilesDose].records![index].strength} gm',
                                      iconColor: respRM.data![selectedPilesDose]
                                                  .records![index].appearance!
                                                  .toLowerCase() ==
                                              'Tablet'
                                          ? Color(0xff21D200)
                                          : respRM
                                                      .data![selectedPilesDose]
                                                      .records![index]
                                                      .appearance!
                                                      .toLowerCase() ==
                                                  'Cream'
                                              ? Color(0xffFFDD2C)
                                              : respRM.data![selectedPilesDose].records![index].appearance!.toLowerCase() == 'Syrup'
                                                  ? Color(0xff9255E5)
                                                  : Color(0xff9255E5),
                                      dose: respRM.data![selectedPilesDose].records![index].doses!,
                                      index: index);
                            },
                          ),
                          CommonWidget.commonSizedBox(height: 100),
                        ],
                      );
                    } else
                      return SizedBox();
                  }),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  DottedLine buildDottedLine() {
    return DottedLine(
      lineLength: double.infinity,
      lineThickness: 1.0,
      dashLength: 10.0,
      dashColor: Color(0xffbac2ba),
      dashRadius: 0.0,
      dashGapLength: 6.0,
      dashGapColor: Colors.transparent,
      dashGapRadius: 0.0,
    );
  }

  Column dailyGraph(GetRecordMedicineResponseModel respRM) {
    return Column(
      children: [
        Container(
          height: 120.sp,
          alignment: Alignment.center,
          // color: Colors.grey.shade300,
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: limitData,
              shrinkWrap: true,
              reverse: true,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        //  height: 150,
                        // color: Colors.red,
                        width: 28,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: respRM.data![index].date ==
                                  dayOf.toString().split(" ").first
                              ? respRM.data![index].records![selectedPillIndex]
                                  .totalTimes
                              : 3,
                          itemBuilder: (context, indexOfDose) {
                            return Column(
                              children: [
                                pilesContainer(
                                    completedDoses: respRM.data![index]
                                        .records![selectedPillIndex].doses!,
                                    selectMainDose: index,
                                    selectedList: selectedPilesDose,
                                    index: indexOfDose,
                                    totalDoseLength: listOfPiles[index].length),
                                Divider(
                                  color: Colors.transparent,
                                  height: 1,
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      //  Spacer(),
                      Container(
                          // height: 40,
                          // width: 22,
                          child: CommonText.textBoldWight600(
                              color: CommonColor.gery9D9D9D,
                              fontSize: 10,
                              text:
                                  weekDayGen(date: respRM.data![index].date!))),
                    ],
                  ),
                );
              }),
        ),
        CommonWidget.commonSizedBox(height: 10),
        Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 30.sp,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: respRM.data![selectedPilesDose]
                    .records![selectedPillIndex].totalTimes!,
                separatorBuilder: (context, index) {
                  return SizedBox(width: 20.sp);
                },
                itemBuilder: (context, index) {
                  return respRM.data![selectedPilesDose]
                          .records![selectedPillIndex].doses!
                          .contains(index + 1)
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(
                                ImageConst.doubleTickIcon,
                                scale: 4,
                              ),
                            ),
                            CommonText.textBoldWight400(
                                text:
                                    "${respRM.data![selectedPilesDose].records![selectedPillIndex].shceduleTime![index]}",
                                fontSize: 12.sp)
                          ],
                        )
                      : Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(
                                ImageConst.doubleTickIcon,
                                scale: 4,
                                color: Color(0xffFB0A0A).withOpacity(.8),
                              ),
                            ),
                            CommonText.textBoldWight400(
                                text:
                                    "${respRM.data![selectedPilesDose].records![selectedPillIndex].shceduleTime![index]}",
                                fontSize: 12.sp)
                          ],
                        );
                },
              ),
            )),
        CommonWidget.commonSizedBox(height: 10),
      ],
    );
  }

  String weekDayGen({required String date}) {
    int weekDay = DateTime.parse(date).weekday;

    switch (weekDay) {
      case 1:
        {
          date = "Mon";
        }
        break;

      case 2:
        {
          date = "Tue";
        }
        break;
      case 3:
        {
          date = "Wed";
        }
        break;
      case 4:
        {
          date = "Thu";
        }
        break;
      case 5:
        {
          date = "Fri";
        }
        break;
      case 6:
        {
          date = "Sat";
        }
        break;
      case 7:
        {
          date = "Sun";
        }
        break;

      default:
        {}
        break;
    }

    return date;
  }

  Column weekGraph() {
    return Column(
      children: [
        CommonText.textBoldWight500(text: "Taken Percentage", fontSize: 15.sp),
        CommonText.textBoldWight500(
            text: "$weekMedName ($weekGm)",
            fontSize: 13,
            color: CommonColor.lightGreenColor),
        SizedBox(
          height: 28.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(PieChartData(
                  centerSpaceRadius: 40,
                  sectionsSpace: 0,
                  borderData: FlBorderData(show: true),
                  startDegreeOffset: -90,
                  sections: [
                    PieChartSectionData(
                        value: weekTaken.toDouble(),
                        showTitle: false,
                        color: CommonColor.lightGreenColor,
                        radius: 35),
                    PieChartSectionData(
                        value: weekMissed.toDouble(),
                        showTitle: false,
                        color: CommonColor.lightRedColor,
                        radius: 25)
                  ])),
              CommonText.textBoldWight500(
                  text: "${((weekTaken / weekTotal) * 100).toPrecision(2)} %",
                  fontSize: 14.sp)
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  height: 15,
                  width: 30,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      color: CommonColor.lightGreenColor,
                      borderRadius: BorderRadius.circular(20)),
                ),
                CommonText.textBoldWight500(
                    text: '$weekTaken Taken',
                    fontSize: 10.sp,
                    color: CommonColor.blackColor0D0D0D)
              ],
            ),
            SizedBox(
              width: 20.sp,
            ),
            Row(
              children: [
                Container(
                  height: 15,
                  width: 30,
                  margin: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      color: CommonColor.lightRedColor,
                      borderRadius: BorderRadius.circular(20)),
                ),
                CommonText.textBoldWight500(
                    text: '$weekMissed Missed',
                    fontSize: 10.sp,
                    color: CommonColor.blackColor0D0D0D)
              ],
            ),
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 15.sp),
            alignment: Alignment.center,
            height: 30.sp,
            width: 120.sp,
            decoration: BoxDecoration(
                color: Color(0xff27AE60),
                borderRadius: BorderRadius.circular(100)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                "assets/png/share_arrow.png",
                scale: 4,
              ),
              SizedBox(width: 5),
              InkWell(
                onTap: () {
                  Share.share("Test");
                },
                child: CommonText.textBoldWight500(
                    text: 'Export/Share',
                    fontSize: 10.sp,
                    color: CommonColor.whiteColorEDEDED),
              )
            ]),
          ),
        )
      ],
    );
  }

  Widget pilesContainer(
      {required int index,
      required List completedDoses,
      required int totalDoseLength,
      required int selectMainDose,
      required int selectedList}) {
    return Container(
        height: 28,
        decoration: BoxDecoration(
          gradient: selectedList == selectMainDose
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: completedDoses.contains(index + 1)
                      ? [
                          Color(0xff32B854),
                          Color(0xff1DAD84),
                        ]
                      : [
                          // 45C42C
                          // 06A0BF
                          Color(0xffFF5F5F),
                          Color(0xffFB0A0A),
                        ])
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                      // 45C42C
                      // 06A0BF
                      CommonColor.geryE2E2E2,
                      CommonColor.geryE2E2E2,
                    ]),
          borderRadius: index == 0
              ? BorderRadius.only(
                  topLeft: Radius.circular(4), topRight: Radius.circular(4))
              : (index == 1 && totalDoseLength == 3)
                  ? BorderRadius.zero
                  : BorderRadius.only(
                      bottomRight: Radius.circular(4),
                      bottomLeft: Radius.circular(4)),
        ));
  }

  Widget medDetailsWidget(
      {required String medName,
      required String medId,
      required List pilesList,
      required String medGm,
      required List dose,
      required Color iconColor,
      required int totalTimes,
      required String image,
      required int index}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () {
          selectedPillIndex = index;

          setState(() {});
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: selectedPillIndex == index
                    ? [Color(0xff32B854), Color(0xff1DAD84)]
                    : [Color(0xfffffff), Color(0xfffffff)]),
          ),
          child: Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.all(1),
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
                      child: SvgPicture.asset(image)),
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
                                text: "${totalTimes} Dose",
                                color: CommonColor.blackColor353535,
                                fontSize: 13.sp),
                          ],
                        ),
                        CommonWidget.commonSizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children:
                            //       List.generate(pilesList.length, (indexPiles) {
                            //     log(
                            //         'pilesList[indexPiles]  ${pilesList[indexPiles]}');
                            //     return InkWell(
                            //       onTap: () {
                            //         if (pilesList[indexPiles] == 0) {
                            //           if (listOfPiles[index].length == 3) {
                            //             listOfPiles[index] = [1, 1, 1];
                            //           } else if (listOfPiles[index].length ==
                            //               2) {
                            //             listOfPiles[index] = [1, 1];
                            //           } else {
                            //             listOfPiles[index] = [1];
                            //           }
                            //         }
                            //         setState(() {});
                            //       },
                            //       child: Column(
                            //         children: [
                            //           pilesList[indexPiles] == 1
                            //               ? Padding(
                            //                   padding:
                            //                       const EdgeInsets.all(4.0),
                            //                   child: Image.asset(
                            //                     ImageConst.doubleTickIcon,
                            //                     scale: 4.5,
                            //                   ),
                            //                 )
                            //               : Padding(
                            //                   padding:
                            //                       const EdgeInsets.all(4.0),
                            //                   child: Image.asset(
                            //                       ImageConst.doubleTickIcon,
                            //                       scale: 4.5,
                            //                       color:
                            //                           CommonColor.geryD9D9D9),
                            //                 )
                            //         ],
                            //       ),
                            //     );
                            //   }),
                            // ),
                            SizedBox(
                              height: 30,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: totalTimes,
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 5.sp,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  return dose.contains(index + 1)
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
                                },
                              ),
                            ),
                            // Container(
                            //   height: 30,
                            //   //width: 100,
                            //   child: ListView.builder(
                            //     shrinkWrap: true,
                            //     reverse: true,
                            //     itemCount: pilesList.length,
                            //     scrollDirection: Axis.horizontal,
                            //     itemBuilder: (context, indexPiles) {
                            //       return InkWell(
                            //         onTap: () {
                            //           if (pilesList[indexPiles] == 0) {
                            //             if (listOfPiles[index].length == 3) {
                            //               listOfPiles[index] = [1, 1, 1];
                            //             } else if (listOfPiles[index].length ==
                            //                 2) {
                            //               listOfPiles[index] = [1, 1];
                            //             } else {
                            //               listOfPiles[index] = [1];
                            //             }
                            //           }
                            //           setState(() {});
                            //         },
                            //         child: Column(
                            //           children: [
                            //             pilesList[indexPiles] == 1
                            //                 ? Padding(
                            //                     padding:
                            //                         const EdgeInsets.all(4.0),
                            //                     child: Image.asset(
                            //                       ImageConst.doubleTickIcon,
                            //                       scale: 4.5,
                            //                     ),
                            //                   )
                            //                 : Padding(
                            //                     padding:
                            //                         const EdgeInsets.all(4.0),
                            //                     child: Image.asset(
                            //                         ImageConst.doubleTickIcon,
                            //                         scale: 4.5,
                            //                         color:
                            //                             CommonColor.geryD9D9D9),
                            //                   )
                            //           ],
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
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
        ),
      ),
    );
  }

  Row dateShowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonWidget.commonBackButton(onTap: () {
          if (selectedPilesDose < 6) {
            dayOf = DateTime.utc(
              dayOf.year,
              dayOf.month,
              dayOf.day - 1,
            );

            selectedPilesDose += 1;
          }
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
              selectedPilesDose -= 1;
            }

            setState(() {});
          }),
        ),
      ],
    );
  }

  Widget graphWidget() {
    return Container(
        width: Get.width,
        // height: 210,
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(12)),
        //height: 500,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: Image.asset(
            'assets/png/medicine_graph.png',
            fit: BoxFit.contain,
            scale: 2,
          ),
        ));
  }

  Row userProfileWidget() {
    return Row(
      children: [
        CommonWidget.commonSizedBox(width: 26),
        Container(
          height: 44.sp,
          decoration: BoxDecoration(
              border: Border.all(color: CommonColor.greenColor, width: 2),
              shape: BoxShape.circle),
          width: 44.sp,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100.h),
              child: Image.network(
                widget.userImg,
                fit: BoxFit.cover,
              )),
        ),
        CommonWidget.commonSizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.textBoldWight500(
                text: '${widget.userName.capitalizeFirst}',
                fontSize: 12.sp,
                color: CommonColor.blackColor1B1B1B),
            CommonText.textBoldWight500(
                text: '${widget.userRelation}',
                fontSize: 9.sp,
                color: CommonColor.gery72777A),
          ],
        )
      ],
    );
  }

  AppBar header() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Row(
        children: [
          CommonWidget.commonBackButton(
            onTap: () {
              Get.back();
            },
          ),
        ],
      ),
      title: CommonText.textBoldWight500(
          text: "${widget.userName.capitalizeFirst}'s Medical Report",
          fontSize: 13.sp,
          color: CommonColor.blackButtonColor1E232C),
      centerTitle: true,
      actions: [
        Row(
          children: [
            CommonWidget.commonBackButton(
              image: ImageConst.filter,
              color: CommonColor.blackColor0D0D0D,
              onTap: () {
                setState(() {
                  isDaily = !isDaily;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Column weekShowWidget() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CommonText.textBoldWight500(text: "Weekly Performance", fontSize: 12.sp),
      Row(
        children: [
          CommonText.textBoldWight500(
              text:
                  "${DateFormat("dd MMM").format(startDate)} - ${DateFormat("dd MMM yyyy").format(endDate)}",
              fontSize: 11.sp),
          SizedBox(width: 10.sp),
          Container(
            height: 20.sp,
            width: 20.sp,
            decoration: BoxDecoration(
                color: CommonColor.greenColor,
                borderRadius: BorderRadius.circular(7)),
            child: IconButton(
              icon: SvgPicture.asset(ImageConst.backArrow,
                  color: CommonColor.whiteColorEDEDED),
              onPressed: () async {
                endDate =
                    DateTime.utc(endDate.year, endDate.month, endDate.day - 7);
                startDate = DateTime.utc(
                  startDate.year,
                  startDate.month,
                  startDate.day - 7,
                );

                await getWeekRecordMedicineViewModel
                    .getWeekRecordMedicineViewModel(body: {
                  "startDate": "${startDate.toString().split(" ").first}",
                  "endDate": /*"2023-01-30"*/
                      "${endDate.toString().split(" ").first}"
                });
                setState(() {});
              },
            ),
          ),
          SizedBox(width: 7.sp),
          RotatedBox(
            quarterTurns: 2,
            child: Container(
              height: 20.sp,
              width: 20.sp,
              decoration: BoxDecoration(
                  color: CommonColor.greenColor,
                  borderRadius: BorderRadius.circular(7)),
              child: IconButton(
                icon: SvgPicture.asset(ImageConst.backArrow,
                    color: CommonColor.whiteColorEDEDED),
                onPressed: () async {
                  var difference = DateTime.now().difference(startDate).inDays;
                  if (difference != 0) {
                    endDate = DateTime.utc(
                        endDate.year, endDate.month, endDate.day + 7);
                    startDate = DateTime.utc(
                        startDate.year, startDate.month, startDate.day + 7);

                    await getWeekRecordMedicineViewModel
                        .getWeekRecordMedicineViewModel(body: {
                      "startDate": "${startDate.toString().split(" ").first}",
                      "endDate": /*"2023-01-30"*/
                          "${endDate.toString().split(" ").first}"
                    });
                  }

                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}
