import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/common/colors.dart';
import 'package:weather_app/models/city_model.dart';
import 'package:weather_app/providers/city_provider.dart';

class SelectCity extends ConsumerStatefulWidget {
  const SelectCity({Key? key}) : super(key: key);

  @override
  ConsumerState<SelectCity> createState() => _ConsumerSelectCityState();
}

class _ConsumerSelectCityState extends ConsumerState<SelectCity> {
  CityModel? selectedCity;
  @override
  Widget build(BuildContext context) {
    final citiesProv = ref.watch(cityProvider);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.secondaryColor,
        title: const Text("Add city"),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: citiesProv.allCities.length,
        itemBuilder: (BuildContext context, int index) {
          return citiesProv.cities.contains(citiesProv.allCities[index])
              ? const SizedBox()
              : Container(
                  margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: size.height * .08,
                  width: size.width,
                  decoration: BoxDecoration(
                    border: citiesProv.allCities[index] == selectedCity
                        ? Border.all(
                            color: AppColors.secondaryColor.withOpacity(.6),
                            width: 2,
                          )
                        : Border.all(color: AppColors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedCity = citiesProv.allCities[index];
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          citiesProv.allCities[index].city,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        citiesProv.allCities[index] == selectedCity
                            ? const Icon(Icons.check_box_outlined)
                            : const Icon(Icons.check_box_outline_blank),
                      ],
                    ),
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondaryColor,
        child: const Icon(Icons.add),
        onPressed: () {
          if (selectedCity != null) {
            citiesProv.addCity(selectedCity!);
          }
          Navigator.pop(context);
        },
      ),
    );
  }
}
