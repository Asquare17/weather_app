import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/common/colors.dart';
import 'package:weather_app/common/locator.dart';
import 'package:weather_app/models/city_model.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/database_services.dart';
import 'package:weather_app/ui/components/five_days_cities_box.dart';

class NextFiveDays extends StatefulWidget {
  final CityModel city;
  const NextFiveDays({Key? key, required this.city}) : super(key: key);

  @override
  State<NextFiveDays> createState() => _NextFiveDaysState();
}

class _NextFiveDaysState extends State<NextFiveDays> {
  List<FiveDaysWeatherResponse>? response;
  @override
  void initState() {
    getCityData();
    super.initState();
  }

  getCityData() async {
    final List<FiveDaysWeatherResponse> responseN =
        await locator<DatabaseServices>()
            .getFiveDaysWeather(widget.city.lat, widget.city.lng);
    setState(() {
      response = responseN;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.secondaryColor,
        elevation: 0.0,
        title: Text(widget.city.city),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Next five days",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            response == null
                ? const Center(
                    child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: response!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              DateFormat('EEE, LLL dd, ')
                                  .format(response![index].date),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              width: size.width,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: FiveDaysCitiesBox(
                                response: response![index],
                                city: widget.city,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    })
          ],
        ),
      ),
    );
  }
}

class WeatherListTile extends StatelessWidget {
  const WeatherListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Mon 11/23"),
        Image.network(""),
        const Text("Rainy"),
        const Text("11/23")
      ],
    );
  }
}
