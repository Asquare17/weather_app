import 'package:flutter/material.dart';
import 'package:weather_app/common/colors.dart';
import 'package:weather_app/common/textstyles.dart';
import 'package:weather_app/helpers/extension.dart';
import 'package:weather_app/models/city_model.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/ui/screens/next_five/next_five_days_screen.dart';

class CitiesBox extends StatelessWidget {
  CitiesBox({
    Key? key,
    required this.city,
    this.response,
  }) : super(key: key);
  CityModel? city;
  WeatherResponse? response;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (city != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NextFiveDays(city: city!)));
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [],
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      response?.cityName ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            response?.tempInfo.temperature.toString() ?? "aa",
                            style: const TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        const Text(
                          'o',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Feels like 24",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: AppColors.white),
                        ),
                        Text(
                          'o',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      response?.weatherInfo.description.capitalize() ?? "",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white),
                    ),
                    Image.network(
                      response?.iconUrl ?? "",
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Wind",
                      style: AppTextStyle.grey12,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "8Km/hr",
                      style: AppTextStyle.black14w7,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Humidity",
                      style: AppTextStyle.grey12,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "27%",
                      style: AppTextStyle.black14w7,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Visibility",
                      style: AppTextStyle.grey12,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "1.8km",
                      style: AppTextStyle.black14w7,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
