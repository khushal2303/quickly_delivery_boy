import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/styles/theme.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class Helpers {
  static int getColor(String color) {
    return int.parse("0xff" + color);
  }

  static String base64ImageConvert(File fileData) {
    List<int> imageBytes = fileData.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  static Widget loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
      ),
    );
  }

  static PageRoute pageRouteBuilder(widget) {
    return CupertinoPageRoute(builder: (context) => widget);
  }

  static void showToast({
    required String message,
  }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: AppColors.transparent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showSnackbar(BuildContext context, String msg, bool isError) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        new SnackBar(
          backgroundColor: isError ? Colors.red : Colors.green,
          content: Text(
            msg,
            style: TextStyle(color: AppColors.whiteColor),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  static void showAlertDialog(
    BuildContext context,
    String title,
    String button1Text,
    String button2Text,
    Function? button1Click,
    Function? button2Click, {
    String? content,
  }) {
    // set up the buttons
    Widget button1 = TextButton(
      child: Text(
        button1Text,
        style: TextStyles.bold14(AppColors.primaryColor),
      ),
      onPressed: () => {
        Navigator.of(context).pop(),
        if (button1Click != null) button1Click(),
      },
    );
    Widget button2 = TextButton(
      child: Text(
        button2Text,
        style: TextStyles.bold14(AppColors.primaryColor),
      ),
      onPressed: () => {
        Navigator.of(context).pop(),
        if (button2Click != null) button2Click(),
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: content != null ? Text(content) : null,
      actions: [
        button1,
        button2,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static ProgressDialog progressDialog(BuildContext context, String title) {
    return ProgressDialog(
      context,
      // message: Text(title),
      dismissable: false,
      title: null, message: Text(title),
    );
  }
}
