import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  //One instance, needs factory
  static late AppColors _instance;
  factory AppColors() => _instance;

  AppColors._();

  static const primaryColor = Color(0xff675FB8);
  static const darkGrey = Color(0xff7C7C7C);
  static const whiteColor = Colors.white;
  static const blackColor = Colors.black;

  static const offWhiteColor = Color(0xfff2f3f7);
  static const walletColor = Color(0xffe4ecff);
  static const buttonColor = Color(0xff675FB8);

  static const highlightColor = Color(0xffFFE3E3);

  static const loginSplash = Color(0xffE3E9FF);
  static const mobileTextField = Color(0xffF1F3F6);

  static const hintColor = Color(0xff9D9EA0);

  static const backgroundColor = Color(0xffF6F8FB);

  static const lightColor = Color(0xff7C7D7E);

  static const termColor = Color(0xff7C7D7E);
  static const unSelectedColor = Color(0xff707070);

  static const richOutColor = Color(0xffFFF2E3);

  static const categoryBackground = Color(0xffE5FFE3);

  static const redColor = Color(0xffFF4747);

  static const dividerColor = Color(0xffDDDDDE);

  static const unselectedIndi = Color(0xffE7E3FF);

  static const switchColor = Color(0xff2C295E);

  static const activeSwitchColor = Color(0xffFFD200);
  static const inActiveSwitchColor = Color(0xff3F3A6D);

  static const transparent = Colors.transparent;
  static const accountIconColor = Color(0xffF0F0F0);

  static const orderStstusColor = Color(0xff5CC7AB);

  static const voucherColor = Color(0xffFFC000);

  static const dangerColor = Color(0xffF44658);

  static const timerRingColor = Color(0xff2C295E);

  static const profileBackColor = Color(0xff070330);

  static const caseCollectionColor = Color(0xff5A56DF);

  static const iconBackColor = Color(0xffF0F0F8);
}

class ColorUtils {
  static Color getColorCode(String color) {
    return Color(int.parse("0xff" + color));
  }
}
