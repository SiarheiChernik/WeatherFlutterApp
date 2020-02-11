import 'package:flutter/material.dart';
import 'package:weather_flutter_app/domain/enums/TemperatureUnits.dart';
import 'package:weather_flutter_app/domain/models/Weather.dart';
import 'package:weather_flutter_app/domain/utils/WeatherUtils.dart';

class WeatherOneDay extends StatelessWidget {
  final Weather weather;
  final TemperatureUnits temperatureUnit;

  WeatherOneDay(
      {Key key, @required this.weather, @required this.temperatureUnit})
      : assert(weather != null),
        assert(temperatureUnit != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(),
      child: Column(
        children: <Widget>[
          Text(
            weather.weatherDescription.toString(),
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.network(
                  WeatherUtils.getIconUrl(iconCode: weather.weatherIcon),
                  height: 140,
                  width: 140,
                ),
              ),
              Text(
                WeatherUtils.getTemperature(
                    weather: weather, temperatureUnit: temperatureUnit),
                style: TextStyle(
                  fontSize: 72,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
