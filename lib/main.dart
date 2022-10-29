import 'package:expert_parrot_app/view/bottom_nav_screen.dart';
import 'package:expert_parrot_app/view/dashboard_screen.dart';
import 'package:expert_parrot_app/view/depandent_screen.dart';
import 'package:expert_parrot_app/view/medicine_graph_screen.dart';
import 'package:expert_parrot_app/view/video_screen.dart';
import 'package:expert_parrot_app/view/viedeo_play_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'controller/HandleFloatController.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        initialBinding: BaseBindings(),
        title: 'Expert Parrot',
        home: const BottomNavScreen(),
        // home: const VideoScreen(),
        // home: const BottomNavScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class BaseBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HandleFloatController(), fenix: true);
  }
}
