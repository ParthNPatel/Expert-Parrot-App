import 'package:dotted_line/dotted_line.dart';
import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/add_heart_rate_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/get_heart_rate_res_model.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:expert_parrot_app/get_storage_services/get_storage_service.dart';
import 'package:expert_parrot_app/view/water_graph_screen.dart';
import 'package:expert_parrot_app/viewModel/get_heart_rate_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../components/common_widget.dart';
import '../constant/color_const.dart';

class HeartRateScreen extends StatefulWidget {
  const HeartRateScreen({Key? key}) : super(key: key);

  @override
  State<HeartRateScreen> createState() => _HeartRateScreenState();
}

class _HeartRateScreenState extends State<HeartRateScreen> {
  TextEditingController _heartRateController = TextEditingController();

  GetHeartRateViewModel getHeartRateViewModel =
      Get.put(GetHeartRateViewModel());

  @override
  void initState() {
    super.initState();
    getHeartRateViewModel.getHeartRateViewModel();
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
              GetBuilder<GetHeartRateViewModel>(
                builder: (controller) {
                  if (controller.getHeartRateApiResponse.status ==
                      Status.LOADING) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: CommonColor.greenColor,
                      ),
                    );
                  }
                  if (controller.getHeartRateApiResponse.status ==
                      Status.COMPLETE) {
                    GetHeartRateResponseModel response =
                        controller.getHeartRateApiResponse.data;

                    final List<ChartData> chartData = List.generate(
                        response.data!.docs!.reversed.toList().length >= 7
                            ? 7
                            : response.data!.docs!.reversed.toList().length,
                        (index) => ChartData(
                            weekDayCounter(response.data!.docs!.reversed
                                .toList()[index]
                                .date!
                                .weekday),
                            response.data!.docs!.reversed
                                .toList()[index]
                                .rate!
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
                        CommonWidget.commonSizedBox(height: 20),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: CommonText.textBoldWight500(
                                text: response.data!.docs!.first.date
                                            .toString()
                                            .split(" ")
                                            .first ==
                                        DateTime.now()
                                            .toString()
                                            .split(" ")
                                            .first
                                    ? TextConst.today
                                    : "",
                                fontSize: 15.sp,
                                color: CommonColor.blackColor1D253C)),
                        CommonWidget.commonSizedBox(height: 20),
                        Row(
                          children: [
                            Image.asset(
                              ImageConst.hartIcon,
                              scale: 4.5,
                            ),
                            response.data!.docs != null &&
                                    response.data!.docs!.isNotEmpty
                                ? CommonText.textBoldWight600(
                                    text: " ${response.data!.docs!.first.rate}",
                                    fontSize: 20.sp,
                                    color: CommonColor.blackColor1D253C)
                                : CommonText.textBoldWight600(
                                    text: ' 0',
                                    fontSize: 20.sp,
                                    color: CommonColor.blackColor1D253C),
                            CommonText.textBoldWight400(
                                text: response.data!.docs!.first.date
                                            .toString()
                                            .split(" ")
                                            .first ==
                                        DateTime.now()
                                            .toString()
                                            .split(" ")
                                            .first
                                    ? " is your Today's heart rate"
                                    : " is your Last heart rate",
                                fontSize: 13.sp,
                                color: CommonColor.gery727272),
                          ],
                        ),
                        CommonWidget.commonSizedBox(height: 12),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: response.data!.docs!.length,
                          itemBuilder: (context, index) {
                            String times = CommonWidget.convertDateForm(
                                response.data!.docs![index].date!)!;
                            return ShowData(times, response, index);
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

  Column ShowData(
    String times,
    GetHeartRateResponseModel response,
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
                text: "${response.data!.docs![index].rate}",
                fontSize: 14.sp,
                color: CommonColor.blackColor1D253C),
            CommonText.textBoldWight500(
              text: ' Heart Rate',
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

/*  Container graphWidget(GetHeartRateResponseModel response) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10.sp),
        width: 90.w,
        height: 220.sp,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 90.w,
              height: 180.sp,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 18.sp, vertical: 10.sp),
                child: LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(enabled: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: List<FlSpot>.generate(
                            response.data!.docs!.length, (int index) {
                          return FlSpot(
                              response.data!.docs![index].date!.weekday
                                  .toDouble(),
                              (response.data!.docs![index].rate!.toDouble()));
                        }),
                        isCurved: true,
                        barWidth: 2,
                        color: CommonColor.greenColor,
                        dotData: FlDotData(
                          show: false,
                        ),
                      ),
                    ],
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: topTitles(response: response.data!.docs!),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 12.sp,
                    width: 12.sp,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: CommonColor.greenColor)),
                SizedBox(width: 5.sp),
                CommonText.textBoldWight500(
                    text: "Achieved",
                    fontSize: 13.sp,
                    color: CommonColor.blackColor0D0D0D),
              ],
            )
          ],
        ));
  }

  SideTitles topTitles({required List response}) => SideTitles(
        getTitlesWidget: (
          double value,
          TitleMeta meta,
        ) {
          var style = DateTime.now().weekday == value
              ? TextStyle(
                  color: CommonColor.greenColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                )
              : TextStyle(
                  color: Color(0xff75729e),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
          String text;

          switch (value.toInt()) {
            case 1:
              text = 'Mon';

              break;
            case 2:
              text = 'Tue';

              break;
            case 3:
              text = 'Wed';

              break;
            case 4:
              text = 'Thu';

              break;
            case 5:
              text = 'Fri';

              break;
            case 6:
              text = 'Sat';

              break;
            case 7:
              text = 'Sun';

              break;
            default:
              return Container();
          }

          return Text(text, style: style, textAlign: TextAlign.center);
        },
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );*/

  Row header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonWidget.commonBackButton(
          onTap: () {
            _heartRateController.clear();
            Get.back();
          },
        ),
        CommonText.textBoldWight500(text: "Heart Rate", fontSize: 18.sp),
        CommonWidget.commonBackButton(
          image: ImageConst.add,
          onTap: () {
            Get.dialog(StatefulBuilder(
              builder: (context, setState) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  width: 300.sp,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonText.textBoldWight500(
                                text: "Enter HeartRate",
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText.textBoldWight400(
                                text: "please enter your Heart Rate",
                                fontSize: 11.sp,
                                color: Color(0xff9B9B9B),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CommonText.textBoldWight500(
                                  text: "Heart Rate",
                                  fontSize: 13.sp,
                                  color: Colors.black),
                              SizedBox(
                                height: 12,
                              ),
                              TextFormField(
                                controller: _heartRateController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xffF8F8F6),
                                    hintText: "Enter your heart rate",
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                              ),
                              SizedBox(height: 23),
                              CommonWidget.commonButton(
                                  color: CommonColor.greenColor,
                                  radius: 10,
                                  onTap: () async {
                                    if (_heartRateController.text.isNotEmpty) {
                                      GetStorageServices.setUserHeartRate(
                                          _heartRateController.text.trim());

                                      await AddHeartRateRepo.addHeartRateRepo(
                                          model: {
                                            "rate":
                                                "${_heartRateController.text.trim()}"
                                          });
                                      _heartRateController.clear();
                                      Get.back();
                                      await getHeartRateViewModel
                                          .getHeartRateViewModel(
                                              isLoading: true);
                                    } else {
                                      CommonWidget.getSnackBar(
                                          color: Colors.red,
                                          duration: 2,
                                          colorText: Colors.white,
                                          title: "Required",
                                          message: 'Please enter heart rate');
                                    }
                                  },
                                  text: "Next")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )).then((value) {
              setState(() {
                _heartRateController.clear();
              });
            });
          },
        )
      ],
    );
  }
}
