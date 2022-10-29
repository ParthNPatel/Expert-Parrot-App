import 'package:get/get.dart';

class HandleFloatController extends GetxController {
  bool isVisible = false;

  void changeVisibility(bool value) {
    isVisible = value;
    update();
  }
}
