import 'package:dotted_line/dotted_line.dart';
import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/responseModel/get_record_medicine_res_model.dart';
import 'package:expert_parrot_app/Models/responseModel/get_week_record_medicine_response_model.dart';
import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:expert_parrot_app/viewModel/get_record_medicine_view_model.dart';
import 'package:expert_parrot_app/viewModel/get_week_record_medicine_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:share_plus/share_plus.dart';

class MedicineGraphScreen extends StatefulWidget {
  const MedicineGraphScreen({Key? key}) : super(key: key);

  @override
  State<MedicineGraphScreen> createState() => _MedicineGraphScreenState();
}

class _MedicineGraphScreenState extends State<MedicineGraphScreen> {
  TextEditingController _emailOrMobileController = TextEditingController();
  String? verificationCode;
  DateTime dayOf = DateTime.now();
  bool isDaily = false;

  List medScheduleList = [
    {
      'image': ImageConst.capsule4,
      'medName': 'Xanax',
      'medGm': '(200MG)',
      'iconColor': Color(0xffFFDD2C),
      'dose': '1 Dose',
      'color': Color.fromRGBO(193, 196, 44, 0.13)
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
    {
      'image': ImageConst.capsule2,
      'medName': 'Ativan',
      'medGm': '(50MG)',
      'iconColor': Color(0xff9255E5),
      'dose': '2 Dose',
      'color': Color.fromRGBO(111, 44, 196, 0.13)
    },
    {
      'image': ImageConst.capsule1,
      'medName': 'Softgel',
      'medGm': '(100MG)',
      'iconColor': Color(0xff21D200),
      'dose': '3 Dose',
      'color': Color.fromRGBO(69, 196, 44, 0.13)
    },
    null,
  ];

  int medicineSelected = 0;
  int strengthSelected = 0;
  int daysSelected = 0;
  int appearanceSelected = 0;
  int frequencySelected = 0;
  int timeSelected = 0;
  double? innerRadius;

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
    [0, 1, 0],
    [0, 1, 1],
    [1, 1, 1],
    [0, 1, 0],
    [0, 1, 1],
    [0, 0, 1],
    [0, 1, 1]
  ];
  int selectedPilesDose = 0;
  int selectedPillIndex = 0;
  int limitData = 0;
  int weekTotal = 0;
  int weekTaken = 0;
  int weekSnoozed = 4;
  int weekMissed = 0;
  bool isFirst = true;
  String tmpID = "";
  String weekMedName = "";
  String weekGm = "";

