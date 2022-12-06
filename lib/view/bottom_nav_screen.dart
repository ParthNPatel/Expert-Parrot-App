import 'package:expert_parrot_app/view/dashboard_screen.dart';
import 'package:expert_parrot_app/view/profile_screen.dart';
import 'package:expert_parrot_app/view/reminder_screen.dart';
import 'package:expert_parrot_app/view/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controller/handle_float_controller.dart';
import 'community_screen.dart';

class BottomNavScreen extends StatefulWidget {
  final int? index;

  const BottomNavScreen({super.key, this.index = 0});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {

  List<String> iconList = [
    'assets/png/home.png',
    'assets/png/notification (3).png',
    'assets/png/profile (2).png',
    'assets/png/chat.png'
  ];

  @override
  void initState() {
    pageSelected = widget.index!;
    super.initState();
  }

  int pageSelected = 0;

  HandleFloatController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageSelected == 0
          ? DashBoardScreen()
          : pageSelected == 1
              ? ReminderScreen()
              : pageSelected == 2
                  ? ProfileScreen()
                  : pageSelected == 3
                      ? CommunityScreen()
                      : VideoScreen(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GetBuilder<HandleFloatController>(
        builder: (controller) => controller.isVisible == false
            ? InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    pageSelected = 4;
                  });
                },
                child: Image.asset(
                  pageSelected == 4
                      ? "assets/png/video_outlined.png"
                      : "assets/png/video.png",
                  height: 50.sp,
                  width: 50.sp,
                ),
              )
            : SizedBox(),
      ),
      bottomNavigationBar: Container(
        height: 48.sp,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                iconList.length,
                (index) => Padding(
                  padding: EdgeInsets.only(
                      right: index == 1 ? 30 : 0, left: index == 2 ? 30 : 0),
                  child: ElevatedButton(
                    //splashColor: Colors.transparent,
                    // highlightColor: Colors.transparent,
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      setState(() {
                        pageSelected = index;
                      });
                    },
                    child: Image.asset(
                      iconList[index],
                      height: 20.sp,
                      width: 20.sp,
                      color: pageSelected == index
                          ? Color(0xff1FAD85)
                          : Color(0xffc2c2c2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
