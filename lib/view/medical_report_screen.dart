import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../components/common_widget.dart';

class MedicalReportScreen extends StatefulWidget {
  const MedicalReportScreen({Key? key}) : super(key: key);

  @override
  State<MedicalReportScreen> createState() => _MedicalReportScreenState();
}

class _MedicalReportScreenState extends State<MedicalReportScreen> {
  int index = 0;
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
  DateTime dayOf = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonWidget.commonBackGround(
        body: Column(
          children: [
            CommonWidget.commonSizedBox(height: 10),
            header(),
            CommonWidget.commonSizedBox(height: 6),
            CommonWidget.dottedLineWidget(),
            CommonWidget.commonSizedBox(height: 23),
            userProfileWidget(),

            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.commonSizedBox(height: 23),
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
                  child: CommonWidget.commonSvgPitcher(image: image)),
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

  Row tabWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            index = 0;
            setState(() {});
          },
          child: Container(
            alignment: Alignment.center,
            width: 100,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
                color: Colors.red,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: index == 0
                        ? [
                            // 45C42C
                            // 06A0BF
                            Color(0xff45C42C),
                            Color(0xff06A0BF),
                          ]
                        : [
                            Colors.white,
                            Colors.white,
                          ]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    topLeft: Radius.circular(8))),
            child: CommonText.textBoldWight500(
                text: 'Taked',
                fontSize: 12.sp,
                color:
                    index == 0 ? Colors.white : CommonColor.blackColor4C4C4C),
          ),
        ),
        GestureDetector(
          onTap: () {
            index = 1;
            setState(() {});
          },
          child: Container(
            width: 100,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
                color: Colors.red,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: index == 1
                        ? [
                            // 45C42C
                            // 06A0BF
                            Color(0xff45C42C),
                            Color(0xff06A0BF),
                          ]
                        : [
                            Colors.white,
                            Colors.white,
                          ]),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
            child: CommonText.textBoldWight500(
                text: 'Not Taken',
                fontSize: 12.sp,
                color:
                    index == 1 ? Colors.white : CommonColor.blackColor4C4C4C),
          ),
        ),
      ],
    );
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
          child: Image.asset(ImageConst.profile2),
        ),
        CommonWidget.commonSizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText.textBoldWight500(
                text: 'Ellaa',
                fontSize: 12.sp,
                color: CommonColor.blackColor1B1B1B),
            CommonText.textBoldWight500(
                text: 'Daughter',
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
          text: "Ella Medical Report",
          fontSize: 16.sp,
          color: CommonColor.blackButtonColor1E232C),
      centerTitle: true,
    );
  }
}
