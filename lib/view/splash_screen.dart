import 'package:expert_parrot_app/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/common_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Get.to(() => LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonWidget.commonBackGround(
          body: Column(
        children: [
          Spacer(),
          Image.asset('assets/png/splash_logo.png', scale: 2.5),
          Spacer(),
          Image.asset('assets/png/med schedule _ Notification.png', scale: 2.5),
          CommonWidget.commonSizedBox(height: 20)
        ],
      )),
    );
  }
}
