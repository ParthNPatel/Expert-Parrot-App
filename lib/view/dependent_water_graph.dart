import 'package:dotted_line/dotted_line.dart';
import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:expert_parrot_app/viewModel/add_glass_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../components/common_widget.dart';
import '../constant/color_const.dart';

class DependentWaterGraphScreen extends StatefulWidget {
  const DependentWaterGraphScreen({Key? key}) : super(key: key);

  @override
  State<DependentWaterGraphScreen> createState() =>
      _DependentWaterGraphScreenState();
}

class _DependentWaterGraphScreenState extends State<DependentWaterGraphScreen> {
  AddGlassViewModel addGlassViewModel = Get.put(AddGlassViewModel());
  TextEditingController _glassController = TextEditingController();

  List dayList = ["Sat", 'Fri', 'Thu', 'Wed', 'Tue', 'Mon'];
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
              graphWidget(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
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
                    scale: 4,
                  ),
                  CommonText.textBoldWight600(
                      text: 'O',
                      fontSize: 18.sp,
                      color: CommonColor.blackColor1D253C),
                  CommonText.textBoldWight400(
                      text: ' fl oz of your ',
                      fontSize: 13.sp,
                      color: CommonColor.gery727272),
                  CommonText.textBoldWight500(
                      text: '64 ',
                      fontSize: 16.sp,
                      color: CommonColor.blackColor1D253C),
                  CommonText.textBoldWight400(
                      text: 'fl oz goal',
                      fontSize: 13.sp,
                      color: CommonColor.gery727272),
                ],
              ),
              CommonWidget.commonSizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: dayList.length,
                itemBuilder: (context, index) {
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: CommonText.textBoldWight500(
                                  text: dayList[index],
                                  fontSize: 15.sp,
                                  color: CommonColor.blackColor1D253C),
                            ),
                          ),
                          CommonWidget.commonSizedBox(width: 20),
                          CommonText.textBoldWight500(
                              text: '0 ',
                              fontSize: 15.sp,
                              color: CommonColor.blackColor1D253C),
                          CommonText.textBoldWight500(
                              text: 'fl oz',
                              fontSize: 15.sp,
                              color: CommonColor.gery696969)
                        ],
                      ),
                    ],
                  );
                },
              ),
              CommonWidget.commonSizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Container graphWidget() {
    return Container(
        width: Get.width,
        height: 210,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        //height: 500,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/png/fl_chart.png',
            fit: BoxFit.contain,
          ),
        ));
  }

  GetBuilder<AddGlassViewModel> waterBottleWidget() {
    return GetBuilder<AddGlassViewModel>(builder: (controller) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    controller.index = 0;
                  });

                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SizedBox(
                        height: 175.sp,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CommonText.textBoldWight500(
                                      text: "Enter Glasses",
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
                                // TextField(
                                //   controller: relation,
                                //   decoration: InputDecoration(
                                //     border: OutlineInputBorder(),
                                //     focusedBorder: OutlineInputBorder(),
                                //     enabledBorder: OutlineInputBorder(),
                                //     hintText: 'Relation',
                                //   ),
                                // ),

                                // Container(
                                //   height: 30.sp,
                                //   width: 100.sp,
                                //   color: Colors.grey.shade50,
                                //   child: Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         Container(
                                //           height: 30.sp,
                                //           width: 30.sp,
                                //           decoration: BoxDecoration(
                                //               border: Border.all(
                                //                 color: Colors.grey
                                //                     .withOpacity(0.3),
                                //               ),
                                //               boxShadow: [
                                //                 BoxShadow(
                                //                     color: Colors.black26,
                                //                     spreadRadius: 1,
                                //                     blurRadius: 1,
                                //                     offset: Offset(.25, .5))
                                //               ],
                                //               color: Colors.white,
                                //               borderRadius:
                                //                   BorderRadius.circular(10)),
                                //           child: IconButton(
                                //             icon:
                                //                 Icon(Icons.remove, size: 15.sp),
                                //             onPressed: () {
                                //               controller.glassCounter(
                                //                   isAdding: false);
                                //             },
                                //           ),
                                //         ),
                                //         CommonText.textBoldWight500(
                                //             text: "${controller.glass}"),
                                //         Container(
                                //           height: 30.sp,
                                //           width: 30.sp,
                                //           decoration: BoxDecoration(
                                //               border: Border.all(
                                //                 color: Colors.grey
                                //                     .withOpacity(0.3),
                                //               ),
                                //               boxShadow: [
                                //                 BoxShadow(
                                //                     color: Colors.black26,
                                //                     spreadRadius: 1,
                                //                     blurRadius: 1,
                                //                     offset: Offset(.5, .25))
                                //               ],
                                //               color: Colors.white,
                                //               borderRadius:
                                //                   BorderRadius.circular(10)),
                                //           child: IconButton(
                                //             icon: Icon(Icons.add, size: 15.sp),
                                //             onPressed: () {
                                //               controller.glassCounter(
                                //                   isAdding: true);
                                //             },
                                //           ),
                                //         )
                                //       ]),
                                // ),

                                TextFormField(
                                  controller: _glassController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xffF8F8F6),
                                      hintText: "Enter count of glasses",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(20),
                                      )),
                                ),

                                SizedBox(height: 20.sp),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 20.sp),
                                    SizedBox(
                                      height: 6.5.h,
                                      width: 25.w,
                                      child: CommonWidget.commonButton(
                                          color: CommonColor.greenColor,
                                          radius: 10,
                                          onTap: () async {
                                            if (_glassController
                                                .text.isNotEmpty) {
                                              await controller
                                                  .addGlassViewModel(model: {
                                                "type": "glass",
                                                "quantity":
                                                    _glassController.text.trim()
                                              });

                                              if (controller.addGlassApiResponse
                                                      .status ==
                                                  Status.COMPLETE) {
                                                _glassController.clear();
                                                Get.back();

                                                CommonWidget.getSnackBar(
                                                    duration: 2,
                                                    color: CommonColor
                                                        .greenColor
                                                        .withOpacity(.4),
                                                    colorText: Colors.white,
                                                    title: "Done!",
                                                    message:
                                                        'Glass added successfully!');
                                              }
                                              if (controller.addGlassApiResponse
                                                      .status ==
                                                  Status.ERROR) {
                                                _glassController.clear();
                                                Get.back();

                                                CommonWidget.getSnackBar(
                                                    duration: 2,
                                                    color: Colors.red.shade300,
                                                    colorText: Colors.white,
                                                    title: "Oops!",
                                                    message:
                                                        'Something goes wrong please enter glass again!');
                                              }
                                            } else {
                                              CommonWidget.getSnackBar(
                                                  duration: 2,
                                                  color: Colors.red.shade300,
                                                  colorText: Colors.white,
                                                  title: "Oops!",
                                                  message:
                                                      'Please enter proper amount of glass!');
                                            }
                                          },
                                          // onTap: () async {
                                          //   await sendReqViewModel
                                          //       .sendReqViewModel(model: {
                                          //     "userId":
                                          //         "${getSearchRes.data![index].id}",
                                          //     "relation":
                                          //         "${relation.text.trim()}"
                                          //   });
                                          //   relation.clear();
                                          //
                                          //   if (sendReqViewModel
                                          //           .sendReqApiResponse.status ==
                                          //       Status.COMPLETE) {
                                          //     Get.back();
                                          //     CommonWidget.getSnackBar(
                                          //       message:
                                          //           'Request send successfully',
                                          //       title: 'Successfully',
                                          //       duration: 2,
                                          //       color: Colors.green,
                                          //     );
                                          //   }
                                          //   if (sendReqViewModel
                                          //           .sendReqApiResponse.status ==
                                          //       Status.ERROR) {
                                          //     Get.back();
                                          //     CommonWidget.getSnackBar(
                                          //       message: 'Try Again...',
                                          //       title: 'Failed',
                                          //       duration: 2,
                                          //       color: Colors.red,
                                          //     );
                                          //   }
                                          // },
                                          text: "Send"),
                                    ),
                                    SizedBox(
                                      height: 6.5.h,
                                      width: 25.w,
                                      child: CommonWidget.commonButton(
                                          color: CommonColor.greenColor,
                                          radius: 10,
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          text: "Back"),
                                    )
                                  ],
                                ),
                              ]),
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: controller.index == 0
                              ? CommonColor.greenColor
                              : Colors.transparent)),
                  child: bottleWidget(
                      oz: '(8 fl oz)',
                      image: ImageConst.glassOfWater,
                      typeOfBottle: '1 Glass'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    controller.index = 1;
                  });

                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SizedBox(
                        height: 175.sp,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CommonText.textBoldWight500(
                                      text: "Enter Bottle",
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
                                TextFormField(
                                  controller: _glassController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xffF8F8F6),
                                      hintText: "Enter count of bottles",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(20),
                                      )),
                                ),
                                SizedBox(height: 20.sp),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 20.sp),
                                    SizedBox(
                                      height: 6.5.h,
                                      width: 25.w,
                                      child: CommonWidget.commonButton(
                                          color: CommonColor.greenColor,
                                          radius: 10,
                                          onTap: () async {
                                            if (_glassController
                                                .text.isNotEmpty) {
                                              await controller
                                                  .addGlassViewModel(model: {
                                                "type": "Bottle",
                                                "quantity":
                                                    _glassController.text.trim()
                                              });

                                              if (controller.addGlassApiResponse
                                                      .status ==
                                                  Status.COMPLETE) {
                                                _glassController.clear();
                                                Get.back();

                                                CommonWidget.getSnackBar(
                                                    duration: 2,
                                                    color: CommonColor
                                                        .greenColor
                                                        .withOpacity(.4),
                                                    colorText: Colors.white,
                                                    title: "Done!",
                                                    message:
                                                        'Bottle added successfully!');
                                              }
                                              if (controller.addGlassApiResponse
                                                      .status ==
                                                  Status.ERROR) {
                                                _glassController.clear();
                                                Get.back();

                                                CommonWidget.getSnackBar(
                                                    duration: 2,
                                                    color: Colors.red.shade300,
                                                    colorText: Colors.white,
                                                    title: "Oops!",
                                                    message:
                                                        'Something goes wrong please enter bottle again!');
                                              }
                                            } else {
                                              CommonWidget.getSnackBar(
                                                  duration: 2,
                                                  color: Colors.red.shade300,
                                                  colorText: Colors.white,
                                                  title: "Oops!",
                                                  message:
                                                      'Please enter proper amount of bottle!');
                                            }
                                          },
                                          text: "Send"),
                                    ),
                                    SizedBox(
                                      height: 6.5.h,
                                      width: 25.w,
                                      child: CommonWidget.commonButton(
                                          color: CommonColor.greenColor,
                                          radius: 10,
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          text: "Back"),
                                    )
                                  ],
                                ),
                              ]),
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: controller.index == 1
                              ? CommonColor.greenColor
                              : Colors.transparent)),
                  child: bottleWidget(
                      oz: '(16 fl oz)',
                      image: ImageConst.water1Icon,
                      typeOfBottle: '1 Bottle'),
                ),
              ),

              GestureDetector(
                onTap: () {
                  setState(() {
                    controller.index = 2;
                  });

                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SizedBox(
                        height: 175.sp,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CommonText.textBoldWight500(
                                      text: "Enter Lg Bottle",
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
                                TextFormField(
                                  controller: _glassController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xffF8F8F6),
                                      hintText: "Enter count of glasses",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(20),
                                      )),
                                ),
                                SizedBox(height: 20.sp),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 20.sp),
                                    SizedBox(
                                      height: 6.5.h,
                                      width: 25.w,
                                      child: CommonWidget.commonButton(
                                          color: CommonColor.greenColor,
                                          radius: 10,
                                          onTap: () async {
                                            if (_glassController
                                                .text.isNotEmpty) {
                                              await controller
                                                  .addGlassViewModel(model: {
                                                "type": "Lg Bottle",
                                                "quantity":
                                                    _glassController.text.trim()
                                              });

                                              if (controller.addGlassApiResponse
                                                      .status ==
                                                  Status.COMPLETE) {
                                                _glassController.clear();
                                                Get.back();

                                                CommonWidget.getSnackBar(
                                                    duration: 2,
                                                    color: CommonColor
                                                        .greenColor
                                                        .withOpacity(.4),
                                                    colorText: Colors.white,
                                                    title: "Done!",
                                                    message:
                                                        'Lg Bottle added successfully!');
                                              }
                                              if (controller.addGlassApiResponse
                                                      .status ==
                                                  Status.ERROR) {
                                                _glassController.clear();
                                                Get.back();

                                                CommonWidget.getSnackBar(
                                                    duration: 2,
                                                    color: Colors.red.shade300,
                                                    colorText: Colors.white,
                                                    title: "Oops!",
                                                    message:
                                                        'Something goes wrong please enter Lg Bottle again!');
                                              }
                                            } else {
                                              CommonWidget.getSnackBar(
                                                  duration: 2,
                                                  color: Colors.red.shade300,
                                                  colorText: Colors.white,
                                                  title: "Oops!",
                                                  message:
                                                      'Please enter proper amount of Lg Bottle!');
                                            }
                                          },
                                          // onTap: () async {
                                          //   await sendReqViewModel
                                          //       .sendReqViewModel(model: {
                                          //     "userId":
                                          //         "${getSearchRes.data![index].id}",
                                          //     "relation":
                                          //         "${relation.text.trim()}"
                                          //   });
                                          //   relation.clear();
                                          //
                                          //   if (sendReqViewModel
                                          //           .sendReqApiResponse.status ==
                                          //       Status.COMPLETE) {
                                          //     Get.back();
                                          //     CommonWidget.getSnackBar(
                                          //       message:
                                          //           'Request send successfully',
                                          //       title: 'Successfully',
                                          //       duration: 2,
                                          //       color: Colors.green,
                                          //     );
                                          //   }
                                          //   if (sendReqViewModel
                                          //           .sendReqApiResponse.status ==
                                          //       Status.ERROR) {
                                          //     Get.back();
                                          //     CommonWidget.getSnackBar(
                                          //       message: 'Try Again...',
                                          //       title: 'Failed',
                                          //       duration: 2,
                                          //       color: Colors.red,
                                          //     );
                                          //   }
                                          // },
                                          text: "Send"),
                                    ),
                                    SizedBox(
                                      height: 6.5.h,
                                      width: 25.w,
                                      child: CommonWidget.commonButton(
                                          color: CommonColor.greenColor,
                                          radius: 10,
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          text: "Back"),
                                    )
                                  ],
                                ),
                              ]),
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: controller.index == 2
                              ? CommonColor.greenColor
                              : Colors.transparent)),
                  child: bottleWidget(
                      oz: '(16 fl oz)',
                      image: ImageConst.plasticBottle,
                      typeOfBottle: '1 Lg Bottle'),
                ),
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
    });
  }

  Container bottleWidget(
      {required String image,
      required String typeOfBottle,
      required String oz}) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14), color: Colors.white),
        child: Column(
          children: [
            SizedBox(height: 40, child: Image.asset(image)),
            CommonWidget.commonSizedBox(height: 20),
            CommonText.textBoldWight500(
                text: typeOfBottle,
                fontSize: 15.sp,
                color: CommonColor.blackColor1D253C),
            CommonText.textBoldWight400(
                text: oz, fontSize: 12.sp, color: CommonColor.gery727272),
          ],
        ));
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
        CommonText.textBoldWight500(text: "Ella Water Report", fontSize: 18.sp),
        Container(
          height: 44.sp,
          decoration: BoxDecoration(
              border: Border.all(color: CommonColor.greenColor, width: 2),
              shape: BoxShape.circle),
          width: 44.sp,
          child: Image.asset(ImageConst.profile1),
        ),
      ],
    );
  }
}
