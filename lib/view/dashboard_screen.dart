import 'dart:developer' as log;
import 'dart:math';

import 'package:expert_parrot_app/Models/apis/api_response.dart';
import 'package:expert_parrot_app/Models/repo/delete_medicine_repo.dart';
import 'package:expert_parrot_app/Models/responseModel/get_all_medicine_names_model.dart';
import 'package:expert_parrot_app/Models/responseModel/get_record_medicine_res_model.dart';
import 'package:expert_parrot_app/Models/responseModel/user_data_res_model.dart';
import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/components/home_shimmer.dart';
import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:expert_parrot_app/get_storage_services/get_storage_service.dart';
import 'package:expert_parrot_app/view/bottom_nav_screen.dart';
import 'package:expert_parrot_app/view/water_graph_screen.dart';
import 'package:expert_parrot_app/viewModel/add_medicine_view_model.dart';
import 'package:expert_parrot_app/viewModel/add_record_medicine_view_model.dart';
import 'package:expert_parrot_app/viewModel/get_record_medicine_view_model.dart';
import 'package:expert_parrot_app/viewModel/user_data_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../Models/responseModel/get_all_mdeicine_names_list.dart';
import '../controller/handle_float_controller.dart';
import 'medicine_graph_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  TextEditingController _emailOrMobileController = TextEditingController();

  TextEditingController _heightController = TextEditingController();
  TextEditingController _kmController = TextEditingController();
  TextEditingController _heartRateController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  String? km, min, kal, step;
  String? verificationCode;
  DateTime dayOf = DateTime.now();
  List selectedDose = [];
  List completedDoses = [];

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

  // eyJhbGciOiJIUzI1NiJ9.NjM4MzE3ZGQ3NzgzZTdlYjYxN2VhYThi.nGqylOzdvmnkHu9ZYu_fA22w-VcfeEsohOyFWJQhYyU

  int medicineSelected = 0;
  int strengthSelected = 0;
  int daysSelected = 0;
  int appearanceSelected = 0;
  int frequencySelected = 0;
  int timeSelected = 0;

  TextEditingController medicineName = TextEditingController();

  // List<String> medicines = [
  //   'Duloxetine',
  //   'Disprin',
  //   'Duloxetine',
  //   'Dicyclomine',
  //   'Desvenla',
  // ];

  List strength = [
    '100',
    '200',
    '300',
    '400',
    '500',
  ];

  List days = [
    '10',
    '20',
    '30',
    '40',
    '40',
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

  HandleFloatController controller = Get.find();
  AddMedicineViewModel addMedicineViewModel = Get.put(AddMedicineViewModel());
  UserDataViewModel userDataViewModel = Get.put(UserDataViewModel());
  AddRecordMedicineViewModel addRecordMedicineViewModel =
      Get.put(AddRecordMedicineViewModel());

  GetAllMedicineNamesList getAllMedicineNamesList =
      Get.put(GetAllMedicineNamesList());
  GetRecordMedicineViewModel getRecordMedicineViewModel =
      Get.put(GetRecordMedicineViewModel());

  @override
  void initState() {
    controller.isVisible = false;

    getAllMedicineNamesList.getAllMedicineNames();
    userDataViewModel.userDataViewModel();
    getRecordMedicineViewModel.getRecordMedicineViewModel();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailOrMobileController.dispose();
  }

  List dateTimes = ['select1'];
  int select = 1;
  List LastData = [];

  @override
  Widget build(BuildContext context) {
    log.log('BARRIER TOKEN :- ${GetStorageServices.getBarrierToken()}');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CommonWidget.commonBackGround(
        body: GetBuilder<UserDataViewModel>(
          builder: (controller) {
            try {
              if (controller.userDataApiResponse.status == Status.LOADING) {
                return HomeShimmer();
              }
              if (controller.userDataApiResponse.status == Status.COMPLETE) {
                UserDataResponseModel userResponse =
                    controller.userDataApiResponse.data;
                LastData.clear();
                int length = userResponse.data!.medicines!.length;
                if (length >= 3) {
                  LastData.insert(0, {
                    'id': '${userResponse.data!.medicines![length - 3]["_id"]}',
                    'totalTimes':
                        '${userResponse.data!.medicines![length - 3]["totalTimes"]}',
                    'medName':
                        '${userResponse.data!.medicines![length - 3]["name"]!}',
                    'medGm':
                        '${userResponse.data!.medicines![length - 3]["strength"]} gm',
                    'timeOfDay':
                        '${userResponse.data!.medicines![length - 3]["totalTimes"]} pills ${userResponse.data!.medicines![length - 3]["frequency"]}',
                    'ap':
                        '${userResponse.data!.medicines![length - 3]["appearance"]}'
                  });
                  LastData.insert(1, {
                    'id':
                        '${userResponse.data!.medicines![length - 2]["_id"]!}',
                    'totalTimes':
                        '${userResponse.data!.medicines![length - 2]["totalTimes"]}',
                    'medName':
                        '${userResponse.data!.medicines![length - 2]["name"]!}',
                    'medGm':
                        '${userResponse.data!.medicines![length - 2]["strength"]} gm',
                    'timeOfDay':
                        '${userResponse.data!.medicines![length - 2]["totalTimes"]} pills ${userResponse.data!.medicines![length - 2]["frequency"]}',
                    'ap':
                        '${userResponse.data!.medicines![length - 2]["appearance"]}'
                  });

                  LastData.insert(2, {
                    'id':
                        '${userResponse.data!.medicines![length - 1]["_id"]!}',
                    'totalTimes':
                        '${userResponse.data!.medicines![length - 1]["totalTimes"]}',
                    'medName':
                        '${userResponse.data!.medicines![length - 1]["name"]!}',
                    'medGm':
                        '${userResponse.data!.medicines![length - 1]["strength"]} gm',
                    'timeOfDay':
                        '${userResponse.data!.medicines![length - 1]["totalTimes"]} pills ${userResponse.data!.medicines![length - 1]["frequency"]}',
                    'ap':
                        '${userResponse.data!.medicines![length - 1]["appearance"]}'
                  });
                }

                return GetBuilder<GetRecordMedicineViewModel>(
                    builder: (controllerGRM) {
                  if (controllerGRM.getRecordMedicineApiResponse.status ==
                      Status.LOADING) {
                    return HomeShimmer();
                  }
                  if (controllerGRM.getRecordMedicineApiResponse.status ==
                      Status.COMPLETE) {
                    GetRecordMedicineResponseModel respGRM =
                        controllerGRM.getRecordMedicineApiResponse.data;

                    return Column(
                      children: [
                        userNameWidget(userResponse),
                        CommonWidget.commonSizedBox(height: 20),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                dateShowWidet(),
                                CommonWidget.commonSizedBox(height: 20),
                                Row(
                                  children: [
                                    CommonText.textBoldWight500(
                                        text: TextConst.medSchedule,
                                        fontSize: 17.sp),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Get.dialog(StatefulBuilder(
                                          builder: (context, setState) =>
                                              addMedicineDialog(
                                                  context, setState),
                                        )).then((value) {
                                          setState(() {});
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            ImageConst.addIcon,
                                            scale: 3,
                                          ),
                                          CommonWidget.commonSizedBox(width: 6),
                                          CommonText.textGradient(
                                              text: TextConst.addAMed,
                                              fontSize: 14.sp),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                CommonWidget.commonSizedBox(height: 8),
                                ListView.builder(
                                  reverse: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: length > 3
                                      ? LastData.length
                                      : userResponse.data!.medicines!.length,
                                  itemBuilder: (context, index) {
                                    respGRM.data!.docs!.indexWhere(
                                      (element) {
                                        if (element.medicineId!.sId ==
                                            LastData[index]["id"]) {
                                          completedDoses = element.doses!;
                                        } else {
                                          completedDoses = [];
                                        }

                                        return element.medicineId!.sId ==
                                            LastData[index]["id"];
                                      },
                                    );

                                    var UserEqual = userResponse
                                        .data!.medicines![index]["appearance"];
                                    return length > 3
                                        ? medDetailsWidget(
                                            medId: "${LastData[index]['id']}",
                                            totalTimes:
                                                "${LastData[index]['totalTimes']}",
                                            takenDoses: completedDoses,
                                            image: LastData[index]['ap'] ==
                                                    'Pills'
                                                ? ImageConst.med3Icon
                                                : LastData[index]['ap'] == 'Gel'
                                                    ? ImageConst.med1Icon
                                                    : LastData[index]['ap'] ==
                                                            'Syrup'
                                                        ? ImageConst.med2Icon
                                                        : ImageConst.med2Icon,
                                            medName:
                                                '${LastData[index]['medName']}',
                                            medGm:
                                                '${LastData[index]['medGm']}',
                                            iconColor: LastData[index]['ap'] ==
                                                    'Pills'
                                                ? Color(0xff21D200)
                                                : LastData[index]['ap'] == 'Gel'
                                                    ? Color(0xffFFDD2C)
                                                    : LastData[index]['ap'] ==
                                                            'Syrup'
                                                        ? Color(0xff9255E5)
                                                        : Color(0xff9255E5),
                                            timeOfDay:
                                                '${LastData[index]['timeOfDay']}',
                                            color: LastData[index]['ap'] ==
                                                    'Pills'
                                                ? Color.fromRGBO(
                                                    69, 196, 44, 0.13)
                                                : LastData[index]['ap'] == 'Gel'
                                                    ? Color.fromRGBO(
                                                        193, 196, 44, 0.13)
                                                    : LastData[index]['ap'] ==
                                                            'Syrup'
                                                        ? Color.fromRGBO(
                                                            111, 44, 196, 0.13)
                                                        : Color.fromRGBO(
                                                            111, 44, 196, 0.13))
                                        : medDetailsWidget(
                                            medId: "${LastData[index]['id']}",
                                            totalTimes:
                                                "${LastData[index]['totalTimes']}",
                                            takenDoses: completedDoses,
                                            image: UserEqual == 'Pills'
                                                ? ImageConst.med3Icon
                                                : UserEqual == 'Gel'
                                                    ? ImageConst.med1Icon
                                                    : UserEqual == 'Syrup'
                                                        ? ImageConst.med2Icon
                                                        : ImageConst.med2Icon,
                                            medName:
                                                '${userResponse.data!.medicines![index]["name"]!}',
                                            medGm:
                                                '${userResponse.data!.medicines![index]["strength"]} gm',
                                            iconColor: UserEqual == 'Pills'
                                                ? Color(0xff21D200)
                                                : UserEqual == 'Gel'
                                                    ? Color(0xffFFDD2C)
                                                    : UserEqual == 'Syrup'
                                                        ? Color(0xff9255E5)
                                                        : Color(0xff9255E5),
                                            timeOfDay:
                                                '${userResponse.data!.medicines![index]["totalTimes"]} pills ${userResponse.data!.medicines![index]["frequency"]}',
                                            color: UserEqual == 'Pills'
                                                ? Color.fromRGBO(
                                                    69, 196, 44, 0.13)
                                                : UserEqual == 'Gel'
                                                    ? Color.fromRGBO(
                                                        193, 196, 44, 0.13)
                                                    : UserEqual == 'Syrup'
                                                        ? Color.fromRGBO(
                                                            111, 44, 196, 0.13)
                                                        : Color.fromRGBO(
                                                            111,
                                                            44,
                                                            196,
                                                            0.13,
                                                          ),
                                          );
                                  },
                                ),
                                CommonWidget.commonSizedBox(height: 16),
                                Row(
                                  children: [
                                    CommonText.textBoldWight500(
                                        text: TextConst.overview,
                                        fontSize: 17.sp,
                                        color: CommonColor.blackColor0D0D0D),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => MedicineGraphScreen());
                                      },
                                      child: CommonText.textGradient(
                                        text: 'My Medical Report',
                                        fontSize: 14.sp,
                                      ),
                                    )
                                  ],
                                ),
                                CommonWidget.commonSizedBox(height: 16),
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
                                    // 'name': 'Weight',
                                    // 'image': 'assets/png/glass_icon.png.png',
                                    // 'name_of_count': '78KG',
                                    // 'name_of_subject': 'This Week',
                                    // 'color': Color(0xffFAF0DB),
                                    return overViewWidget(
                                      onTap: () async {
                                        if (index == 3) {
                                          if (GetStorageServices.getUserBMI() !=
                                              null) {
                                            Get.dialog(
                                              bmiDialog(),
                                            ).whenComplete(
                                                () => setState(() {}));
                                          } else {
                                            Get.dialog(
                                              await enterHeightWeightDialog(),
                                            ).then((value) {
                                              setState(() {});
                                            });
                                          }
                                        } else if (index == 0) {
                                          Get.to(() => WaterGraphScreen());
                                        } else if (index == 2) {
                                          Get.dialog(
                                                  await enterHeartRateDialog())
                                              .whenComplete(
                                                  () => setState(() {}));
                                        }
                                      },
                                      name: overViewData[index]['name'],
                                      image: overViewData[index]['image'],
                                      medGm: index == 0
                                          ? GetStorageServices.getUserWater() ==
                                                  null
                                              ? 'Not set'
                                              : '${GetStorageServices.getUserWater()}'
                                          : index == 1
                                              ? '${GetStorageServices.getUserWeight()}'
                                              : index == 2
                                                  ? GetStorageServices
                                                              .getUserHeartRate() ==
                                                          null
                                                      ? 'Not set'
                                                      : '${GetStorageServices.getUserHeartRate()}'
                                                  : GetStorageServices
                                                              .getUserBMI() ==
                                                          null
                                                      ? 'Not set'
                                                      : '${GetStorageServices.getUserBMI()}',
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
                                  child: GestureDetector(
                                    onTap: () async {
                                      Get.dialog(await getReport())
                                          .whenComplete(() => setState(() {}));
                                    },
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
                                                      text: GetStorageServices
                                                                  .getUserKm() !=
                                                              null
                                                          ? '${(int.parse(GetStorageServices.getUserKm()) * 1408)}'
                                                          : '0',
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
                                                      text: GetStorageServices
                                                                  .getUserKm() !=
                                                              null
                                                          ? '${(int.parse(GetStorageServices.getUserKm()) * 190)}Kcal'
                                                          : '0 kcal',
                                                      image:
                                                          ImageConst.kcalIcon),
                                                  reportEventWidget(
                                                      padding: 4,
                                                      text: GetStorageServices
                                                                  .getUserKm() !=
                                                              null
                                                          ? '${(int.parse(GetStorageServices.getUserKm()) * 12)} min'
                                                          : '0 min',
                                                      image:
                                                          ImageConst.timeIcon),
                                                  reportEventWidget(
                                                      padding: 0,
                                                      height: 43,
                                                      text: GetStorageServices
                                                                  .getUserKm() !=
                                                              null
                                                          ? '${GetStorageServices.getUserKm()} Km'
                                                          : 'Na',
                                                      image: ImageConst
                                                          .locationIcon),
                                                ]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return HomeShimmer();
                  }
                });
              } else {
                return HomeShimmer();
              }
            } catch (e) {
              return Center(
                child: Text('Something went wrong !!!!!!'),
              );
            }
          },
        ),
      ),
    );
  }

  Future<StatefulBuilder> enterHeightWeightDialog() async {
    return StatefulBuilder(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText.textBoldWight500(
                        text: "Calculating BMI",
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText.textBoldWight400(
                        text:
                            "please enter your height and weight to calculate BMI",
                        fontSize: 11.sp,
                        color: Color(0xff9B9B9B),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CommonText.textBoldWight500(
                          text: "Height (cm)",
                          fontSize: 13.sp,
                          color: Colors.black),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _heightController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF8F8F6),
                            hintText: "Enter your height",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      CommonText.textBoldWight500(
                          text: "Weight (kg)",
                          fontSize: 13.sp,
                          color: Colors.black),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _weightController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF8F8F6),
                            hintText: "Enter your weight",
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
                            if (_heightController.text.isNotEmpty &&
                                _weightController.text.isNotEmpty) {
                              double weight =
                                  double.parse(_weightController.text);
                              double height =
                                  double.parse(_heightController.text);

                              var bmi = await weight / pow((height / 100), 2);

                              GetStorageServices.setUserBMI(
                                  bmi.toStringAsFixed(1));

                              GetStorageServices.setUserHeight(
                                  _heightController.text.toString());
                              GetStorageServices.setUserWeight(
                                  _weightController.text);

                              Navigator.of(context).pop(true);
                            } else {
                              CommonWidget.getSnackBar(
                                  color: Colors.red,
                                  duration: 2,
                                  colorText: Colors.white,
                                  title: "Required",
                                  message: 'Please enter height and weight.');
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
    );
  }

  Future<StatefulBuilder> enterHeartRateDialog() async {
    return StatefulBuilder(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText.textBoldWight500(
                        text: "Calculating HeartRate",
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                              Get.back();
                            } else {
                              CommonWidget.getSnackBar(
                                  color: Colors.red,
                                  duration: 2,
                                  colorText: Colors.white,
                                  title: "Required",
                                  message: 'Please enter hear.');
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
    );
  }

  Future<StatefulBuilder> getReport() async {
    return StatefulBuilder(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText.textBoldWight500(
                        text: "Calculating Report",
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText.textBoldWight400(
                        text:
                            "please enter Km that you have covred so far today",
                        fontSize: 11.sp,
                        color: Color(0xff9B9B9B),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CommonText.textBoldWight500(
                          text: "KM", fontSize: 13.sp, color: Colors.black),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _kmController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF8F8F6),
                            hintText: "Enter Km",
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
                            if (_kmController.text.isNotEmpty) {
                              GetStorageServices.setUserKm(
                                  _kmController.text.trim());
                              Get.back();
                            } else {
                              CommonWidget.getSnackBar(
                                  color: Colors.red,
                                  duration: 2,
                                  colorText: Colors.white,
                                  title: "Required",
                                  message: 'Please enter hear.');
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
      ),
    );
  }

  Dialog addMedicineDialog(BuildContext context, StateSetter setState) {
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
                                    Expanded(
                                      child: TextFormField(
                                        controller: medicineName,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Enter Medicine Name"),
                                      ),
                                    ),
                                    // CommonText.textBoldWight500(
                                    //     text: "${medicines[medicineSelected]}",
                                    //     fontSize: 13.sp,
                                    //     color: Colors.black),
                                  ],
                                ),
                                children: [
                                  GetBuilder<GetAllMedicineNamesList>(
                                    builder: (controller) {
                                      if (controller.getAllMedicines.status ==
                                          Status.LOADING) {
                                        return SizedBox();
                                      }
                                      if (controller.getAllMedicines.status ==
                                          Status.COMPLETE) {
                                        GetAllMedicineNames responseModel =
                                            controller.getAllMedicines.data;
                                        return Container(
                                          color: Colors.white,
                                          child: Column(
                                            children: List.generate(
                                              responseModel.data!.length,
                                              (index) => GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    medicineSelected = index;
                                                  });

                                                  medicineName =
                                                      TextEditingController(
                                                          text: responseModel
                                                              .data![index]
                                                              .toString());
                                                },
                                                child: Container(
                                                  color:
                                                      medicineSelected == index
                                                          ? Color(0xffe1f9ea)
                                                          : Colors.white,
                                                  padding: EdgeInsets.symmetric(
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
                                                                : Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      CommonText
                                                          .textBoldWight500(
                                                        text: responseModel
                                                            .data![index],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      return Center(
                                        child: CommonText.textBoldWight500(
                                            text: 'Something went wrong'),
                                      );
                                    },
                                  ),
                                ],
                              ),
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
                                                    strengthSelected = index;
                                                  });
                                                },
                                                child: Container(
                                                  color:
                                                      strengthSelected == index
                                                          ? Color(0xffe1f9ea)
                                                          : Colors.white,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.check,
                                                        size: 17,
                                                        color:
                                                            strengthSelected ==
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
                                                        text:
                                                            '${strength[index]} mg',
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
                                                  color: daysSelected == index
                                                      ? Color(0xffe1f9ea)
                                                      : Colors.white,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.check,
                                                        size: 17,
                                                        color:
                                                            daysSelected ==
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
                                                        text:
                                                            '${days[index]} days',
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
                              Get.dialog(
                                StatefulBuilder(
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
                                                    clearMedicineData();
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
                                                                    width: 18,
                                                                  ),
                                                                  CommonText.textBoldWight500(
                                                                      text:
                                                                          "${frequency[frequencySelected]}",
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
                                                                    children: List
                                                                        .generate(
                                                                      frequency
                                                                          .length,
                                                                      (index) =>
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            frequencySelected =
                                                                                index;
                                                                          });

                                                                          log.log(
                                                                              'FREQUENCY ${frequency[frequencySelected]}');
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          color: frequencySelected == index
                                                                              ? Color(0xffe1f9ea)
                                                                              : Colors.white,
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: 10,
                                                                              vertical: 10),
                                                                          child:
                                                                              Row(
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
                                                                      ),
                                                                    ),
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
                                                                    children: List
                                                                        .generate(
                                                                      times
                                                                          .length,
                                                                      (index) =>
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            timeSelected =
                                                                                index;
                                                                          });

                                                                          log.log(
                                                                              'SELECT INDEX:-$timeSelected');
                                                                          if (timeSelected ==
                                                                              0) {
                                                                            select =
                                                                                1;

                                                                            if (dateTimes.length == 3 &&
                                                                                select == 1) {
                                                                              dateTimes.removeLast();
                                                                              dateTimes.removeLast();
                                                                            }
                                                                            if (dateTimes.length == 2 &&
                                                                                select == 1) {
                                                                              dateTimes.removeLast();
                                                                            }
                                                                          }

                                                                          if (timeSelected ==
                                                                              1) {
                                                                            select =
                                                                                2;

                                                                            if (dateTimes.length == 1 &&
                                                                                select == 2) {
                                                                              dateTimes.insert(1, 'select2');
                                                                            }

                                                                            if (dateTimes.length == 3 &&
                                                                                select == 2) {
                                                                              dateTimes.removeLast();
                                                                            }

                                                                            log.log('SELCET2  $dateTimes');
                                                                          }

                                                                          if (timeSelected ==
                                                                              2) {
                                                                            select =
                                                                                3;

                                                                            if (dateTimes.length == 2 &&
                                                                                select == 3) {
                                                                              dateTimes.insert(2, 'select3');
                                                                            }
                                                                            if (dateTimes.length == 1 &&
                                                                                select == 3) {
                                                                              dateTimes.insert(1, 'select2');
                                                                              dateTimes.insert(2, 'select3');
                                                                            }

                                                                            log.log('SELCET3  $dateTimes');
                                                                          }
                                                                          setState(
                                                                              () {});
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          color: timeSelected == index
                                                                              ? Color(0xffe1f9ea)
                                                                              : Colors.white,
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: 10,
                                                                              vertical: 10),
                                                                          child:
                                                                              Row(
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
                                                                      ),
                                                                    ),
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
                                                                dateTimes
                                                                    .length,
                                                                (index) =>
                                                                    GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    await pickTime(
                                                                        index);
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        40.sp,
                                                                    width:
                                                                        170.sp,
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
                                                                          width:
                                                                              15.sp,
                                                                          color:
                                                                              Color(0xff9B9B9B),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              18,
                                                                        ),
                                                                        CommonText.textBoldWight500(
                                                                            text:
                                                                                "${dateTimes[index]}",
                                                                            fontSize:
                                                                                13.sp,
                                                                            color: Colors.black),
                                                                      ],
                                                                    ),
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
                                                                onTap:
                                                                    () async {
                                                                  await addMedicineData();
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
                                ),
                              ).then(
                                (value) {
                                  setState(
                                    () {},
                                  );
                                },
                              );
                            },
                            text: "Next",
                          )
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
  }

  pickTime(index) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      var formattedTime = pickedTime.format(context);
      print('SELECT TIME :- ${formattedTime}');
      setState(() {
        dateTimes[index] = formattedTime;
      });
    } else {
      print("Time is not selected");
    }
  }

  addMedicineData() async {
    log.log('DATE TIMES :- $dateTimes');
    try {
      if (dateTimes.contains('select1') ||
          dateTimes.contains('select2') ||
          dateTimes.contains('select3')) {
        CommonWidget.getSnackBar(
          message: '',
          title: 'Select Time Slot',
          duration: 2,
          color: Colors.red,
        );
      } else {
        log.log('TOTAL DATE :- ${dateTimes}');

        await addMedicineViewModel.addMedicineViewModel(model: {
          "name": "${medicineName.text.trim()}",
          "strength": int.parse("${strength[strengthSelected]}"),
          "days": int.parse("${days[daysSelected]}"),
          "appearance": "${appearance[appearanceSelected]}",
          "frequency": "${frequency[frequencySelected]}",
          "totalTimes": timeSelected + 1,
          "shceduleTime": dateTimes
        });

        if (addMedicineViewModel.addMedicineApiResponse.status ==
            Status.COMPLETE) {
          Get.back();
          userDataViewModel.userDataViewModel();

          CommonWidget.getSnackBar(
              title: "Added!",
              message: 'Your medicine has been added successfully.',
              color: CommonColor.greenColor,
              colorText: Colors.white);
          clearMedicineData();
        }
        if (addMedicineViewModel.addMedicineApiResponse.status ==
            Status.ERROR) {
          CommonWidget.getSnackBar(
            message: '',
            title: 'Failed',
            duration: 2,
            color: Colors.red,
          );
        }
      }
    } catch (e) {
      CommonWidget.getSnackBar(
        message: '',
        title: 'Something went wrong',
        duration: 2,
        color: Colors.red,
      );
    }
  }

  clearMedicineData() {
    setState(() {
      dateTimes = ['select1'];
      select = 1;
      medicineSelected = 0;
      strengthSelected = 0;
      daysSelected = 0;
      appearanceSelected = 0;
      frequencySelected = 0;
      timeSelected = 0;
    });
  }

  Dialog bmiDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 300.sp,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText.textBoldWight500(
                    text: "Calculating BMI",
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  CommonText.textBoldWight500(
                      text: "Formula:", fontSize: 13.sp, color: Colors.black),
                  SizedBox(
                    height: 12,
                  ),
                  CommonText.textBoldWight400(
                      text: "weight (kg) / [height (m)]2",
                      fontSize: 11.sp,
                      color: Colors.black),
                  SizedBox(
                    height: 5,
                  ),
                  CommonText.textBoldWight400(
                      text: "or", fontSize: 11.sp, color: Color(0xff979797)),
                  SizedBox(
                    height: 5,
                  ),
                  CommonText.textBoldWight400(
                      text:
                          "[weight (kg) / height (cm) / height (cm)] x 10,000",
                      fontSize: 11.sp,
                      color: Colors.black),
                  SizedBox(
                    height: 13,
                  ),
                  CommonText.textBoldWight500(
                      text: "Strength", fontSize: 13.sp, color: Colors.black),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 50.sp,
                        width: 63.sp,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade100,
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                  offset: Offset(1, 1))
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonText.textBoldWight500(
                              text: '${GetStorageServices.getUserHeight()}cm',
                              color: CommonColor.greenColor,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CommonText.textBoldWight500(
                              text: 'Height',
                              fontSize: 10.sp,
                              color: Color(0xff444444),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        height: 50.sp,
                        width: 63.sp,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade100,
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                  offset: Offset(1, 1))
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonText.textBoldWight500(
                              text: '${GetStorageServices.getUserWeight()} kg',
                              color: CommonColor.greenColor,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CommonText.textBoldWight500(
                              text: 'Weight',
                              fontSize: 10.sp,
                              color: Color(0xff444444),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () async {
                          Get.back();
                          Get.dialog(await enterHeightWeightDialog())
                              .then((value) {
                            setState(() {});
                          });
                        },
                        child: Container(
                          height: 23.sp,
                          width: 55.sp,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: CommonColor.greenColor),
                          child: Center(
                            child: Text(
                              "Edit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  CommonText.textBoldWight500(
                      text: "Result", fontSize: 13.sp, color: Colors.black),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      CommonText.textBoldWight500(
                        text: '${GetStorageServices.getUserBMI()}',
                        color: CommonColor.greenColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CommonText.textBoldWight500(
                        text: 'BMI',
                        fontSize: 10.sp,
                        color: Color(0xff444444),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        ImageConst.bmiIcon,
                        scale: 5,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CommonWidget.commonButton(
                      color: CommonColor.greenColor,
                      radius: 10,
                      onTap: () {
                        Get.back();
                      },
                      text: "Next")
                ],
              ),
            ),
          ],
        ),
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
              color: CommonColor.blackColor616161.withOpacity(
                0.7,
              ),
            ),
          )
        ],
      ),
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
      required String image}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
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
                          // color: iconColor == Color(0xff21D200)
                          //     ? Color(0xffDBF3D8)
                          //     : iconColor == Color(0xffFFDD2C)
                          //         ? Color(0xffEBF3D9)
                          //         : iconColor == Color(0xff9255E5)
                          //             ? Color(0xffE0DFED)
                          //             : Color(0xff9255E5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.more_vert,
                            color: CommonColor.geryB4B4B4,
                          ),
                          onSelected: (value) async {
                            switch (value) {
                              case 'mark':
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
                              default:
                                throw UnimplementedError();
                            }
                          },
                          itemBuilder: (context) {
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
                                      await userDataViewModel
                                          .userDataViewModel();

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
                                  border:
                                      Border.all(color: iconColor, width: 1.5),
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
          height: 200.sp,
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
                              height: 40.sp,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: NeverScrollableScrollPhysics(),
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
                                        child: Container(
                                          height: 15.sp,
                                          width: 15.sp,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: CommonColor.greenColor,
                                                  width: selectedDose.contains(
                                                              index + 1) ||
                                                          takenDoses!.contains(
                                                              index + 1)
                                                      ? 4.sp
                                                      : 1.3.sp)),
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

                                  await addRecordMedicineViewModel
                                      .addRecordMedicineViewModel(model: _req);

                                  if (addRecordMedicineViewModel
                                          .addRecordMedicineApiResponse
                                          .status ==
                                      Status.COMPLETE) {
                                    selectedDose.clear();
                                    Get.back();
                                    userDataViewModel.userDataViewModel();
                                    getRecordMedicineViewModel
                                        .getRecordMedicineViewModel();
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

                                    Get.back();
                                    CommonWidget.getSnackBar(
                                        duration: 2,
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
              CommonText.textBoldWight500(
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

  Row dateShowWidet() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonWidget.commonBackButton(onTap: () {
          dayOf = DateTime.utc(
            dayOf.year,
            dayOf.month,
            dayOf.day - 1,
          );
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
            }
            print(difference);
            setState(() {});
          }),
        ),
      ],
    );
  }

  Row userNameWidget(UserDataResponseModel userResponse) {
    return Row(
      children: [
        CommonText.textBoldWight400(text: 'Good Morning, ', fontSize: 16.sp),
        CommonText.textBoldWight500(
            text:
                '${userResponse.data!.name.toString().split(" ").first.capitalizeFirst}!',
            fontSize: 18.sp),
        Spacer(),
        Image.asset(
          ImageConst.notification,
          scale: 5,
        ),
        CommonWidget.commonSizedBox(width: 6),
        InkWell(
          onTap: () {
            Get.off(
              () => BottomNavScreen(
                index: 2,
              ),
            );
          },
          child: Container(
            height: 27.sp,
            width: 27.sp,
            decoration: BoxDecoration(
                border: Border.all(color: CommonColor.greenColor),
                borderRadius: BorderRadius.circular(8)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://health-app-test.s3.ap-south-1.amazonaws.com/user/${GetStorageServices.getUserImage()}',
                  scale: 5,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    color: Colors.grey,
                    Icons.person,
                    size: 15.sp,
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
