import 'package:expert_parrot_app/constant/text_const.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CommonText {
  static textBoldWight400(
      {required String text,
      double? fontSize,
      Color? color,
      FontWeight fontWeight = FontWeight.w400}) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
          fontFamily: TextConst.fontFamily),
    );
  }

  static textBoldWight500(
      {required String text,
      double? fontSize,
      Color? color,
      TextDecoration textDecoration = TextDecoration.none,
      FontWeight fontWeight = FontWeight.w500}) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: fontWeight,
          decoration: textDecoration,
          fontSize: fontSize,
          color: color,
          fontFamily: TextConst.fontFamily),
    );
  }

  static textBoldWight600(
      {required String text,
      double? fontSize,
      Color? color,
      FontWeight fontWeight = FontWeight.w600}) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
          fontFamily: TextConst.fontFamily),
    );
  }

  static textBoldWight700(
      {required String text,
      double? fontSize,
      Color? color,
      TextDecoration textDecoration = TextDecoration.none}) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
          decoration: textDecoration,
          color: color,
          fontFamily: TextConst.fontFamily),
    );
  }

  ///gradient text
  static textGradient(
      {required String text,
      double? fontSize,
      TextDecoration textDecoration = TextDecoration.none}) {
    return GradientText(
      '$text',
      // background: linear-gradient(180deg, #38BC4D 0%, #15A99E 100%);

      colors: [Color(0xff45C42C), Color(0xff07A0BF)],
      gradientDirection: GradientDirection.ttb,
      style: TextStyle(fontSize: fontSize, fontFamily: TextConst.fontFamily),
    )
        /*Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
          decoration: textDecoration,
          color: color,
          fontFamily: TextConst.fontFamily),
    )*/
        ;
  }
  // background: linear-gradient(180deg, #45C42C 0%, #07A0BF 100%);

}
