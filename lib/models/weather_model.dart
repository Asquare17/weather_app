/*
{
  "weather": [
    {
      "description": "clear sky",
      "icon": "01d"
    }
  ],
  "main": {
    "temp": 282.55,
  },
  
  "name": "Mountain View",
}                     
 */

class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({required this.description, required this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(description: description, icon: icon);
  }
}

class TemperatureInfo {
  final String temperature;
  final String humidity;

  TemperatureInfo({required this.temperature, required this.humidity});

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'].round().toString();
    final humidity = json["humidity"].toString();
    return TemperatureInfo(temperature: temperature, humidity: humidity);
  }
}

class WeatherResponse {
  final String cityName;
  final TemperatureInfo tempInfo;
  final WeatherInfo weatherInfo;
  final String windSpeed;
  final String visibility;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  WeatherResponse(
      {required this.cityName,
      required this.tempInfo,
      required this.windSpeed,
      required this.visibility,
      required this.weatherInfo});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];
    final windSpeed = json['wind']["speed"].toString();
    final tempInfoJson = json['main'];
    final visibility = json["visibility"].toString();

    final tempInfo = TemperatureInfo.fromJson(tempInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);

    return WeatherResponse(
      visibility: visibility,
      cityName: cityName,
      tempInfo: tempInfo,
      weatherInfo: weatherInfo,
      windSpeed: windSpeed,
    );
  }
}

class FiveDaysWeatherResponse {
  final DateTime date;
  final String windSpeed;
  final String visibility;
  final TemperatureInfo tempInfo;
  final WeatherInfo weatherInfo;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  FiveDaysWeatherResponse(
      {required this.date,
      required this.windSpeed,
      required this.visibility,
      required this.tempInfo,
      required this.weatherInfo});

  factory FiveDaysWeatherResponse.fromJson(Map<String, dynamic> json) {
    final date = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);
    final windSpeed = json['wind']["speed"].toString();
    final tempInfoJson = json['main'];
    final visibility = json["visibility"].toString();
    final tempInfo = TemperatureInfo.fromJson(tempInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);

    return FiveDaysWeatherResponse(
      visibility: visibility,
      date: date,
      tempInfo: tempInfo,
      weatherInfo: weatherInfo,
      windSpeed: windSpeed,
    );
  }
}
