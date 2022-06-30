import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/models/city_model.dart';
import 'package:weather_app/providers/city_provider.dart';
import 'package:weather_app/ui/components/cities_carousel_widget.dart';
import 'package:weather_app/ui/screens/next_five/next_five_days_screen.dart';

class CitiesCarouselSlider extends ConsumerStatefulWidget {
  const CitiesCarouselSlider({
    Key? key,
  }) : super(key: key);

  @override
  _CitiesCarouselSliderState createState() => _CitiesCarouselSliderState();
}

class _CitiesCarouselSliderState extends ConsumerState<CitiesCarouselSlider> {
  int current = 0;
  List<CityModel> cities = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    final citiesProv = ref.read(cityProvider);
    cities = citiesProv.cities;
  }

  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final citiesProv = ref.watch(cityProvider);
    cities = citiesProv.cities;
    return Container(
      clipBehavior: Clip.none,
      child: Column(
        children: [
          CarouselSlider(
            items: cities
                .map((item) => Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NextFiveDays(city: item)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: CityCarouselWidget(
                              cityModel: item,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 0,
                          child: Visibility(
                            visible: cities.length > 3,
                            child: InkWell(
                              onTap: () {
                                citiesProv.removeCity(item);
                              },
                              child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.grey[300],
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        )
                      ],
                    ))
                .toList(),
            options: CarouselOptions(
                enableInfiniteScroll: false,
                autoPlayCurve: Curves.linear,
                autoPlay: false,
                autoPlayInterval: const Duration(milliseconds: 4500),
                autoPlayAnimationDuration: const Duration(milliseconds: 200),
                pageSnapping: true,
                enlargeCenterPage: true,
                height: 300,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  setState(() {
                    current = index;
                  });
                }),
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            direction: Axis.horizontal,
            children: cities.asMap().entries.map((entry) {
              return InkWell(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: (current == entry.key
                          ? Colors.black
                          : Colors.black26)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
