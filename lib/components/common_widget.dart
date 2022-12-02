import 'package:dotted_line/dotted_line.dart';
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
  static Widget header(
      {required final backOnTap,
      required String titleText,
      required final addOnTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonWidget.commonBackButton(
          onTap: backOnTap,
        ),
        CommonText.textBoldWight500(text: titleText, fontSize: 16.sp),
        CommonWidget.commonBackButton(
          image: ImageConst.add,
          onTap: addOnTap,
        ),
      ],
    );
  }

  static Widget faqHeader(
      {required final backOnTap,
      required String titleText,
      required final addOnTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonWidget.commonBackButton(
          onTap: backOnTap,
        ),
        CommonText.textBoldWight500(text: titleText, fontSize: 16.sp),
        CommonWidget.commonBackButton(
          image: ImageConst.faq,
          onTap: addOnTap,
        ),
      ],
    );
  }

  static SizedBox commonSizedBox({double? height, double? width}) {
    return SizedBox(height: height, width: width);
  }

  static Widget commonBackGround(
      {required Widget body, String backGround = ImageConst.backGround}) {
    return Container(
      height: double.infinity,
      width: double.infinity,
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
      height: 30.sp,
      width: 30.sp,
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

  static Widget textFormField({
    String? hintText,
    List<TextInputFormatter>? inpuFormator,
    required TextEditingController controller,
    int? maxLength,
    TextInputType? keyBoardType,
    bool isObscured = false,
    Widget? suffix,
    Widget? prefix,
    borderColor,
  }) {
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
            prefixIcon: prefix,
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
                borderSide: BorderSide(color: borderColor),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor),
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  static commonButton(
      {required VoidCallback onTap,
      required String text,
      Color color = blackButtonColor1E232C,
      double radius = 8}) {
    return MaterialButton(
      onPressed: onTap,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      color: color,
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

  static commonHalfButton(
      {required VoidCallback onTap,
      required String text,
      Color color = blackButtonColor1E232C,
      double radius = 8}) {
    return;
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
      {required String image, Color? color, double? height, double? width}) {
    return SvgPicture.asset(
      color: color,
      image,
      height: height,
      width: width,
    );
  }

  static String? convertDateForm(DateTime tm) {
    DateTime today = new DateTime.now();
    Duration oneDay = new Duration(days: 1);
    Duration twoDay = new Duration(days: 2);
    Duration oneWeek = new Duration(days: 7);
    String? month;
    switch (tm.month) {
      case 1:
        month = "january";
        break;
      case 2:
        month = "february";
        break;
      case 3:
        month = "march";
        break;
      case 4:
        month = "april";
        break;
      case 5:
        month = "may";
        break;
      case 6:
        month = "june";
        break;
      case 7:
        month = "july";
        break;
      case 8:
        month = "august";
        break;
      case 9:
        month = "september";
        break;
      case 10:
        month = "october";
        break;
      case 11:
        month = "november";
        break;
      case 12:
        month = "december";
        break;
    }

    Duration difference = today.difference(tm);
    if (difference.compareTo(Duration(minutes: 1)) < 1) {
      return 'Today';
    } else if (difference.compareTo(Duration(hours: 1)) < 1) {
      return '${difference.inMinutes} minute';
      // return '${DateFormat.jm().format(tm)}';
    } else if (difference.compareTo(oneDay) < 1) {
      return 'Today';
      // return '${DateFormat.jm().format(tm)}';
      // return '${difference.inHours} hours';
    } else if (difference.compareTo(twoDay) < 1) {
      return "yesterday";
    } else if (difference.compareTo(oneWeek) < 1) {
      switch (tm.weekday) {
        case 1:
          return "Monday";
        case 2:
          return "Tuesday";
        case 3:
          return "Wednesday";
        case 4:
          return "Thursday";
        case 5:
          return "Friday";
        case 6:
          return "Saturday";
        case 7:
          return "Sunday";
      }
    } else if (tm.year == today.year) {
      return '${tm.day} $month';
    } else {
      return '${tm.day} $month ${tm.year}';
    }
  }

  static Widget dottedLineWidget() {
    return DottedLine(
      lineLength: double.infinity,
      lineThickness: 1.0,
      dashLength: 10.0,
      dashColor: Color(0xffbac2ba),
      dashRadius: 0.0,
      dashGapLength: 6.0,
      dashGapColor: Colors.transparent,
      dashGapRadius: 0.0,
    );
  }
}
