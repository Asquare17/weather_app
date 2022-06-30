import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/services/shared_preferences_service.dart';
import 'package:weather_app/ui/screens/home/home_screen.dart';
import 'common/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefServices.init();
  await setupLocator();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
