import 'package:flutter/material.dart';
import 'package:weather_flutter_app/domain/models/Weather.dart';

import 'DBProvider.dart';

class DataRepository {
  final DBProvider database;

  DataRepository({@required this.database}) : assert(database != null);

  Future<List<Weather>> getWeathers() async {
    return await database.getWeathers();
  }

  insertWeather(Weather weather) async {
    return await database.insertWeather(weather);
  }
}
