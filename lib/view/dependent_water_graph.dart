import 'package:dotted_line/dotted_line.dart';
import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/responseModel/get_glass_res_model.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:expert_parrot_app/view/water_graph_screen.dart';
import 'package:expert_parrot_app/viewModel/add_glass_view_model.dart';
import 'package:expert_parrot_app/viewModel/get_glass_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../components/common_widget.dart';
import '../constant/color_const.dart';

class DependentWaterGraphScreen extends StatefulWidget {
  final String userName;
  final String userImg;
  final String userId;
  DependentWaterGraphScreen(
      {Key? key,
      required this.userName,
      required this.userImg,
      required this.userId})
      : super(key: key);

  @override
  State<DependentWaterGraphScreen> createState() =>
      _DependentWaterGraphScreenState();
}

class _DependentWaterGraphScreenState extends State<DependentWaterGraphScreen> {
  AddGlassViewModel addGlassViewModel = Get.put(AddGlassViewModel());
  TextEditingController _glassController = TextEditingController();

  List dayList = ["Sat", 'Fri', 'Thu', 'Wed', 'Tue', 'Mon'];

  int selectType = 0;
  int selectedIndex = 0;
  List days = [];
  int ozGlass = 0;
  int ozBottle = 0;
  int ozLgBottle = 0;