  DateTime startDate = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day - 6);
  DateTime endDate = DateTime.now();

  List tmpList = [];

  GetRecordMedicineViewModel getRecordMedicineViewModel =
      Get.put(GetRecordMedicineViewModel());

  GetWeekRecordMedicineViewModel getWeekRecordMedicineViewModel =
      Get.put(GetWeekRecordMedicineViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('-=-=-=-=-=-= ${startDate.toString().split(" ").first}');
    print('-=-=-=-=-=-= end ${endDate.toString().split(" ").first}');
    getWeekRecordMedicineViewModel.getWeekRecordMedicineViewModel(body: {
      "startDate": "${startDate.toString().split(" ").first}",
      "endDate": /*"2023-01-30"*/
          "${endDate.toString().split(" ").first}"
    });
    getRecordMedicineViewModel.getRecordMedicineViewModel();
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
            header(),
            CommonWidget.commonSizedBox(height: 13),
            buildDottedLine(),
            GetBuilder<GetRecordMedicineViewModel>(builder: (controllerRM) {
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
                  for (int j = 0; j < respRM.data![i].records!.length; j++) {
                    if (respRM.data![i].records![j].sId == tmpID) {
                      limitData += 1;
                    }
                  }
                }

                return Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonWidget.commonSizedBox(height: 23),
                        respRM.data!.length != 0 && respRM.data!.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  !isDaily
                                      ? GetBuilder<
                                              GetWeekRecordMedicineViewModel>(
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
                                                  child:
                                                      CircularProgressIndicator(
                                                          strokeWidth: 1.5,
                                                          color: CommonColor
                                                              .greenColor),
                                                )
                                              ],
                                            );
                                          }

                                          if (controllerWeek
                                                  .getWeekRecordMedicineApiResponse
                                                  .status ==
                                              Status.COMPLETE) {
                                            GetWeekRecordMedicineResponseModel
                                                respWK = controllerWeek
                                                    .getWeekRecordMedicineApiResponse
                                                    .data;

                                            if (respWK.data.isNotEmpty &&
                                                respWK.data != []) {
                                              if (isFirst) {
                                                for (int i = 0;
                                                    i < respWK.data.length;
                                                    i++) {
                                                  for (int j = 0;
                                                      j <
                                                          respWK.data[i].records
                                                              .length;
                                                      j++) {
                                                    if (respWK.data[i]
                                                            .records[j].id ==
                                                        tmpID) {
                                                      weekTotal += respWK
                                                          .data[i]
                                                          .records[j]
                                                          .totalTimes;
                                                      weekTaken += respWK
                                                          .data[i]
                                                          .records[j]
                                                          .doses
                                                          .length;
                                                    }
                                                  }
                                                }
                                                isFirst = false;
                                                weekMissed =
                                                    weekTotal - weekTaken;
                                                weekMedName = respWK
                                                    .data[0].records[0].name;
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
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 30.sp),
                                                    child: CommonText
                                                        .textBoldWight500(
                                                            text:
                                                                "No data in this week"),
                                                  )
                                                ],
                                              );
                                          } else
                                            return Column(children: [
                                              weekShowWidget(),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 30.sp),
                                                  child: CommonText
                                                      .textBoldWight500(
                                                          text:
                                                              "Something went wrong"))
                                            ]);
                                        })
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            dateShowWidget(),
                                            CommonWidget.commonSizedBox(
                                                height: 23),
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
                                    itemCount: respRM.data![selectedPilesDose]
                                        .records!.length,
                                    itemBuilder: (context, index) {
                                      return medScheduleList[index] == null
                                          ? SizedBox()
                                          : medDetailsWidget(
                                              medId: respRM
                                                  .data![selectedPilesDose]
                                                  .records![index]
                                                  .sId!,
                                              totalTimes: respRM
                                                  .data![selectedPilesDose]
                                                  .records![index]
                                                  .totalTimes!,
                                              pilesList: listOfPiles[index],
                                              image: respRM
                                                          .data![
                                                              selectedPilesDose]
                                                          .records![index]
                                                          .appearance!
                                                          .toLowerCase() ==
                                                      'Tablet'
                                                  ? ImageConst.med3Icon
                                                  : respRM
                                                              .data![
                                                                  selectedPilesDose]
                                                              .records![index]
                                                              .appearance!
                                                              .toLowerCase() ==
                                                          'Cream'
                                                      ? ImageConst.med1Icon
                                                      : respRM.data![selectedPilesDose].records![index].appearance!.toLowerCase() ==
                                                              'Syrup'
                                                          ? ImageConst.med2Icon
                                                          : ImageConst.med2Icon,
                                              medName: respRM
                                                  .data![selectedPilesDose]
                                                  .records![index]
                                                  .name!,
                                              medGm:
                                                  '${respRM.data![selectedPilesDose].records![index].strength} gm',
                                              iconColor: respRM
                                                          .data![selectedPilesDose]
                                                          .records![index]
                                                          .appearance!
                                                          .toLowerCase() ==
                                                      'Tablet'
                                                  ? Color(0xff21D200)
                                                  : respRM.data![selectedPilesDose].records![index].appearance!.toLowerCase() == 'Cream'
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
                              )
                            : Center(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: CommonText.textBoldWight400(
                                        text:
                                            "No med schedule on ${CommonWidget.convertDateForm(dayOf)}")),
                              ),
                      ],
                    ),
                  ),
                );
              } else
                return SizedBox();
            }),
          ],
        ),
      ),
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
                    // PieChartSectionData(
                    //     value: weekSnoozed.toDouble(),
                    //     showTitle: false,
                    //     color: CommonColor.lightYellowColor,
                    //     radius: 30),
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
            // Row(
            //   children: [
            //     Container(
            //       height: 15,
            //       width: 30,
            //       margin: EdgeInsets.only(right: 5),
            //       decoration: BoxDecoration(
            //           color: CommonColor.lightYellowColor,
            //           borderRadius: BorderRadius.circular(20)),
            //     ),
            //     CommonText.textBoldWight500(
            //         text: '$weekSnoozed Snoozed',
            //         fontSize: 10.sp,
            //         color: CommonColor.blackColor0D0D0D)
            //   ],
            // ),
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
          tmpID = medId;
          isFirst = true;
          weekTotal = 0;
          weekTaken = 0;
          weekMissed = 0;
          weekMedName = medName;
          weekGm = medGm;

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
                      child: Image.asset(image)),
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
          if (selectedPilesDose < limitData - 1) {
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

  Row header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 30.sp,
          width: 30.sp,
        ),
        CommonText.textBoldWight500(
            text: TextConst.medicineReport, fontSize: 18.sp),
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
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final double x;
  final double y;
  final Color? color;
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
