import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/delete_medicine_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/date_record_medicine_res_model.dart';
import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:expert_parrot_app/viewModel/add_record_medicine_view_model.dart';
import 'package:expert_parrot_app/viewModel/date_medicine_record_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../viewModel/user_data_view_model.dart';

class ViewAllMedScheduleScreen extends StatefulWidget {
  DateTime date;
  ViewAllMedScheduleScreen({Key? key, required this.date}) : super(key: key);

  @override
  State<ViewAllMedScheduleScreen> createState() =>
      _ViewAllMedScheduleScreenState();
}

class _ViewAllMedScheduleScreenState extends State<ViewAllMedScheduleScreen> {
  List selectedDose = [];
  List completedDoses = [];
  UserDataViewModel userDataViewModel = Get.put(UserDataViewModel());
  DateTime dayOf = DateTime.now();

  AddRecordMedicineViewModel addRecordMedicineViewModel =
      Get.put(AddRecordMedicineViewModel());
  DateMedicineRecordViewModel dateMedicineRecordViewModel =
      Get.put(DateMedicineRecordViewModel());

  @override
  void initState() {
    dateMedicineRecordViewModel
        .dateMedicineRecordViewModel(model: {"date": "${widget.date}"});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonWidget.commonBackGround(
          body: Column(
        children: [
          header(),
          SizedBox(height: 13),
          CommonWidget.dottedLineWidget(),
          SizedBox(height: 13),
          GetBuilder<DateMedicineRecordViewModel>(builder: (controller) {
            if (controller.dateMedicineRecordApiResponse.status ==
                Status.LOADING) {
              return Center(
                  child:
                      CircularProgressIndicator(color: CommonColor.greenColor));
            }
            if (controller.dateMedicineRecordApiResponse.status ==
                Status.COMPLETE) {
              DateMedicineRecordResponseModel response =
                  controller.dateMedicineRecordApiResponse.data;

              return Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: response.data!.length,
                  itemBuilder: (context, index) {
                    try {
                      return medDetailsWidget(
                          onTap: () async {
                            bool isOpen = false;
                            List tackDataPass = [];
                            try {
                              int dose = int.parse(
                                  response.data![index].totalTimes.toString());
                              if (dose == response.data![index].doses!.length) {
                                isOpen = false;
                              } else if (dose == 1 &&
                                  response.data![index].doses!.length == 0) {
                                isOpen = true;
                                tackDataPass = [1];
                              } else if (dose == 2 &&
                                  response.data![index].doses!.length == 1) {
                                isOpen = true;
                                if (response.data![index].doses!.contains(1)) {
                                  tackDataPass = [2];
                                } else {
                                  tackDataPass = [1];
                                }
                              } else if (dose == 3 &&
                                  response.data![index].doses!.length == 2) {
                                isOpen = true;
                                if (response.data![index].doses!.contains(1) &&
                                    response.data![index].doses!.contains(2)) {
                                  tackDataPass = [3];
                                } else if (response.data![index].doses!
                                        .contains(1) &&
                                    response.data![index].doses!.contains(3)) {
                                  tackDataPass = [2];
                                } else {
                                  tackDataPass = [1];
                                }
                              } else {
                                isOpen = false;
                              }
                            } catch (e) {}
                            if (isOpen) {
                              var _req = {
                                "medicineId": "${response.data![index].sId}",
                                "doses": tackDataPass,
                              };

                              print('====== > ${_req}');

                              await addRecordMedicineViewModel
                                  .addRecordMedicineViewModel(model: _req);

                              if (addRecordMedicineViewModel
                                      .addRecordMedicineApiResponse.status ==
                                  Status.COMPLETE) {
                                dateMedicineRecordViewModel
                                    .dateMedicineRecordViewModel(
                                        isLoading: false,
                                        model: {"date": "${dayOf}"});
                                selectedDose.clear();
                                userDataViewModel.userDataViewModel();
                                dateMedicineRecordViewModel
                                    .dateMedicineRecordViewModel(
                                        model: {"date": "${dayOf}"});
                                CommonWidget.getSnackBar(
                                    duration: 2,
                                    color:
                                        CommonColor.greenColor.withOpacity(.4),
                                    colorText: Colors.white,
                                    title: "Done!",
                                    message: 'Record Updated!');
                              }
                              if (addRecordMedicineViewModel
                                      .addRecordMedicineApiResponse.status ==
                                  Status.ERROR) {
                                selectedDose.clear();

                                CommonWidget.getSnackBar(
                                    duration: 2,
                                    color: Colors.red.withOpacity(.4),
                                    colorText: Colors.white,
                                    title: "Failed!",
                                    message: 'Record not updated try again!');
                              }
                            } else {
                              Get.dialog(
                                await takenMedicineDialog(
                                  totalTimes:
                                      "${response.data![index].totalTimes}",
                                  takenDoses: response.data![index].doses,
                                  medId: "${response.data![index].sId}",
                                ),
                              ).then(
                                (value) {
                                  setState(
                                    () {
                                      completedDoses.clear();
                                      selectedDose.clear();
                                    },
                                  );
                                },
                              );
                            }
                          },
                          medId: "${response.data![index].sId}",
                          totalTimes: "${response.data![index].totalTimes}",
                          takenDoses: response.data![index].doses,
                          image: response.data![index].appearance!
                                      .toLowerCase() ==
                                  'pills'
                              ? ImageConst.med3Icon
                              : response.data![index].appearance!.toLowerCase() ==
                                      'gel'
                                  ? ImageConst.med1Icon
                                  : response.data![index].appearance!
                                              .toLowerCase() ==
                                          'syrup'
                                      ? ImageConst.med2Icon
                                      : ImageConst.med2Icon,
                          medName: '${response.data![index].name}',
                          medGm: '${response.data![index].strength}',
                          iconColor: response.data![index].appearance!
                                      .toLowerCase() ==
                                  'pills'
                              ? Color(0xff21D200)
                              : response.data![index].appearance!.toLowerCase() ==
                                      'gel'
                                  ? Color(0xffFFDD2C)
                                  : response.data![index].appearance!
                                              .toLowerCase() ==
                                          'syrup'
                                      ? Color(0xff9255E5)
                                      : Color(0xff9255E5),
                          timeOfDay:
                              '${response.data![index].totalTimes} pills ${response.data![index].frequency}',
                          color: response.data![index].appearance!
                                      .toLowerCase() ==
                                  'pills'
                              ? Color.fromRGBO(69, 196, 44, 0.13)
                              : response.data![index].appearance!.toLowerCase() ==
                                      'gel'
                                  ? Color.fromRGBO(193, 196, 44, 0.13)
                                  : response.data![index].appearance!
                                              .toLowerCase() ==
                                          'syrup'
                                      ? Color.fromRGBO(111, 44, 196, 0.13)
                                      : Color.fromRGBO(111, 44, 196, 0.13));
                    } catch (e) {
                      return SizedBox();
                    }
                  },
                ),
              );
            } else
              return SizedBox();
          }),
        ],
      )),
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
        Spacer(),
        CommonText.textBoldWight500(
            text: widget.date.toString().split(" ").first ==
                    DateTime.now().toString().split(" ").first
                ? "All Today's Meds"
                : "All ${CommonWidget.convertDateForm(widget.date)!}'s Meds",
            fontSize: 18.sp),
        SizedBox(
          width: 11.w,
        ),
        Spacer(),
      ],
    );
  }

  Widget medDetailsWidget(
      {required String medName,
      required String medGm,
      required String medId,
      List? takenDoses,
      required String totalTimes,
      required String timeOfDay,
      required Color color,
      required Color iconColor,
      required VoidCallback onTap,
      required String image}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          // height: 16.h,

          padding: EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 16,
          ),
          decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              Container(
                  height: 30.sp,
                  padding: EdgeInsets.all(8),
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
                              fontSize: 15.sp),
                          PopupMenuButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.more_vert,
                              color: CommonColor.geryB4B4B4,
                            ),
                            onSelected: (value) async {
                              if (value == 'mark') {
                                bool isOpen = false;
                                List tackDataPass = [];
                                try {
                                  //[1]  [1,2]   [1,2,3]

                                  int dose = int.parse(totalTimes);
                                  if (dose == takenDoses!.length) {
                                    isOpen = false;
                                  } else if (dose == 1 &&
                                      takenDoses.length == 0) {
                                    isOpen = true;
                                    tackDataPass = [1];
                                  } else if (dose == 2 &&
                                      takenDoses.length == 1) {
                                    isOpen = true;
                                    if (takenDoses.contains(1)) {
                                      tackDataPass = [2];
                                    } else {
                                      tackDataPass = [1];
                                    }
                                  } else if (dose == 3 &&
                                      takenDoses.length == 2) {
                                    isOpen = true;
                                    if (takenDoses.contains(1) &&
                                        takenDoses.contains(2)) {
                                      tackDataPass = [3];
                                    } else if (takenDoses.contains(1) &&
                                        takenDoses.contains(3)) {
                                      tackDataPass = [2];
                                    } else {
                                      tackDataPass = [1];
                                    }
                                  } else {
                                    isOpen = false;
                                  }
                                  print('Total dose : ${totalTimes}');
                                  print('taken dose : ${takenDoses}');
                                  print('select dose: ${tackDataPass}');
                                  print('is open    : ${isOpen}');
                                } catch (e) {}
                                if (isOpen) {
                                  var _req = {
                                    "medicineId": "${medId}",
                                    "doses": tackDataPass,
                                  };

                                  print('====== > ${_req}');

                                  await addRecordMedicineViewModel
                                      .addRecordMedicineViewModel(model: _req);

                                  if (addRecordMedicineViewModel
                                          .addRecordMedicineApiResponse
                                          .status ==
                                      Status.COMPLETE) {
                                    dateMedicineRecordViewModel
                                        .dateMedicineRecordViewModel(
                                            isLoading: false,
                                            model: {"date": "${dayOf}"});
                                    selectedDose.clear();
                                    userDataViewModel.userDataViewModel();
                                    dateMedicineRecordViewModel
                                        .dateMedicineRecordViewModel(
                                            model: {"date": "${dayOf}"});
                                    CommonWidget.getSnackBar(
                                        duration: 2,
                                        color: CommonColor.greenColor
                                            .withOpacity(.4),
                                        colorText: Colors.white,
                                        title: "Done!",
                                        message: 'Record Updated!');
                                  }
                                  if (addRecordMedicineViewModel
                                          .addRecordMedicineApiResponse
                                          .status ==
                                      Status.ERROR) {
                                    selectedDose.clear();

                                    CommonWidget.getSnackBar(
                                        duration: 2,
                                        color: Colors.red.withOpacity(.4),
                                        colorText: Colors.white,
                                        title: "Failed!",
                                        message:
                                            'Record not updated try again!');
                                  }
                                } else {
                                  print('opennenenennenene $totalTimes');
                                  print('opennenenennenene $takenDoses');

                                  return Get.dialog(
                                    // barrierDismissible: false,
                                    await takenMedicineDialog(
                                        totalTimes: totalTimes,
                                        takenDoses: takenDoses,
                                        medId: medId),
                                  ).then(
                                    (value) {
                                      setState(
                                        () {
                                          completedDoses.clear();
                                          selectedDose.clear();
                                        },
                                      );
                                    },
                                  );
                                }
                              }
                            },
                            itemBuilder: (context) {
                              if (widget.date.toString().split(" ").first ==
                                  DateTime.now().toString().split(" ").first) {
                                return [
                                  PopupMenuItem(
                                    onTap: () async {},
                                    child: Text("Mark as Taken"),
                                    value: "mark",
                                  ),
                                  PopupMenuItem(
                                    onTap: () async {
                                      if (medId.isNotEmpty) {
                                        var resp = await DeleteMedicineRepo
                                            .deleteMedicineRepo(id: medId);

                                        if (resp["flag"] == true) {
                                          CommonWidget.getSnackBar(
                                              duration: 2,
                                              color: CommonColor.greenColor
                                                  .withOpacity(.4),
                                              colorText: Colors.white,
                                              title: "Done!",
                                              message: '${resp["data"]}');
                                        } else {
                                          CommonWidget.getSnackBar(
                                              duration: 2,
                                              color: Colors.red.withOpacity(.4),
                                              colorText: Colors.white,
                                              title: "Something went wrong!",
                                              message: '${resp["data"]}');
                                        }
                                      } else {
                                        CommonWidget.getSnackBar(
                                            duration: 2,
                                            color: Colors.red.withOpacity(.4),
                                            colorText: Colors.white,
                                            title: "Something went wrong",
                                            message: 'Please try again!');
                                      }
                                    },
                                    child: Text("Delete"),
                                  ),
                                ];
                              } else {
                                return [
                                  PopupMenuItem(
                                    onTap: () async {
                                      if (medId.isNotEmpty) {
                                        var resp = await DeleteMedicineRepo
                                            .deleteMedicineRepo(id: medId);

                                        if (resp["flag"] == true) {
                                          CommonWidget.getSnackBar(
                                              duration: 2,
                                              color: CommonColor.greenColor
                                                  .withOpacity(.4),
                                              colorText: Colors.white,
                                              title: "Done!",
                                              message: '${resp["data"]}');
                                        } else {
                                          CommonWidget.getSnackBar(
                                              duration: 2,
                                              color: Colors.red.withOpacity(.4),
                                              colorText: Colors.white,
                                              title: "Something went wrong!",
                                              message: '${resp["data"]}');
                                        }
                                      } else {
                                        CommonWidget.getSnackBar(
                                            duration: 2,
                                            color: Colors.red.withOpacity(.4),
                                            colorText: Colors.white,
                                            title: "Something went wrong",
                                            message: 'Please try again!');
                                      }
                                    },
                                    child: Text("Delete"),
                                  ),
                                ];
                              }
                            },
                          )
                        ]),
                    CommonText.textBoldWight400(
                        text: medGm,
                        color: CommonColor.blackColor0D0D0D,
                        fontSize: 11.sp),
                    CommonWidget.commonSizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText.textBoldWight400(
                            text: timeOfDay,
                            color: CommonColor.blackColor0D0D0D,
                            fontSize: 9.sp),
                        takenDoses!.length == int.parse(totalTimes)
                            ? Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  height: 18.sp,
                                  width: 18.sp,
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.check, size: 16,
                                    color: iconColor,
                                    //size: 18.sp,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: iconColor, width: 1.5),
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 18.sp,
                                width: 18.sp,
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<StatefulBuilder> takenMedicineDialog(
      {String? totalTimes, List<dynamic>? takenDoses, String? medId}) async {
    return StatefulBuilder(
      builder: (context, setState) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 210.sp,
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
                      text: "Select doses taken",
                      fontSize: 17.sp,
                    ),
                    InkWell(
                      onTap: () {
                        completedDoses.clear();
                        selectedDose.clear();
                        Get.back();
                      },
                      child: CommonWidget.commonSvgPitcher(
                          image: ImageConst.close),
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
                                text: "Doses",
                                fontSize: 13.sp,
                                color: Colors.black),
                            SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                              height: 50.sp,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                itemCount: int.parse(totalTimes!),
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 16.sp,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (!takenDoses!
                                                .contains(index + 1)) {
                                              if (selectedDose
                                                  .contains(index + 1)) {
                                                selectedDose.remove(index + 1);
                                              } else {
                                                selectedDose.add(index + 1);
                                              }
                                            }
                                          });
                                        },
                                        child: SizedBox(
                                          height: 20.sp,
                                          width: 20.sp,
                                          child: Container(
                                            height: 15.sp,
                                            width: 15.sp,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color:
                                                        CommonColor.greenColor,
                                                    width: selectedDose
                                                                .contains(
                                                                    index +
                                                                        1) ||
                                                            takenDoses!
                                                                .contains(
                                                                    index + 1)
                                                        ? 5.sp
                                                        : 1.5.sp)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      CommonText.textBoldWight500(
                                          text: index == 0
                                              ? "1st Dose"
                                              : index == 1
                                                  ? "2nd Dose"
                                                  : "3rd Dose")
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            CommonWidget.commonButton(
                                color: CommonColor.greenColor,
                                radius: 10,
                                onTap: () async {
                                  var _req = {
                                    "medicineId": "${medId}",
                                    "doses": selectedDose,
                                  };

                                  print('====== > ${_req}');
                                  print(
                                      '====== >kkkkkk  ${selectedDose[0].runtimeType}');

                                  await addRecordMedicineViewModel
                                      .addRecordMedicineViewModel(model: _req);

                                  if (addRecordMedicineViewModel
                                          .addRecordMedicineApiResponse
                                          .status ==
                                      Status.COMPLETE) {
                                    selectedDose.clear();
                                    Get.back();

                                    dateMedicineRecordViewModel
                                        .dateMedicineRecordViewModel(
                                            model: {"date": "${widget.date}"});

                                    CommonWidget.getSnackBar(
                                        duration: 1,
                                        color: CommonColor.greenColor
                                            .withOpacity(.4),
                                        colorText: Colors.white,
                                        title: "Done!",
                                        message: 'Record Updated!');
                                  }
                                  if (addRecordMedicineViewModel
                                          .addRecordMedicineApiResponse
                                          .status ==
                                      Status.ERROR) {
                                    selectedDose.clear();

                                    Get.back();
                                    CommonWidget.getSnackBar(
                                        duration: 1,
                                        color: Colors.red.withOpacity(.4),
                                        colorText: Colors.white,
                                        title: "Failed!",
                                        message:
                                            'Record not updated try again!');
                                  }
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
    );
  }
}
