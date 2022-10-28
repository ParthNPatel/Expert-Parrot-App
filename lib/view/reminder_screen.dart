import 'package:dotted_line/dotted_line.dart';
import 'package:expert_parrot_app/constant/image_const.dart';
import 'package:expert_parrot_app/constant/text_const.dart';
import 'package:expert_parrot_app/constant/text_styel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../components/common_widget.dart';

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
      'title': 'Congratulations, You have finis...',
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
                      height: 20.sp,
                      width: 20.sp,
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
            Get.back();
          },
        ),
      ],
    );
  }
}
