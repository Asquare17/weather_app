// {
//   "city": "Kuala Lumpur",
//   "lat": "3.1478",
//   "lng": "101.6953",
//   "country": "Malaysia",
//   "iso2": "MY",
//   "admin_name": "Kuala Lumpur",
//   "capital": "primary",
//   "population": "8285000",
//   "population_proper": "1768000"
// },

import 'dart:convert';

import 'package:flutter/material.dart';

class CityModel {
  final String city,
      lat,
      lng,
      country,
      iso2,
      adminName,
      capital,
      population,
      populationProper;

  CityModel({
    required this.city,
    required this.lat,
    required this.lng,
    required this.country,
    required this.iso2,
    required this.adminName,
    required this.capital,
    required this.population,
    required this.populationProper,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    final city = json['city'];
    final lat = json["lat"];
    final lng = json["lng"];
    final country = json["country"];
    final iso2 = json["iso2"];
    final adminName = json["admin_name"];
    final capital = json["capital"];
    final population = json["population"];
    final populationProper = json["population_proper"];

    return CityModel(
        city: city,
        lat: lat,
        lng: lng,
        country: country,
        iso2: iso2,
        adminName: adminName,
        capital: capital,
        population: population,
        populationProper: populationProper);
  }

  Map<String, dynamic> toMap() => {
        "city": city,
        "lat": lat,
        "lng": lng,
        "country": country,
        "iso2": iso2,
        "admin_name": adminName,
        "capital": capital,
        "population": population,
        "population_proper": populationProper
      };
  static String encode(List<CityModel> addresses) => json.encode(
        addresses
            .map<Map<String, dynamic>>((address) => address.toMap())
            .toList(),
      );

  static List<CityModel> decode(String cities) {
    return (json.decode(cities) as List<dynamic>)
        .map<CityModel>((item) => CityModel.fromJson(item))
        .toList();
  }

  @override
  bool operator ==(Object other) => (other is CityModel &&
      (other.lat == lat) &&
      (other.city == city) &&
      (other.lng == lng));

  int get hashCode => hashValues(lat, lng, city);
}
