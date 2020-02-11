import 'package:flutter/cupertino.dart';
import 'package:weather_flutter_app/domain/models/Weather.dart';
import 'package:weather_flutter_app/repositories/DataRepository.dart';
import 'package:weather_flutter_app/repositories/WeatherRepository.dart';

class WeatherManager {
  final WeatherRepository weatherRepository;
  final DataRepository dataRepository;

  WeatherManager(
      {@required this.weatherRepository, @required this.dataRepository})
      : assert(weatherRepository != null),
        assert(dataRepository != null);

  Stream<Weather> getCurrentWeather() async* {
    final Weather weather = await weatherRepository.getCurrentWeather();

    dataRepository.insertWeather(weather);

    yield weather;
  }

  Stream<Weather> getCurrentWeatherCache() async* {
    final List<Weather> weathers = await dataRepository.getWeathers();

    if (weathers.isNotEmpty) {
      yield weathers[0];
    }
  }

  Stream<List<Weather>> getWeatherFiveDays() async* {
    final List<Weather> newWeathers =
        await weatherRepository.getWeatherFiveDays();

    yield newWeathers;
  }

  Stream<List<Weather>> getWeatherFiveDaysCache() async* {
    final List<Weather> weathers = await dataRepository.getWeathers();

    if (weathers.isNotEmpty) {
      weathers.removeAt(0);
      yield weathers;
    }
  }
}
