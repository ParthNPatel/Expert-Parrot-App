import 'package:expert_parrot_app/components/common_widget.dart';
import 'package:expert_parrot_app/view/dashboard_screen.dart';
import 'package:expert_parrot_app/view/profile_screen.dart';
import 'package:expert_parrot_app/view/reminder_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

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

  int pageSelected = 0;

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
                      ? Center(child: Text("Chat"))
                      : Center(child: Text("Video")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          setState(() {
            pageSelected = 4;
          });
        },
        child: Image.asset(
          "assets/png/video.png",
          height: 50.sp,
          width: 50.sp,
        ),
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
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
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
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
