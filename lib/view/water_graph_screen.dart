import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/add_glass_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/get_glass_res_model.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:expert_parrot_app/viewModel/add_glass_view_model.dart';
import 'package:expert_parrot_app/viewModel/get_glass_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../components/common_widget.dart';
import '../constant/color_const.dart';

class WaterGraphScreen extends StatefulWidget {
  const WaterGraphScreen({Key? key}) : super(key: key);

  @override
  State<WaterGraphScreen> createState() => _WaterGraphScreenState();
}

class _WaterGraphScreenState extends State<WaterGraphScreen> {
  List dayList = ["Sat", 'Fri', 'Thu', 'Wed', 'Tue', 'Mon'];

  List waterType = ["glass", 'Bottle', 'Lg Bottle'];

  List waterTypeList = ["glass", 'bottle', 'large_bottle'];

  List testGlass = [
    {
      "_id": "63918eb5b855ba832133d745",
      "userId": "63877256f5c54cd8e6790c12",
      "bottle": 6,
      "createdAt": "2022-12-08T07:13:57.707Z",
      "date": "2022-12-08T14:40:42.000Z",
      "glass": 2,
      "large_bottle": 6,
      "updatedAt": "2022-12-08T09:11:42.733Z"
    },
    {
      "_id": "63918eb5b855ba832133d745",
      "userId": "63877256f5c54cd8e6790c12",
      "bottle": 5,
      "createdAt": "2022-12-08T07:13:57.707Z",
      "date": "2022-12-07T14:40:42.000Z",
      "glass": 6,
      "large_bottle": 2,
      "updatedAt": "2022-12-08T09:11:42.733Z"
    },
    {
      "_id": "63918eb5b855ba832133d745",
      "userId": "63877256f5c54cd8e6790c12",
      "bottle": 7,
      "createdAt": "2022-12-08T07:13:57.707Z",
      "date": "2022-12-06T14:40:42.000Z",
      "glass": 2,
      "large_bottle": 4,
      "updatedAt": "2022-12-08T09:11:42.733Z"
    }
  ];

  int selectType = 0;
  int selectedIndex = 0;
  List days = [];
  int ozGlass = 0;
  int ozBottle = 0;
  int ozLgBottle = 0;

  AddGlassViewModel addGlassViewModel = Get.put(AddGlassViewModel());
  GetGlassViewModel getGlassViewModel = Get.put(GetGlassViewModel());

