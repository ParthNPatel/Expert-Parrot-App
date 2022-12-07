import 'package:expert_parrot_app/constant/color_const.dart';
import 'package:expert_parrot_app/services/app_notification.dart';
import 'package:expert_parrot_app/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'controller/handle_float_controller.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await GetStorage.init();

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await AppNotificationHandler.getFcmToken();

  // AppNotificationHandler.getInitialMsg();
  // AppNotificationHandler.onMsgOpen();
  await FirebaseMessaging.instance.subscribeToTopic('all');

  // Update the iOS foreground notification presentation options to allow
  // heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  AppNotificationHandler.showMsgHandler();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  await GetStorage.init();

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
        theme: ThemeData(
          primaryColor: CommonColor.greenColor,
          colorScheme: ColorScheme.light(primary: CommonColor.greenColor),
        ),
        home: const SplashScreen(),
        // home: const VideoScreen(),
        // home: VideoPlayScreen(),
        // home: SplashScreen(),
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