  GetGlassViewModel getGlassViewModel = Get.put(GetGlassViewModel());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGlassViewModel.getGlassViewModel(userId: widget.userId);
  }

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
                            weekDayCounter(response.data!.docs!.reversed
                                .toList()[index]
                                .date!
                                .weekday),
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
                        // graphWidget(response),
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
                            CommonText.textBoldWight600(
                                text:
                                    ' ${(response.data!.docs!.first.glass! * 8) + (response.data!.docs!.first.bottle! * 16) + (response.data!.docs!.first.largeBottle! * 16)}',
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
              ),
              // graphWidget(),
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: 20),
              //   child: CommonText.textBoldWight500(
              //       text: TextConst.quickAddForToady,
              //       fontSize: 18.sp,
              //       color: CommonColor.blackColor0D0D0D),
              // ),
              // waterBottleWidget(),
              // CommonWidget.commonSizedBox(height: 20),
              // Align(
              //     alignment: Alignment.centerLeft,
              //     child: CommonText.textBoldWight500(
              //         text: TextConst.today,
              //         fontSize: 15.sp,
              //         color: CommonColor.blackColor1D253C)),
              // CommonWidget.commonSizedBox(height: 20),
              // Row(
              //   children: [
              //     Image.asset(
              //       ImageConst.glassOfWater,
              //       scale: 4,
              //     ),
              //     CommonText.textBoldWight600(
              //         text: 'O',
              //         fontSize: 18.sp,
              //         color: CommonColor.blackColor1D253C),
              //     CommonText.textBoldWight400(
              //         text: ' fl oz of your ',
              //         fontSize: 13.sp,
              //         color: CommonColor.gery727272),
              //     CommonText.textBoldWight500(
              //         text: '64 ',
              //         fontSize: 16.sp,
              //         color: CommonColor.blackColor1D253C),
              //     CommonText.textBoldWight400(
              //         text: 'fl oz goal',
              //         fontSize: 13.sp,
              //         color: CommonColor.gery727272),
              //   ],
              // ),
              // CommonWidget.commonSizedBox(height: 20),
              // ListView.builder(
              //   shrinkWrap: true,
              //   physics: NeverScrollableScrollPhysics(),
              //   itemCount: dayList.length,
              //   itemBuilder: (context, index) {
              //     return Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         CommonWidget.commonSvgPitcher(
              //           image: 'assets/svg/Line 5.svg',
              //         ),
              //         Row(
              //           children: [
              //             SizedBox(
              //               width: 55.sp,
              //               child: Padding(
              //                 padding: EdgeInsets.symmetric(
              //                     horizontal: 10, vertical: 10),
              //                 child: CommonText.textBoldWight500(
              //                     text: dayList[index],
              //                     fontSize: 15.sp,
              //                     color: CommonColor.blackColor1D253C),
              //               ),
              //             ),
              //             CommonWidget.commonSizedBox(width: 20),
              //             CommonText.textBoldWight500(
              //                 text: '0 ',
              //                 fontSize: 15.sp,
              //                 color: CommonColor.blackColor1D253C),
              //             CommonText.textBoldWight500(
              //                 text: 'fl oz',
              //                 fontSize: 15.sp,
              //                 color: CommonColor.gery696969)
              //           ],
              //         ),
              //       ],
              //     );
              //   },
              // ),
              // CommonWidget.commonSizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  // Container graphWidget() {
  //   return Container(
  //       width: Get.width,
  //       height: 210,
  //       decoration: BoxDecoration(
  //           color: Colors.white, borderRadius: BorderRadius.circular(12)),
  //       //height: 500,
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Image.asset(
  //           'assets/png/fl_chart.png',
  //           fit: BoxFit.contain,
  //         ),
  //       ));
  // }

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

  // Container graphWidget(GetGlassResponseModel response) {
  //   return Container(
  //       padding: EdgeInsets.symmetric(vertical: 10.sp),
  //       width: 90.w,
  //       height: 220.sp,
  //       decoration: BoxDecoration(
  //           color: Colors.white, borderRadius: BorderRadius.circular(16)),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           SizedBox(
  //             width: 90.w,
  //             height: 180.sp,
  //             child: Padding(
  //               padding:
  //                   EdgeInsets.symmetric(horizontal: 18.sp, vertical: 10.sp),
  //               child: LineChart(
  //                 LineChartData(
  //                   lineTouchData: LineTouchData(enabled: true),
  //                   lineBarsData: [
  //                     LineChartBarData(
  //                       spots: List<FlSpot>.generate(
  //                           response.data!.docs!.length, (int index) {
  //                         return FlSpot(
  //                             response.data!.docs![index].date!.weekday
  //                                 .toDouble(),
  //                             selectedIndex == 0
  //                                 ? (response.data!.docs![index].glass! * 8)
  //                                 : selectedIndex == 1
  //                                     ? (response.data!.docs![index].bottle! *
  //                                         16)
  //                                     : (response
  //                                             .data!.docs![index].largeBottle! *
  //                                         16));
  //                       }),
  //
  //                       /*   spots: List<FlSpot>.generate(7, (int index) {
  //                         return FlSpot(
  //                             index + 1,
  //                             index % 2 == 0
  //                                 ? 4 + index.toDouble()
  //                                 : 4 - index.toDouble());
  //                       }),*/
  //                       // spots: [
  //                       //   FlSpot(4, 2),
  //                       //   FlSpot(5, 2),
  //                       //   FlSpot(6, 3),
  //                       //   FlSpot(7, 3),
  //                       //   FlSpot(1, 3),
  //                       //   FlSpot(2, 1),
  //                       //   FlSpot(3, 3),
  //                       // ],
  //
  //                       isCurved: true,
  //                       barWidth: 2,
  //                       color: CommonColor.greenColor,
  //                       dotData: FlDotData(
  //                         show: false,
  //                       ),
  //                     ),
  //                   ],
  //                   borderData: FlBorderData(show: false),
  //                   gridData: FlGridData(show: false),
  //                   titlesData: FlTitlesData(
  //                     bottomTitles: AxisTitles(
  //                       sideTitles: SideTitles(showTitles: false),
  //                     ),
  //                     rightTitles: AxisTitles(
  //                       sideTitles: SideTitles(showTitles: false),
  //                     ),
  //                     topTitles: AxisTitles(
  //                       sideTitles: topTitles(response: response.data!.docs!),
  //                     ),
  //                     leftTitles: AxisTitles(
  //                       sideTitles: SideTitles(showTitles: false),
  //                     ),
  //                   ),
  //                   // titlesData: FlTitlesData(
  //                   //   bottomTitles: SideTitles(
  //                   //       showTitles: true,
  //                   //       reservedSize: 5,
  //                   //       // textStyle: yearTextStyle,
  //                   //       getTitles: (value) {
  //                   //         switch (value.toInt()) {
  //                   //           case 0:
  //                   //             return '2016';
  //                   //           case 1:
  //                   //             return '2017';
  //                   //
  //                   //           default:
  //                   //             return '';
  //                   //         }
  //                   //       }),
  //                   //   leftTitles: SideTitles(
  //                   //     showTitles: true,
  //                   //     getTitles: (value) {
  //                   //       return '\$ ${value + 100}';
  //                   //     },
  //                   //   ),
  //                   // ),
  //                   // axisTitleData: FlAxisTitleData(
  //                   //     leftTitle: AxisTitle(
  //                   //         showTitle: true, titleText: 'Value', margin: 10),
  //                   //     bottomTitle: AxisTitle(
  //                   //         showTitle: true,
  //                   //         margin: 10,
  //                   //         titleText: 'Year',
  //                   //         textStyle: yearTextStyle,
  //                   //         textAlign: TextAlign.right)),
  //                   // gridData: FlGridData(
  //                   //   show: true,
  //                   //   checkToShowHorizontalLine: (double value) {
  //                   //     return value == 1 || value == 2 || value == 3 || value == 4;
  //                   //   },
  //                   // ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Container(
  //                   height: 12.sp,
  //                   width: 12.sp,
  //                   decoration: BoxDecoration(
  //                       shape: BoxShape.circle, color: CommonColor.greenColor)),
  //               SizedBox(width: 5.sp),
  //               CommonText.textBoldWight500(
  //                   text: "Achieved",
  //                   fontSize: 13.sp,
  //                   color: CommonColor.blackColor0D0D0D),
  //             ],
  //           )
  //         ],
  //       ));
  // }

  // SideTitles topTitles({required List<Doc> response}) => SideTitles(
  //       getTitlesWidget: (
  //         double value,
  //         TitleMeta meta,
  //       ) {
  //         var style = DateTime.now().weekday == value
  //             ? TextStyle(
  //                 color: CommonColor.greenColor,
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 12,
  //               )
  //             : TextStyle(
  //                 color: Color(0xff75729e),
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 12,
  //               );
  //         String text;
  //
  //         // if (response[value.toInt() - 1].date!.weekday == 1) {
  //         //   text = 'Sun';
  //         // } else if (response[value.toInt() - 1].date!.weekday == 2) {
  //         //   text = 'Mon';
  //         // } else if (response[value.toInt() - 1].date!.weekday == 3) {
  //         //   text = 'Tue';
  //         // } else if (response[value.toInt() - 1].date!.weekday == 4) {
  //         //   text = 'Wed';
  //         // } else if (response[value.toInt() - 1].date!.weekday == 5) {
  //         //   text = 'Thu';
  //         // } else if (response[value.toInt() - 1].date!.weekday == 6) {
  //         //   text = 'Fri';
  //         // } else {
  //         //   text = 'Sat';
  //         // }
  //
  //         switch (value.toInt()) {
  //           case 1:
  //             text = 'Sun';
  //
  //             break;
  //           case 2:
  //             text = 'Mon';
  //
  //             break;
  //           case 3:
  //             text = 'Tue';
  //
  //             break;
  //           case 4:
  //             text = 'Wed';
  //
  //             break;
  //           case 5:
  //             text = 'Thu';
  //
  //             break;
  //           case 6:
  //             text = 'Fri';
  //
  //             break;
  //           case 7:
  //             text = 'Sat';
  //
  //             break;
  //           default:
  //             return Container();
  //         }
  //
  //         return Text(text, style: style, textAlign: TextAlign.center);
  //       },
  //       showTitles: true,
  //       interval: 1,
  //       reservedSize: 40,
  //     );

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
                            typeOfBottle:
                                '${response.data!.docs!.first.glass} Glass');
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
                            typeOfBottle:
                                '${response.data!.docs!.first.bottle} Bottle');
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
                            typeOfBottle:
                                '${response.data!.docs!.first.largeBottle} Lg Bottle');
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

  // Container bottleWidget(
  //     {required String image,
  //     required String typeOfBottle,
  //     required String oz}) {
  //   return Container(
  //       padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(14), color: Colors.white),
  //       child: Column(
  //         children: [
  //           SizedBox(height: 40, child: Image.asset(image)),
  //           CommonWidget.commonSizedBox(height: 20),
  //           CommonText.textBoldWight500(
  //               text: typeOfBottle,
  //               fontSize: 15.sp,
  //               color: CommonColor.blackColor1D253C),
  //           CommonText.textBoldWight400(
  //               text: oz, fontSize: 12.sp, color: CommonColor.gery727272),
  //         ],
  //       ));
  // }

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
            text: "${widget.userName.capitalizeFirst}'s Water Report",
            fontSize: 18.sp),
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
      ],
    );
  }
}
