import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/common/colors.dart';
import 'package:weather_app/common/locator.dart';
import 'package:weather_app/common/textStyles.dart';
import 'package:weather_app/helpers/extension.dart';
import 'package:weather_app/models/city_model.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/database_services.dart';

class CityCarouselWidget extends ConsumerStatefulWidget {
  CityCarouselWidget({Key? key, required this.cityModel}) : super(key: key);
  CityModel cityModel;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CityCarouselWidgetState();
}

class _CityCarouselWidgetState extends ConsumerState<CityCarouselWidget> {
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  void initState() {
    getCityData();
    super.initState();
  }

  WeatherResponse? response;
  getCityData() async {
    final WeatherResponse responseN = await locator<DatabaseServices>()
        .getCurrentWeather(widget.cityModel.lat, widget.cityModel.lng);
    setState(() {
      response = responseN;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Create a size variable for the mdeia query
    Size size = MediaQuery.of(context).size;
    return response == null
        ? const CircularProgressIndicator()
        : Container(
            padding: const EdgeInsets.all(20),
            width: size.width,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(20),
              // boxShadow: [
              //   BoxShadow(
              //     color: AppColors.primaryColor.withOpacity(.5),
              //     offset: const Offset(0, 25),
              //     blurRadius: 10,
              //     spreadRadius: -12,
              //   )
              // ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [],
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                  response?.tempInfo.temperature.toString() ??
                                      "",
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
                            response?.weatherInfo.description.capitalize() ??
                                "",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white),
                          ),
                          Image.network(
                            response!.iconUrl,
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
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
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
                            height: 6,
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
                            height: 6,
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
                            height: 6,
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
