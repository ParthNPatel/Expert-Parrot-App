import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/responseModel/get_record_medicine_res_model.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:expert_parrot_app/viewModel/get_record_medicine_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../components/common_widget.dart';

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

  GetRecordMedicineViewModel getRecordMedicineViewModel =
      Get.put(GetRecordMedicineViewModel());

  @override
  void initState() {
    super.initState();
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

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonWidget.commonSizedBox(height: 23),
                          dateShowWidget(),
                          CommonWidget.commonSizedBox(height: 23),
                          respRM.data!.length != 0 && respRM.data!.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 120.sp,
                                      alignment: Alignment.center,
                                      // color: Colors.grey.shade300,
                                      child: ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: respRM.data!.length > 7
                                              ? 7
                                              : respRM.data!.length,
                                          shrinkWrap: true,
                                          reverse: true,
                                          itemBuilder: (_, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    //  height: 150,
                                                    // color: Colors.red,
                                                    width: 28,
                                                    child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      shrinkWrap: true,
                                                      itemCount: respRM
                                                                  .data![index]
                                                                  .date ==
                                                              dayOf
                                                                  .toString()
                                                                  .split(" ")
                                                                  .first
                                                          ? respRM
                                                              .data![index]
                                                              .records![
                                                                  selectedPillIndex]
                                                              .totalTimes
                                                          : 3,
                                                      itemBuilder: (context,
                                                          indexOfDose) {
                                                        print(
                                                            '$indexOfDose${selectedPilesDose}');
                                                        return Column(
                                                          children: [
                                                            pilesContainer(
                                                                completedDoses: respRM
                                                                    .data![
                                                                        index]
                                                                    .records![
                                                                        selectedPillIndex]
                                                                    .doses!,
                                                                selectMainDose:
                                                                    index,
                                                                selectedList:
                                                                    selectedPilesDose,
                                                                index:
                                                                    indexOfDose,
                                                                totalDoseLength:
                                                                    listOfPiles[
                                                                            index]
                                                                        .length),
                                                            Divider(
                                                              color:
                                                                  Colors.white,
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
                                                      child: CommonText
                                                          .textBoldWight600(
                                                              color: CommonColor
                                                                  .gery9D9D9D,
                                                              fontSize: 10,
                                                              text: weekDayGen(
                                                                  date: respRM
                                                                      .data![
                                                                          index]
                                                                      .date!))),
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
                                            itemCount: respRM
                                                .data![selectedPilesDose]
                                                .records![selectedPillIndex]
                                                .totalTimes!,
                                            separatorBuilder: (context, index) {
                                              return SizedBox(width: 20.sp);
                                            },
                                            itemBuilder: (context, index) {
                                              return respRM
                                                      .data![selectedPilesDose]
                                                      .records![
                                                          selectedPillIndex]
                                                      .doses!
                                                      .contains(index + 1)
                                                  ? Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Image.asset(
                                                            ImageConst
                                                                .doubleTickIcon,
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
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Image.asset(
                                                            ImageConst
                                                                .doubleTickIcon,
                                                            scale: 4,
                                                            color: Color(
                                                                    0xffFB0A0A)
                                                                .withOpacity(
                                                                    .8),
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
                                    Align(
                                        alignment: Alignment.center,
                                        child: CommonText.textBoldWight500(
                                            text: 'Pill List',
                                            fontSize: 18.sp,
                                            color:
                                                CommonColor.blackColor0D0D0D)),
                                    CommonWidget.commonSizedBox(height: 4),
                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      reverse: true,
                                      itemCount: respRM.data![selectedPilesDose]
                                          .records!.length,
                                      itemBuilder: (context, index) {
                                        print(
                                            'dfgvde ${medScheduleList[index]}');

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
                                                image: respRM.data![selectedPilesDose].records![index].appearance!
                                                            .toLowerCase() ==
                                                        'pills'
                                                    ? ImageConst.med3Icon
                                                    : respRM.data![selectedPilesDose].records![index].appearance!
                                                                .toLowerCase() ==
                                                            'gel'
                                                        ? ImageConst.med1Icon
                                                        : respRM.data![selectedPilesDose].records![index].appearance!
                                                                    .toLowerCase() ==
                                                                'syrup'
                                                            ? ImageConst
                                                                .med2Icon
                                                            : ImageConst
                                                                .med2Icon,
                                                medName: respRM
                                                    .data![selectedPilesDose]
                                                    .records![index]
                                                    .name!,
                                                medGm:
                                                    '${respRM.data![selectedPilesDose].records![index].strength} gm',
                                                iconColor: respRM
                                                            .data![
                                                                selectedPilesDose]
                                                            .records![index]
                                                            .appearance!
                                                            .toLowerCase() ==
                                                        'pills'
                                                    ? Color(0xff21D200)
                                                    : respRM
                                                                .data![selectedPilesDose]
                                                                .records![index]
                                                                .appearance!
                                                                .toLowerCase() ==
                                                            'gel'
                                                        ? Color(0xffFFDD2C)
                                                        : respRM.data![selectedPilesDose].records![index].appearance!.toLowerCase() == 'syrup'
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
                      );
                    } else
                      return SizedBox();
                  }),
/*                  Container(
                    height: 140,
                    // color: Colors.grey.shade300,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(listOfWeak.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  //  height: 150,
                                  width: 28,
                                  // color: Colors.red,
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: listOfPiles[index].length,
                                    itemBuilder: (context, indexOfDose) {
                                      return Column(
                                        children: [
                                          pilesContainer(
                                              colorSelected: listOfPiles[index]
                                                  [indexOfDose],
                                              selectMainDose: index,
                                              selectedList: selectedPilesDose,
                                              index: indexOfDose,
                                              totalDoseLength:
                                                  listOfPiles[index].length,
                                              date: '2-12-12',
                                              completedDoses: [1, 2]),
                                          Divider(
                                            color: Colors.white,
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
                                        text: listOfWeak[index])),
                              ],
                            ),
                          );
                        })),
                  ),
                  graphWidget(),
                  CommonWidget.commonSizedBox(height: 16),
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
                    itemCount: medScheduleList.length,
                    itemBuilder: (context, index) {
                      return medScheduleList[index] == null
                          ? SizedBox()
                          : medDetailsWidget(
                              pilesList: listOfPiles[index],
                              image: medScheduleList[index]['image'],
                              medName: medScheduleList[index]['medName'],
                              medGm: medScheduleList[index]['medGm'],
                              iconColor: medScheduleList[index]['iconColor'],
                              dose: medScheduleList[index]["dose"],
                              index: index,
                              medId: 'asddfedfsadfsa',
                              totalTimes: 3);
                    },
                  ),
                  CommonWidget.commonSizedBox(height: 100),*/
                ]),
              ),
            )
            // CommonWidget.commonSizedBox(height: 23),
            // Container(
            //   width: Get.width,
            //   height: 186.sp,
            //   child: Image.asset(
            //     ImageConst.verticalGraph, fit: BoxFit.contain,
            //     // scale: 5.5,
            //   ),
            // ),
            // CommonWidget.commonSizedBox(height: 20),
            // tabWidget(),
            // CommonWidget.commonSizedBox(height: 25),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Row(children: [
            //       Container(
            //           height: 28.sp,
            //           width: 28.sp,
            //           padding: EdgeInsets.all(8),
            //           decoration: BoxDecoration(
            //             boxShadow: [
            //               new BoxShadow(
            //                 color: Colors.grey.shade200,
            //                 blurRadius: 20.0,
            //               ),
            //             ],
            //             shape: BoxShape.circle,
            //             color: Colors.white,
            //           ),
            //           child: CommonWidget.commonSvgPitcher(
            //               height: 50, image: ImageConst.capsule1)),
            //       CommonWidget.commonSizedBox(width: 8),
            //       CommonText.textBoldWight400(
            //           text: 'Softgel',
            //           color: CommonColor.blackColor353535,
            //           fontSize: 14.sp),
            //     ]),
            //     Column(children: [
            //       Row(
            //         children: [
            //           CommonText.textBoldWight400(
            //               text: '09:28 AM',
            //               color: CommonColor.blackColor353535,
            //               fontSize: 13.sp),
            //           CommonWidget.commonSvgPitcher(
            //             image: ImageConst.verified,
            //           )
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           CommonText.textBoldWight400(
            //               text: '09:28 AM',
            //               color: CommonColor.blackColor353535,
            //               fontSize: 13.sp),
            //           CommonWidget.commonSvgPitcher(
            //             image: ImageConst.verified,
            //           )
            //         ],
            //       ),
            //     ]),
            //   ],
            // ),
            // CommonWidget.commonSizedBox(height: 6),
            // CommonWidget.commonSvgPitcher(
            //   image: 'assets/svg/Line 5.svg',
            // ),
            // CommonWidget.commonSizedBox(height: 6),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Row(children: [
            //       Container(
            //           height: 28.sp,
            //           width: 28.sp,
            //           padding: EdgeInsets.all(8),
            //           decoration: BoxDecoration(
            //             boxShadow: [
            //               new BoxShadow(
            //                 color: Colors.grey.shade200,
            //                 blurRadius: 20.0,
            //               ),
            //             ],
            //             shape: BoxShape.circle,
            //             color: Colors.white,
            //           ),
            //           child: Image.asset(ImageConst.med1Icon)),
            //       CommonWidget.commonSizedBox(width: 8),
            //       CommonText.textBoldWight400(
            //           text: 'Disprien',
            //           color: CommonColor.blackColor353535,
            //           fontSize: 14.sp),
            //     ]),
            //     Row(
            //       children: [
            //         CommonText.textBoldWight400(
            //             text: '01:30 PM',
            //             color: CommonColor.blackColor353535,
            //             fontSize: 13.sp),
            //         CommonWidget.commonSvgPitcher(
            //           image: ImageConst.verified,
            //         )
            //       ],
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
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

/*  Dialog addMedicineDialog(BuildContext context, StateSetter setState) {
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
                                                        Icon(
                                                          Icons.check,
                                                          size: 17,
                                                          color:
                                                              medicineSelected ==
                                                                      index
                                                                  ? CommonColor
                                                                      .greenColor
                                                                  : Colors
                                                                      .white,
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
                                                            Icon(
                                                              Icons.check,
                                                              size: 17,
                                                              color: strengthSelected ==
                                                                      index
                                                                  ? CommonColor
                                                                      .greenColor
                                                                  : Colors
                                                                      .transparent,
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
                                                            Icon(
                                                              Icons.check,
                                                              size: 17,
                                                              color: daysSelected ==
                                                                      index
                                                                  ? CommonColor
                                                                      .greenColor
                                                                  : Colors
                                                                      .transparent,
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
                                                Icon(
                                                  Icons.check,
                                                  size: 17,
                                                  color: appearanceSelected ==
                                                          index
                                                      ? CommonColor.greenColor
                                                      : Colors.transparent,
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
                                                                                      Icon(
                                                                                        Icons.check,
                                                                                        size: 17,
                                                                                        color: frequencySelected == index ? CommonColor.greenColor : Colors.transparent,
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
                                                                                    Icon(
                                                                                      Icons.check,
                                                                                      size: 17,
                                                                                      color: timeSelected == index ? CommonColor.greenColor : Colors.transparent,
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
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Column(
                                                              children:
                                                                  List.generate(
                                                                timeSelected ==
                                                                        0
                                                                    ? 1
                                                                    : timeSelected ==
                                                                            1
                                                                        ? 2
                                                                        : 3,
                                                                (index) =>
                                                                    Container(
                                                                  height: 40.sp,
                                                                  width: 170.sp,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              10),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    color: Color(
                                                                        0xffF8F8F6),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width:
                                                                            18,
                                                                      ),
                                                                      SvgPicture
                                                                          .asset(
                                                                        'assets/svg/notification2.svg',
                                                                        height:
                                                                            15.sp,
                                                                        width: 15
                                                                            .sp,
                                                                        color: Color(
                                                                            0xff9B9B9B),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            18,
                                                                      ),
                                                                      CommonText.textBoldWight500(
                                                                          text:
                                                                              "10:00 AM",
                                                                          fontSize: 13
                                                                              .sp,
                                                                          color:
                                                                              Colors.black),
                                                                    ],
                                                                  ),
                                                                ),
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
  }*/

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
          fontSize: 16.sp,
          color: CommonColor.blackButtonColor1E232C),
      centerTitle: true,
    );
  }
}