  TextEditingController _glassController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGlassViewModel.getGlassViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonWidget.commonBackGround(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
              GetBuilder<GetGlassViewModel>(
                builder: (controller) {
                  if (controller.getGlassApiResponse.status == Status.LOADING) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: CommonColor.greenColor,
                      ),
                    );
                  }
                  if (controller.getGlassApiResponse.status ==
                      Status.COMPLETE) {
                    GetGlassResponseModel response =
                        controller.getGlassApiResponse.data;

                    // for (int i = 0; i < response.data!.docs!.length; i++) {
                    //   // log('HELLO ${CommonWidget.convertDateForm(response.data!.docs![i].date!)!}');
                    //   days.add(CommonWidget.convertDateForm(
                    //       response.data!.docs![i].date!));
                    // }
                    // log('TOTAL TIME :${days}');
                    final List<ChartData> chartData = List.generate(
                        response.data!.docs!.reversed.toList().length >= 7
                            ? 7
                            : response.data!.docs!.reversed.toList().length,
                        (index) => ChartData(
                            DateFormat("dd MMM").format(response
                                .data!.docs!.reversed
                                .toList()[index]
                                .date!),
                            selectedIndex == 0
                                ? response.data!.docs!.reversed
                                    .toList()[index]
                                    .glass!
                                    .toDouble()
                                : selectedIndex == 1
                                    ? response.data!.docs!.reversed
                                        .toList()[index]
                                        .bottle!
                                        .toDouble()
                                    : response.data!.docs!.reversed
                                        .toList()[index]
                                        .largeBottle!
                                        .toDouble()));

                    return Column(
                      children: [
                        Container(
                          height: 270.sp,
                          padding: EdgeInsets.symmetric(vertical: 20.sp),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 200.sp,
                                child: SfCartesianChart(
                                  series: <ChartSeries>[
                                    SplineSeries<ChartData, String>(
                                        dataSource: chartData,
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                        color: CommonColor.greenColor)
                                  ],
                                  plotAreaBorderWidth: 0,
                                  primaryXAxis: CategoryAxis(
                                      arrangeByIndex: false,
                                      opposedPosition: true,
                                      axisLine: AxisLine(width: 0),
                                      borderWidth: 0,
                                      majorTickLines: MajorTickLines(size: 0),
                                      minorTickLines: MinorTickLines(size: 0),
                                      majorGridLines: MajorGridLines(width: 0),
                                      minorGridLines: MinorGridLines(width: 0),
                                      axisBorderType:
                                          AxisBorderType.withoutTopAndBottom,
                                      labelStyle: TextStyle(
                                          color: CommonColor.greenColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10.sp)),
                                  primaryYAxis: CategoryAxis(isVisible: false),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      height: 12.sp,
                                      width: 12.sp,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: CommonColor.greenColor)),
                                  SizedBox(width: 5.sp),
                                  CommonText.textBoldWight500(
                                      text: "Achieved",
                                      fontSize: 13.sp,
                                      color: CommonColor.blackColor0D0D0D),
                                ],
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 10),
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
                              scale: 4.5,
                            ),
                            response.data!.docs != null &&
                                    response.data!.docs!.isNotEmpty
                                ? CommonText.textBoldWight600(
                                    text:
                                        ' ${(response.data!.docs!.first.glass! * 8) + (response.data!.docs!.first.bottle! * 16) + (response.data!.docs!.first.largeBottle! * 16)}',
                                    fontSize: 20.sp,
                                    color: CommonColor.blackColor1D253C)
                                : CommonText.textBoldWight600(
                                    text: ' 0',
                                    fontSize: 20.sp,
                                    color: CommonColor.blackColor1D253C),
                            CommonText.textBoldWight400(
                                text: ' fl oz of your ',
                                fontSize: 13.sp,
                                color: CommonColor.gery727272),
                            CommonText.textBoldWight500(
                                text: '64 ',
                                fontSize: 14.sp,
                                color: CommonColor.blackColor1D253C),
                            CommonText.textBoldWight400(
                                text: 'fl oz goal',
                                fontSize: 13.sp,
                                color: CommonColor.gery727272),
                          ],
                        ),
                        CommonWidget.commonSizedBox(height: 12),
                        // GetBuilder<GetGlassViewModel>(builder: (controller) {
                        //   if (controller.getGlassApiResponse.status == Status.LOADING) {
                        //     return CircularProgressIndicator();
                        //   }
                        //   if (controller.getGlassApiResponse.status == Status.ERROR) {
                        //     return CommonWidget.getSnackBar(
                        //         duration: 2,
                        //         color: Colors.red.shade300,
                        //         colorText: Colors.white,
                        //         title: "Oops!",
                        //         message: 'Something goes wrong to get data!');
                        //   }
                        //   if (controller.getGlassApiResponse.status == Status.COMPLETE) {
                        //     GetGlassResponseModel resp = GetGlassResponseModel();
                        //
                        //     return ListView.builder(
                        //       shrinkWrap: true,
                        //       physics: NeverScrollableScrollPhysics(),
                        //       itemCount: resp.data!.length >= 7 ? 7 : resp.data!.length,
                        //       itemBuilder: (context, index) {
                        //         return Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             CommonWidget.commonSvgPitcher(
                        //               image: 'assets/svg/Line 5.svg',
                        //             ),
                        //             Row(
                        //               children: [
                        //                 SizedBox(
                        //                   width: 55.sp,
                        //                   child: Padding(
                        //                     padding: EdgeInsets.symmetric(
                        //                         horizontal: 10, vertical: 10),
                        //                     child: CommonText.textBoldWight500(
                        //                         text: dayList[index],
                        //                         // text: resp.data![index].updatedAt.weekday,
                        //
                        //                         fontSize: 12.sp,
                        //                         color: CommonColor.blackColor1D253C),
                        //                   ),
                        //                 ),
                        //                 CommonWidget.commonSizedBox(width: 20),
                        //                 CommonText.textBoldWight500(
                        //                     text: '0 ',
                        //                     fontSize: 14.sp,
                        //                     color: CommonColor.blackColor1D253C),
                        //                 CommonText.textBoldWight500(
                        //                     text: 'fl oz',
                        //                     fontSize: 12.sp,
                        //                     color: CommonColor.gery696969)
                        //               ],
                        //             ),
                        //           ],
                        //         );
                        //       },
                        //     );
                        //   } else
                        //     return SizedBox();
                        // }),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: response.data!.docs!.length,
                          itemBuilder: (context, index) {
                            String times = CommonWidget.convertDateForm(
                                response.data!.docs![index].date!)!;

                            // for (int i = 0;
                            //     i < response.data!.docs![index].data!.length;
                            //     i++) {
                            //   if (addGlassViewModel.index == 0 &&
                            //       response.data!.docs![index].data![i].type ==
                            //           'glass') {
                            //     ozGlass += response
                            //         .data!.docs![index].data![i].quantity!;
                            //   } else if (addGlassViewModel.index == 1 &&
                            //       response.data!.docs![index].data![i].type ==
                            //           'Bottle') {
                            //     ozBottle += response
                            //         .data!.docs![index].data![i].quantity!;
                            //   } else if (addGlassViewModel.index == 2 &&
                            //       response.data!.docs![index].data![i].type ==
                            //           'Lg Bottle') {
                            //     ozLgBottle += response
                            //         .data!.docs![index].data![i].quantity!;
                            //   }
                            // }
                            // for (int i = 0;
                            //     i < response.data!.docs![index].data!.length;
                            //     i++) {
                            //   if (addGlassViewModel.index == 0 &&
                            //       response.data!.docs![index].data![i].type ==
                            //           'glass') {
                            //     return ShowData(times, response, index, i);
                            //   } else if (addGlassViewModel.index == 1 &&
                            //       response.data!.docs![index].data![i].type ==
                            //           'Bottle') {
                            //     return ShowData(times, response, index, i);
                            //   } else if (addGlassViewModel.index == 2 &&
                            //       response.data!.docs![index].data![i].type ==
                            //           'Lg Bottle') {
                            //     return ShowData(times, response, index, i);
                            //   }
                            // }
                            return ShowData(times, response, index);

                            // return ListView.builder(
                            //   shrinkWrap: true,
                            //   physics: NeverScrollableScrollPhysics(),
                            //   itemCount:
                            //       response.data!.docs![index].data!.length,
                            //   itemBuilder: (context, index1) {
                            //     String times = CommonWidget.convertDateForm(
                            //         response.data!.docs![index].date!)!;
                            //     if (addGlassViewModel.index == 0 &&
                            //         response.data!.docs![index].data![index1]
                            //                 .type ==
                            //             'glass') {
                            //       return ShowData(
                            //           times, response, index, index1);
                            //     } else if (addGlassViewModel.index == 1 &&
                            //         response.data!.docs![index].data![index1]
                            //                 .type ==
                            //             'Bottle') {
                            //       return ShowData(
                            //           times, response, index, index1);
                            //     } else if (addGlassViewModel.index == 2 &&
                            //         response.data!.docs![index].data![index1]
                            //                 .type ==
                            //             'Lg Bottle') {
                            //       return ShowData(
                            //           times, response, index, index1);
                            //     }
                            //     return SizedBox();
                            //   },
                            // );
                          },
                        ),
                        CommonWidget.commonSizedBox(height: 100),
                      ],
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: 100.sp),
                    child: Text('Something went wrong'),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  String weekDayCounter(int dayNumber) {
    String weekDay = "Mon";

    switch (dayNumber) {
      case 1:
        weekDay = 'Mon';

        break;
      case 2:
        weekDay = 'Tue';

        break;
      case 3:
        weekDay = 'Wed';

        break;
      case 4:
        weekDay = 'Thu';

        break;
      case 5:
        weekDay = 'Fri';

        break;
      case 6:
        weekDay = 'Sat';

        break;
      case 7:
        weekDay = 'Sun';

        break;
      default:
        return weekDay;
    }

    return weekDay;
  }

  Column ShowData(
    String times,
    GetGlassResponseModel response,
    int index,
  ) {
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: CommonText.textBoldWight500(
                    text: times,
                    // text: resp.data![index].updatedAt.weekday,
                    fontSize: 12.sp,
                    color: CommonColor.blackColor1D253C),
              ),
            ),
            CommonWidget.commonSizedBox(width: 20),
            CommonText.textBoldWight500(
                text: selectedIndex == 0
                    ? '${(response.data!.docs![index].glass! * 8)}'
                    : selectedIndex == 1
                        ? '${(response.data!.docs![index].bottle! * 16)}'
                        : '${(response.data!.docs![index].largeBottle! * 16)}',
                fontSize: 14.sp,
                color: CommonColor.blackColor1D253C),
            CommonText.textBoldWight500(
              text: 'fl oz',
              fontSize: 12.sp,
              color: CommonColor.gery696969,
            )
          ],
        ),
      ],
    );
  }

  Widget waterBottleWidget() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
              child: Container(
                  width: 28.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selectedIndex == 0
                          ? CommonColor.greenColor
                          : Colors.transparent,
                    ),
                  ),
                  child: GetBuilder<GetGlassViewModel>(
                    builder: (controller) {
                      if (controller.getGlassApiResponse.status ==
                          Status.COMPLETE) {
                        GetGlassResponseModel response =
                            controller.getGlassApiResponse.data;
                        return bottleWidget(
                            oz: '(8 fl oz)',
                            image: ImageConst.glassOfWater,
                            typeOfBottle: response.data!.docs != null &&
                                    response.data!.docs!.isNotEmpty
                                ? '${response.data!.docs!.first.glass} Glass'
                                : '0 Glass');
                      }
                      return SizedBox();
                    },
                  )),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
              child: Container(
                  width: 28.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: selectedIndex == 1
                              ? CommonColor.greenColor
                              : Colors.transparent)),
                  child: GetBuilder<GetGlassViewModel>(
                    builder: (controller) {
                      if (controller.getGlassApiResponse.status ==
                          Status.COMPLETE) {
                        GetGlassResponseModel response =
                            controller.getGlassApiResponse.data;
                        return bottleWidget(
                            oz: '(16 fl oz)',
                            image: ImageConst.water1Icon,
                            typeOfBottle: response.data!.docs != null &&
                                    response.data!.docs!.isNotEmpty
                                ? '${response.data!.docs!.first.bottle} Bottle'
                                : '0 Bottle');
                      }
                      return SizedBox();
                    },
                  )),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                });
              },
              child: Container(
                  width: 28.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: selectedIndex == 2
                              ? CommonColor.greenColor
                              : Colors.transparent)),
                  child: GetBuilder<GetGlassViewModel>(
                    builder: (controller) {
                      if (controller.getGlassApiResponse.status ==
                          Status.LOADING) {
                        return SizedBox();
                      }
                      if (controller.getGlassApiResponse.status ==
                          Status.COMPLETE) {
                        GetGlassResponseModel response =
                            controller.getGlassApiResponse.data;
                        return bottleWidget(
                            oz: '(16 fl oz)',
                            image: ImageConst.plasticBottle,
                            typeOfBottle: response.data!.docs != null &&
                                    response.data!.docs!.isNotEmpty
                                ? '${response.data!.docs!.first.largeBottle} Lg Bottle'
                                : '0 Lg Bottle');
                      }
                      return SizedBox();
                    },
                  )),
            ),

            // bottleWidget(
            //     oz: '(8 fl oz)',
            //     image: ImageConst.plasticBottle,
            //     typeOfBottle: '1 Glass'),
            // bottleWidget(
            //     oz: '(8 fl oz)',
            //     image: ImageConst.water1Icon,
            //     typeOfBottle: '1 Glass'),
          ],
        )

        /*ListView.separated(
            itemCount: 3,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return SizedBox(width: 10);
            },
            itemBuilder: (context, index) {
              return bottleWidget(
                  oz: '(8 fl oz)',
                  image: index == 0
                      ? ImageConst.glassOfWater
                      : index == 1
                          ? ImageConst.plasticBottle
                          : ImageConst.water1Icon,
                  typeOfBottle: '1 Glass');
              // bottleWidget(
              //     oz: '(8 fl oz)',
              //     image: ImageConst.plasticBottle,
              //     typeOfBottle: '1 Glass'),
              // bottleWidget(
              //     oz: '(8 fl oz)',
              //     image: ImageConst.water1Icon,
              //     typeOfBottle: '1 Glass'),
            },
          ),*/
        );
  }

  Container bottleWidget(
      {required String image,
      required String typeOfBottle,
      required String oz}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        children: [
          CommonWidget.commonSizedBox(height: 18),
          SizedBox(height: 35, child: Image.asset(image)),
          CommonWidget.commonSizedBox(height: 15),
          CommonText.textBoldWight500(
              text: typeOfBottle,
              fontSize: 12.sp,
              color: CommonColor.blackColor1D253C),
          CommonText.textBoldWight400(
              text: oz, fontSize: 11.sp, color: CommonColor.gery727272),
        ],
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
        GetBuilder<AddGlassViewModel>(
          builder: (controller) {
            return CommonWidget.commonBackButton(
              image: ImageConst.add,
              onTap: () {
                Get.dialog(
                  StatefulBuilder(
                      builder: (context, setState) => Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SizedBox(
                              height: 250.sp,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CommonText.textBoldWight500(
                                          text: "Enter",
                                          fontSize: 17.sp,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _glassController.clear();
                                            Get.back();
                                          },
                                          child: CommonWidget.commonSvgPitcher(
                                            image: ImageConst.close,
                                          ),
                                        )
                                      ],
                                    ),
                                    CommonWidget.dottedLineWidget(),
                                    SizedBox(height: 20),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: Column(
                                          children: [
                                            Container(
                                              //height: 40.sp,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Color(0xffF8F8F6),
                                              ),
                                              child: Theme(
                                                data: Theme.of(context)
                                                    .copyWith(
                                                        dividerColor:
                                                            Colors.transparent),
                                                child: ExpansionTile(
                                                  iconColor:
                                                      CommonColor.greenColor,
                                                  title: Row(
                                                    children: [
                                                      CommonText.textBoldWight500(
                                                          text:
                                                              "${waterType[selectType]}",
                                                          fontSize: 13.sp,
                                                          color: Colors.black),
                                                    ],
                                                  ),
                                                  children: [
                                                    Container(
                                                      color: Colors.white,
                                                      child: Column(
                                                        children: List.generate(
                                                          waterType.length,
                                                          (index) =>
                                                              GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                selectType =
                                                                    index;
                                                              });
                                                              setState(() {});
                                                              log("select:- ${waterType[selectType]}");
                                                            },
                                                            child: Container(
                                                              color: selectType ==
                                                                      index
                                                                  ? Color(
                                                                      0xffe1f9ea)
                                                                  : Colors
                                                                      .white,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          10),
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.check,
                                                                    size: 17,
                                                                    color: selectType ==
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
                                                                    text: waterType[
                                                                        index],
                                                                  )
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
                                            TextFormField(
                                              controller: _glassController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Color(0xffF8F8F6),
                                                hintText: "Enter count ",
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 20.sp),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(width: 20.sp),
                                                SizedBox(
                                                  height: 6.5.h,
                                                  width: 25.w,
                                                  child:
                                                      CommonWidget.commonButton(
                                                          color: CommonColor
                                                              .greenColor,
                                                          radius: 10,
                                                          onTap: () async {
                                                            if (_glassController
                                                                .text
                                                                .isNotEmpty) {
                                                              await AddGlassRepo1
                                                                  .addGlassRepo(
                                                                      addGlass:
                                                                          _glassController,
                                                                      model: {
                                                                    "type":
                                                                        "${waterTypeList[selectType]}",
                                                                    "quantity":
                                                                        _glassController
                                                                            .text
                                                                            .trim()
                                                                  });

                                                              await getGlassViewModel
                                                                  .getGlassViewModel(
                                                                      isLoading:
                                                                          false);
                                                              if (getGlassViewModel
                                                                      .getGlassApiResponse
                                                                      .status ==
                                                                  Status
                                                                      .COMPLETE) {}
                                                              if (getGlassViewModel
                                                                      .getGlassApiResponse
                                                                      .status ==
                                                                  Status
                                                                      .ERROR) {
                                                                CommonWidget.getSnackBar(
                                                                    duration: 2,
                                                                    color: CommonColor
                                                                        .greenColor
                                                                        .withOpacity(
                                                                            .4),
                                                                    colorText:
                                                                        Colors
                                                                            .white,
                                                                    title:
                                                                        "Please",
                                                                    message:
                                                                        'Refresh Page');
                                                              }
                                                              // await controller
                                                              //     .addGlassViewModel(
                                                              //         model: {
                                                              //       "type":
                                                              //           "${waterTypeList[selectType]}",
                                                              //       "quantity":
                                                              //           _glassController
                                                              //               .text
                                                              //               .trim()
                                                              //     });
                                                              //
                                                              // if (controller
                                                              //         .addGlassApiResponse
                                                              //         .status ==
                                                              //     Status
                                                              //         .COMPLETE) {
                                                              //   Get.back();
                                                              //   GetStorageServices.setUserWater((GetStorageServices.getUserWater() ==
                                                              //               null
                                                              //           ? 0
                                                              //           : GetStorageServices
                                                              //               .getUserWater()) +
                                                              //       int.parse(
                                                              //           _glassController
                                                              //               .text));
                                                              //   _glassController
                                                              //       .clear();
                                                              //   // await getGlassViewModel
                                                              //   //     .getGlassViewModel(
                                                              //   //         isLoading:
                                                              //   //             false);
                                                              //   // if (getGlassViewModel
                                                              //   //         .getGlassApiResponse
                                                              //   //         .status ==
                                                              //   //     Status
                                                              //   //         .COMPLETE) {}
                                                              //   // if (getGlassViewModel
                                                              //   //         .getGlassApiResponse
                                                              //   //         .status ==
                                                              //   //     Status
                                                              //   //         .ERROR) {
                                                              //   //   CommonWidget.getSnackBar(
                                                              //   //       duration:
                                                              //   //           2,
                                                              //   //       color: CommonColor
                                                              //   //           .greenColor
                                                              //   //           .withOpacity(
                                                              //   //               .4),
                                                              //   //       colorText:
                                                              //   //           Colors
                                                              //   //               .white,
                                                              //   //       title:
                                                              //   //           "Please",
                                                              //   //       message:
                                                              //   //           'Refresh Page');
                                                              //   // }
                                                              //
                                                              //   CommonWidget.getSnackBar(
                                                              //       duration: 2,
                                                              //       color: CommonColor
                                                              //           .greenColor
                                                              //           .withOpacity(
                                                              //               .4),
                                                              //       colorText:
                                                              //           Colors
                                                              //               .white,
                                                              //       title:
                                                              //           "Done!",
                                                              //       message:
                                                              //           'added successfully!');
                                                              // }
                                                              // if (controller
                                                              //         .addGlassApiResponse
                                                              //         .status ==
                                                              //     Status
                                                              //         .ERROR) {
                                                              //   _glassController
                                                              //       .clear();
                                                              //   Get.back();
                                                              //
                                                              //   CommonWidget.getSnackBar(
                                                              //       duration: 2,
                                                              //       color: Colors
                                                              //           .red
                                                              //           .shade300,
                                                              //       colorText:
                                                              //           Colors
                                                              //               .white,
                                                              //       title:
                                                              //           "Oops!",
                                                              //       message:
                                                              //           'Something goes wrong please enter bottle again!');
                                                              // }
                                                            } else {
                                                              CommonWidget.getSnackBar(
                                                                  duration: 2,
                                                                  color: Colors
                                                                      .red
                                                                      .shade300,
                                                                  colorText:
                                                                      Colors
                                                                          .white,
                                                                  title:
                                                                      "Oops!",
                                                                  message:
                                                                      'Please enter proper amount of bottle!');
                                                            }
                                                          },
                                                          text: "Add"),
                                                ),
                                                SizedBox(
                                                  height: 6.5.h,
                                                  width: 25.w,
                                                  child:
                                                      CommonWidget.commonButton(
                                                          color: CommonColor
                                                              .greenColor,
                                                          radius: 10,
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          text: "Back"),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                ).then((value) {
                  setState(() {});
                });
              },
            );
          },
        )
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
