import 'package:weather/weather.dart' as lib;
import 'package:weather_flutter_app/domain/models/Weather.dart';

class WeatherRepository {
  lib.WeatherStation _weatherStation;

  WeatherRepository(apiKey) {
    _weatherStation = lib.WeatherStation(apiKey);
  }

  Future<Weather> getCurrentWeather() async {
    final lib.Weather weather = await _weatherStation.currentWeather();

    return _getWeather(0, weather);
  }

  Future<List<Weather>> getWeatherFiveDays() async {
    final List<Weather> resWeathers = new List();
    final List<lib.Weather> weathers = await _weatherStation.fiveDayForecast();

    int id = 0;
    for (final weather in weathers) {
      id++;

      resWeathers.add(_getWeather(id, weather));
    }

    return resWeathers;
  }

  Weather _getWeather(int id, lib.Weather weather) {
    return Weather(
        id,
        weather.weatherDescription,
        weather.weatherIcon,
        weather.date,
        weather.areaName,
        weather.temperature.celsius,
        weather.temperature.fahrenheit,
        weather.temperature.kelvin);
  }
}
