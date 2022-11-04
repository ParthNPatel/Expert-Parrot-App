import 'package:dotted_line/dotted_line.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../components/common_widget.dart';
import '../constant/color_const.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  List reminders = [
    {
      'image': 'assets/png/capsule.png',
      'title': 'Hey, Take Your Med (Softgel)',
      'time': 'About 1 minutes ago',
      'color': Color(0xffdeeaf4)
    },
    {
      'image': 'assets/png/rest.png',
      'title': 'Take Rest',
      'time': 'About 3 hours ago',
      'color': Color(0xffede7ee)
    },
    {
      'image': 'assets/png/seringe.png',
      'title': 'Hey, Novolin Inj Take or not?',
      'time': 'About 3 hours ago',
      'color': Color(0xfff1d9d4)
    },
    {
      'image': 'assets/png/foot.png',
      'title': 'Congratulations, You have...',
      'time': '29 May',
      'color': Color(0xffcef7f6)
    },
    {
      'image': 'assets/png/watch.png',
      'title': 'Hey, it’s time for lunch',
      'time': '8 April',
      'color': Color(0xfff3e9ec)
    },
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonWidget.commonBackGround(
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            header(),
            SizedBox(
              height: 13,
            ),
            CommonWidget.dottedLineWidget(),
            SizedBox(
              height: 23,
            ),
            ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              itemBuilder: (context, index) => Row(
                children: [
                  CircleAvatar(
                    radius: 20.sp,
                    backgroundColor: reminders[index]['color'],
                    child: Image.asset(
                      reminders[index]['image'],
                      height: 25.sp,
                      width: 25.sp,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText.textBoldWight500(
                          text: reminders[index]['title']),
                      SizedBox(
                        height: 5,
                      ),
                      CommonText.textBoldWight400(
                          text: reminders[index]['time'],
                          fontSize: 9.sp,
                          color: Color(0xff7B6F72)),
                    ],
                  ),
                  Spacer(),
                  Icon(
                    Icons.more_vert,
                    color: Color(0xffada4a5),
                    size: 15.sp,
                  )
                ],
              ),
              separatorBuilder: (context, index) => Divider(
                height: 30,
                thickness: 1.3,
                color: Color(0xffDDDADA),
              ),
              itemCount: reminders.length,
            )
          ],
        ),
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
        CommonText.textBoldWight500(text: "Reminder", fontSize: 18.sp),
        CommonWidget.commonBackButton(
          image: ImageConst.add,
          onTap: () {
            Get.dialog(StatefulBuilder(
              builder: (context, setState) =>
                  addMedicineDialog(context, setState),
            )).then((value) {
              setState(() {});
            });
          },
        ),
      ],
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
  }
}
