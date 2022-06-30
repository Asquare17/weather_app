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

  List<String> dates = [];

  getCityData() async {
    final List<FiveDaysWeatherResponse> responseN =
        await locator<DatabaseServices>()
            .getFiveDaysWeather(widget.city.lat, widget.city.lng);
    setState(() {
      response = responseN;
    });
    for (var item in response!) {
      dates.isEmpty
          ? dates.add(DateFormat('EEEE, dd MMM yyyy').format(item.date))
          : dates.contains(DateFormat('EEEE, dd MMM yyyy').format(item.date))
              ? dates = dates
              : dates.add(DateFormat('EEEE, dd MMM yyyy').format(item.date));
    }
    dates.sort((a, b) => DateFormat("EEEE, dd MMM yyyy")
        .parse(a)
        .compareTo(DateFormat("EEEE, dd MMM yyyy").parse(b)));
  }

  @override
  Widget build(BuildContext context) {
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
                    heightFactor: 6,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator.adaptive(),
                    ))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dates.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              dates[index],
                              // DateFormat('EEE, LLL dd, hh:mm a')
                              //     .format(response![index].date),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 330,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: response!.length,
                                itemBuilder: (context, index2) {
                                  return DateFormat('EEEE, dd MMM yyyy')
                                              .format(response![index2].date) !=
                                          dates[index]
                                      ? const SizedBox()
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Text(
                                                DateFormat('hh:mm a').format(
                                                    response![index2].date),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColors.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: FiveDaysCitiesBox(
                                                    response: response![index2],
                                                    city: widget.city,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                }),
                          ),
                          const SizedBox(
                            height: 30,
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
