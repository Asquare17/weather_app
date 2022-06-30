import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/helpers/constants.dart';
import 'package:weather_app/models/weather_model.dart';

class DatabaseServices {
  Future<List<FiveDaysWeatherResponse>> getFiveDaysWeather(
      String lat, String lng) async {
    final queryParameters = {
      'lat': lat,
      "lon": lng,
      'appid': appId,
      'units': 'standard'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/forecast', queryParameters);

    final response = await http.get(uri);

    final List json = jsonDecode(response.body)["list"];
    return json.map((e) => FiveDaysWeatherResponse.fromJson(e)).toList();
  }

  Future<WeatherResponse> getCurrentWeather(String lat, String lng) async {
    final queryParameters = {
      'lat': lat,
      "lon": lng,
      'appid': appId,
      'units': 'standard'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}
