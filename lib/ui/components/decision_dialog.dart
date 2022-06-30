import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/common/colors.dart';

Widget yesButton(
    {required Function() isYes, required Color mainColor, String? text}) {
  return TextButton(
    child: Text(
      text ?? "YES",
      style: TextStyle(color: mainColor),
    ),
    onPressed: isYes,
  );
}

Widget noButton({required Function() isNo, String? text}) {
  return TextButton(
    child: Text(
      text ?? "NO",
      style: const TextStyle(color: Colors.black),
    ),
    onPressed: isNo,
  );
}

displayDecisionDialog(
  BuildContext context, {
  required String titleText,
  String? content,
  required Function() yesFunction,
  required Function() noFunction,
  bool barrierDismissible = true,
  Color mainColor = AppColors.blue,
  String? yesText,
  String? noText,
}) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(titleText),
    content: content == null ? null : Text(content),
    insetPadding: const EdgeInsets.symmetric(horizontal: 25),
    actions: [
      noButton(isNo: noFunction, text: noText),
      yesButton(isYes: yesFunction, text: yesText, mainColor: mainColor),
    ],
  );

  // ios AlertDialog
  CupertinoAlertDialog alertIos = CupertinoAlertDialog(
    title: Text(titleText),
    content: content == null ? null : Text(content),
    actions: [
      CupertinoDialogAction(
        onPressed: noFunction,
        //   isDefaultAction: true,
        child: Text(
          noText ?? "NO",
          style: const TextStyle(color: Colors.black),
        ),
      ),
      CupertinoDialogAction(
        onPressed: yesFunction,
        //  isDefaultAction: true,
        child: Text(
          yesText ?? "YES",
          style: TextStyle(color: mainColor),
        ),
      ),
    ],
  );
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return Platform.isIOS ? alertIos : alert;
    },
  );
}
