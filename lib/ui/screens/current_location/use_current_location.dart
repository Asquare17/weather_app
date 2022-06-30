import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/common/colors.dart';
import 'package:weather_app/ui/components/alert_dialog.dart';
import 'package:weather_app/ui/components/decision_dialog.dart';

Future<Position?> getCurrentLocation(BuildContext context) async {
  bool serviceEnabled = false;

  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    displayDecisionDialog(
      context,
      titleText: "Location Services Disabled",
      content: "You need to enable Location Services in Settings",
      noText: "Cancel",
      yesText: "Settings",
      mainColor: AppColors.blue,
      noFunction: () {
        Navigator.pop(context);
      },
      yesFunction: () async {
        Navigator.pop(context);
        bool open = await Geolocator.openLocationSettings();
        if (!open) Geolocator.openAppSettings();
      },
    );
    return null;
  }

  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.deniedForever) {
    displayDecisionDialog(
      context,
      titleText: "Location Permission Denied",
      content: "You need to enable Location permission in Settings",
      noText: "Cancel",
      yesText: "Settings",
      mainColor: AppColors.blue,
      noFunction: () {
        Navigator.pop(context);
      },
      yesFunction: () {
        Navigator.pop(context);
        Geolocator.openAppSettings();
      },
    );
    return null;
  }
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      displayDecisionDialog(
        context,
        titleText: "Location Permission Denied",
        content: "You need to enable Location permission in Settings",
        noText: "Cancel",
        yesText: "Settings",
        mainColor: AppColors.blue,
        noFunction: () {
          Navigator.pop(context);
        },
        yesFunction: () {
          Navigator.pop(context);
          Geolocator.openAppSettings();
        },
      );
      return null;
    }
  }

  Position? position;
  try {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  } on Exception {
    position = null;
    return null;
  }
  if (position != null) {
    return position;
  } else {
    displayAlertDialog(
        title: "Error",
        content: "Something went wrong getting your current location",
        context: context);
  }
}
