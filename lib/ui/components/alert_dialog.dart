import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

import 'package:weather_app/common/colors.dart';

displayAlertDialog({
  required String title,
  required String content,
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    builder: (dialogContext) {
      return Platform.isIOS
          ? // ios AlertDialog
          CupertinoAlertDialog(
              title: Text(title),
              content: Text(
                content,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.black),
              ),
              actions: [
                CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    isDefaultAction: true,
                    child: const Text("OK"))
              ],
            )
          : AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                ),
              ],
            );
    },
  );
}
