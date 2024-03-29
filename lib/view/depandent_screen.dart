import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:expert_parrot_app/view/demo/search_user.dart';
import 'package:expert_parrot_app/view/dependent_water_graph.dart';
import 'package:expert_parrot_app/view/medical_report_screen.dart';
import 'package:expert_parrot_app/viewModel/get_dependent_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../Models/apis/api_response.dart';

class DependentScreen extends StatefulWidget {
  const DependentScreen({Key? key}) : super(key: key);

  @override
  State<DependentScreen> createState() => _DependentScreenState();
}

class _DependentScreenState extends State<DependentScreen> {
  TextEditingController _emailOrMobileController = TextEditingController();
  String? verificationCode;
  DateTime dayOf = DateTime.now();
  List profileList = [
    {
      'name': 'Ellaa',
      'relation': 'Daughter',
      'image': ImageConst.profile1,
    },
    {
      'name': 'Sandy',
      'relation': 'Sis',
      'image': ImageConst.profile2,
    },
    {
      'name': 'John ',
      'relation': 'Dad',
      'image': ImageConst.profile1,
    },
  ];
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
  int currentIndex = 0;

  GetDependentViewModel getDependentViewModel =
      Get.put(GetDependentViewModel());
  @override
  void initState() {
    getDependentViewModel.getDependentViewModel();
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
            CommonWidget.header(
                backOnTap: () {
                  Get.back();
                },
                addOnTap: () {
                  Get.to(() => SearchPage());
                },
                titleText: TextConst.dependentView),
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
                  child: GetBuilder<GetDependentViewModel>(
                    builder: (controller) {
                      if (controller.getDependentApiResponse.status ==
                          Status.LOADING) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: CommonColor.greenColor,
                          ),
                        );
                      }
                      if (controller.getDependentApiResponse.status ==
                          Status.COMPLETE) {
                        var response = controller.getDependentApiResponse.data;
                        log('DAT OF API :- ${response}');
                        if ((response['data']['dependents'] as List).length >
                            0) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  // color: Colors.red,
                                  height: 96.sp,
                                  width: 300.sp,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount:
                                        (response['data']['dependents'] as List)
                                            .length,
                                    itemBuilder: (context, index) {
                                      return horizontalListWidget(
                                          index, response);
                                    },
                                  ),
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    Get.to(() => MedicalReportScreen());
                                  },
                                  child: Image.asset(ImageConst.checkbox)),
                              CommonWidget.commonSizedBox(height: 10),
                              Align(
                                  child: CommonText.textBoldWight500(
                                      text: TextConst.overview,
                                      fontSize: 18.sp,
                                      color: CommonColor.blackColor0D0D0D)),
                              CommonWidget.commonSizedBox(height: 20),
                              GridView.builder(
                                shrinkWrap: true,
                                itemCount: 4,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 16,
                                        crossAxisCount: 2,
                                        childAspectRatio: 2 / 1.5),
                                itemBuilder: (context, index) {
                                  return overViewWidget(
                                    onTap: () {
                                      if (index == 0) {
                                        Get.to(
                                            () => DependentWaterGraphScreen());
                                      }
                                    },
                                    name: overViewData[index]['name'],
                                    image: overViewData[index]['image'],
                                    medGm: index == 0
                                        ? '${response['data']['dependents'][currentIndex]['userId']['water'] ?? 'Not Set'}'
                                        : index == 1
                                            ? '${response['data']['dependents'][currentIndex]['userId']['weight'] ?? 'Not Set'}'
                                            : index == 2
                                                ? '${response['data']['dependents'][currentIndex]['userId']['heartRate'] ?? 'Not Set'}'
                                                : '${response['data']['dependents'][currentIndex]['userId']['bmi'] ?? 'Not Set'}',
                                    type: overViewData[index]
                                        ['name_of_subject'],
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
                                      Image.asset(
                                          'assets/png/report_circle.png',
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
                                                  color: CommonColor
                                                      .blackColor434343),
                                            ],
                                          )),
                                      Positioned(
                                        top: 180,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
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
                                                  image:
                                                      ImageConst.locationIcon),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        } else {
                          return Center(
                            child: CommonText.textBoldWight500(
                                text: 'No Dependent added'),
                          );
                        }
                      }
                      return SizedBox();
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Padding horizontalListWidget(int index, response) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              currentIndex = index;
              setState(() {});
            },
            child: Column(
              children: [
                Container(
                  height: 44.sp,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: index == currentIndex
                              ? CommonColor.greenColor
                              : Colors.transparent,
                          width: index == currentIndex ? 2 : 0),
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://health-app-test.s3.ap-south-1.amazonaws.com/user/${response['data']['dependents'][index]['userId']['userImage']}',
                        ),
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle),
                  width: 44.sp,
                ),
                CommonText.textBoldWight500(
                    text:
                        '${response['data']['dependents'][index]['userId']['name']}',
                    fontSize: 12.sp,
                    color: CommonColor.blackColor1B1B1B),
                CommonText.textBoldWight500(
                  text: '${response['data']['dependents'][index]['relation']}',
                  fontSize: 9.sp,
                  color: CommonColor.gery72777A,
                ),
              ],
            ),
          ),
        ],
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
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
                  fontSize: 13.sp),
              CommonWidget.commonSizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText.textBoldWight600(
                              text: medGm,
                              color: CommonColor.blackColor1D253C,
                              fontSize: 15.sp),
                          CommonText.textBoldWight500(
                              text: type,
                              color:
                                  CommonColor.blackColor1D253C.withOpacity(0.5),
                              fontSize: 9.sp),
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
}
