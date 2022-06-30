import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/common/colors.dart';
import 'package:weather_app/common/load_json.dart';
import 'package:weather_app/common/locator.dart';

import 'package:weather_app/models/city_model.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/city_provider.dart';
import 'package:weather_app/services/database_services.dart';
import 'package:weather_app/ui/components/carousel_slider.dart';
import 'package:weather_app/ui/components/cities_box.dart';
import 'package:weather_app/ui/screens/current_location/use_current_location.dart';
import 'package:weather_app/ui/screens/select_city/select_city_screen.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<Home> createState() => _ConsumerHomeState();
}

class _ConsumerHomeState extends ConsumerState<Home> {
  //initiatilization
  int temperature = 0;
  int maxTemp = 0;

  int humidity = 0;
  int windSpeed = 0;
  CityModel? selectedCity;
  WeatherResponse? response;
  getData() {
    final citiesProv = ref.read(cityProvider);
    selectedCity = citiesProv.currentCity;
    getCityData();
  }

  getCityData() async {
    if (selectedCity != null) {
      final WeatherResponse responseN = await locator<DatabaseServices>()
          .getCurrentWeather(selectedCity!.lat, selectedCity!.lng);
      setState(() {
        response = responseN;
      });
    }
  }

  getJsonData() async {
    final citiesProv = ref.read(cityProvider);

    var jsonData = await loadJsonData();
    var cities = jsonData.map((e) => CityModel.fromJson(e)).toList();
    citiesProv.setAllCities(cities);
  }

  List consolidatedWeatherList = []; //To hold our weather data after api call

  @override
  void initState() {
    getData();
    getJsonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final citiesProv = ref.watch(cityProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_pin,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                            value: selectedCity,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: citiesProv.allCities.map((CityModel city) {
                              return DropdownMenuItem(
                                  value: city, child: Text(city.city));
                            }).toList(),
                            onChanged: (CityModel? newValue) {
                              setState(() {
                                selectedCity = newValue ?? selectedCity;
                                getCityData();
                              });
                            }),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () async {
                          var position = await getCurrentLocation(context);
                          if (position != null) {
                            CityModel currentCity = CityModel(
                              city: "Current location",
                              lat: position.latitude.toString(),
                              lng: position.longitude.toString(),
                              country: "country",
                              iso2: "iso2",
                              adminName: "adminName",
                              capital: "capital",
                              population: "population",
                              populationProper: "populationProper",
                            );
                            final citiesProv = ref.read(cityProvider);
                            citiesProv.addToAllCity(currentCity);
                            setState(() {
                              selectedCity = currentCity;
                            });
                            getCityData();
                          }
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.my_location_outlined,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Current location"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Your Favorites",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SelectCity()));
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.add),
                            Text(
                              "Add city",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const CitiesCarouselSlider(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    selectedCity?.city ?? "loading",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
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
                    child: response == null
                        ? Center(
                            child: const CircularProgressIndicator.adaptive(),
                          )
                        : SingleChildScrollView(
                            child: CitiesBox(
                              response: response,
                              city: selectedCity,
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
