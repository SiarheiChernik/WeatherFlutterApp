import 'package:weather_flutter_app/domain/enums/TemperatureUnits.dart';
import 'package:weather_flutter_app/domain/models/Weather.dart';

class WeatherUtils {
  static String getIconUrl({iconCode: String}) {
    return 'http://openweathermap.org/img/wn/' + iconCode + '@2x.png';
  }

  static String getTemperature(
      {weather: Weather, temperatureUnit: TemperatureUnits}) {
    switch (temperatureUnit) {
      case TemperatureUnits.celsius:
        return weather.temperatureCelsius.round().toString() + "\u2103";
      case TemperatureUnits.fahrenheit:
        return weather.temperatureFahrenheit.round().toString() + "\u2109";
      case TemperatureUnits.kelvin:
        return weather.temperatureKelvin.round().toString() + "\u212A";
    }

    return "";
  }
}
