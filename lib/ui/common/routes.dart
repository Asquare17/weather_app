import 'dart:core';
import 'package:flutter/material.dart';

class RouteFinding {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => MyApp());
      // case otpScreen:
      //   {
      //     Map<String, dynamic> args =
      //         settings.arguments as Map<String, dynamic>;
      //     return MaterialPageRoute(
      //         builder: (_) => OTPScreen(
      //               phoneNumber: args["phoneNumber"],
      //               userSelectedCountry: args["userSelectedCountry"],
      //               countryCode: args["countryCode"],
      //             ));
      //   }

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

const splashScreen = '/';
const introScreen = "/intro_screen";
