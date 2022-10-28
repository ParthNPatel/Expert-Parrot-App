import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../constant/color_const.dart';
import '../constant/image_const.dart';
import '../constant/text_const.dart';
import '../constant/text_styel.dart';

class CommonWidget {
  static SizedBox commonSizedBox({double? height, double? width}) {
    return SizedBox(height: height, width: width);
  }

  static Widget commonBackGround(
      {required Widget body, String backGround = ImageConst.backGround}) {
    return Container(
      height: Get.height,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(backGround), fit: BoxFit.fill)),
      child: SafeArea(child: body),
    );
  }

  static Widget commonBackButton(
      {final onTap, String image = ImageConst.backArrow}) {
    return Container(
      height: 36.sp,
      width: 36.sp,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: IconButton(
        icon: SvgPicture.asset(image),
        onPressed: onTap,
      ),
    );
  }

  static Widget textFormField(
      {String? hintText,
      List<TextInputFormatter>? inpuFormator,
      required TextEditingController controller,
      int? maxLength,
      TextInputType? keyBoardType,
      bool isObscured = false,
      Widget? suffix}) {
    return SizedBox(
      height: 43.sp,
      child: TextFormField(
        obscureText: isObscured,
        inputFormatters: inpuFormator,
        maxLength: maxLength,
        controller: controller,
        keyboardType: keyBoardType,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: TextConst.fontFamily,
        ),
        cursorColor: Colors.black,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 7.sp, left: 12.sp),
            suffixIcon: suffix,
            filled: true,
            fillColor: CommonColor.textFieldColor7f8f9,
            hintText: hintText,
            hintStyle: TextStyle(
                fontFamily: TextConst.fontFamily,
                fontWeight: FontWeight.w400,
                color: CommonColor.hintTextColor8391A1),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  static commonButton({required VoidCallback onTap, required String text}) {
    return MaterialButton(
      onPressed: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: CommonColor.blackButtonColor1E232C,
      height: 40.sp,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CommonText.textBoldWight600(
              text: text, color: Colors.white, fontSize: 12.sp)
        ]),
      ),
    );
  }

  static getSnackBar(
      {required String title,
      required String message,
      Color? color/*= themColors309D9D*/,
      Color colorText = Colors.white,
      int duration = 1}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      colorText: colorText,
      duration: Duration(seconds: duration),
      backgroundColor: color,
    );
  }

  static Widget commonSvgPitcher(
      {required String image, double? height, double? width}) {
    return SvgPicture.asset(
      image,
      height: height,
      width: width,
    );
  }
}
