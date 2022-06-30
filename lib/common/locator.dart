import 'package:get_it/get_it.dart';
import 'package:weather_app/services/database_services.dart';
import 'package:weather_app/services/shared_preferences_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => DatabaseServices());
  locator.registerSingletonAsync<SharedPrefServices>(() async {
    final configService = SharedPrefServices();
    await SharedPrefServices
        .init(); // initializing the singleton class in the locator
    return configService;
  });
}
