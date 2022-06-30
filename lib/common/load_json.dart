import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<dynamic>> loadJsonData() async {
  var jsonText = await rootBundle.loadString('assets/cities.json');
  List<dynamic> data = json.decode(jsonText);
  return data;
}
