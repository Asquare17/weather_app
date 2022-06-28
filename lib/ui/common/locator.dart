import 'package:get_it/get_it.dart';
import 'package:weather_app/services/shared_preferences_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => SharedPrefServices());
  locator.registerLazySingleton(() => DatabaseServices());
}
