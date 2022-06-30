import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/helpers/constants.dart';
import 'package:weather_app/models/city_model.dart';
import 'package:weather_app/services/shared_preferences_service.dart';

final cityProvider =
    ChangeNotifierProvider<CityProvider>((ref) => CityProvider());

class CityProvider extends ChangeNotifier {
  CityProvider() {
    loadData();
  }

  void loadData() async {
    loadcities();
    notifyListeners();
  }

  List<CityModel> _cities = [];
  List<CityModel> _allCities = [];
  late CityModel _currentCity;

  List<CityModel> get cities => _cities;
  List<CityModel> get allCities => _allCities;
  CityModel get currentCity => _currentCity;

  void setCities(List<CityModel> value) {
    _cities = value;
    notifyListeners();
  }

  void setAllCities(List<CityModel> value) {
    _allCities = value;
    notifyListeners();
  }

  void setCurrentCity(CityModel value) {
    _currentCity = value;
    notifyListeners();
  }

  void addCity(CityModel value) {
    _cities.add(value);
    final String addressesJson = CityModel.encode(_cities);
    SharedPrefServices.setString('cities', addressesJson);
    notifyListeners();
  }

  void addToAllCity(CityModel value) {
    if (_allCities[0].city != "Current location") {
      _allCities.insert(0, value);
    } else {
      _allCities[0] = value;
    }
    notifyListeners();
  }

  void removeCity(CityModel value) {
    _cities.remove(value);
    final String addressesJson = CityModel.encode(_cities);
    SharedPrefServices.setString('cities', addressesJson);
    notifyListeners();
  }

  loadcities() {
    final String? citiesJson = SharedPrefServices.getString('cities');
    if (citiesJson != null) {
      _cities = CityModel.decode(citiesJson);
    } else {
      _cities = kInitialStateJson
          .map<CityModel>((item) => CityModel.fromJson(item))
          .toList();
    }
    _currentCity = _cities[0];
  }
}
