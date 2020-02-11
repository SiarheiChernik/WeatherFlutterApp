import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_flutter_app/domain/enums/TemperatureUnits.dart';
import 'package:weather_flutter_app/domain/models/Weather.dart';
import 'package:weather_flutter_app/domain/utils/WeatherUtils.dart';

class WeatherSomeDays extends StatelessWidget {
  final List<Weather> weathers;
  final TemperatureUnits temperatureUnit;

  WeatherSomeDays(
      {Key key, @required this.weathers, @required this.temperatureUnit})
      : assert(weathers != null),
        assert(temperatureUnit != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Center(
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: weathers.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(5.0),
                elevation: 0,
                color: Colors.transparent,
                child: Column(
                  children: [
                    Text(
                      DateFormat('E, K a').format(weathers[index].date),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        WeatherUtils.getIconUrl(
                            iconCode: weathers[index].weatherIcon),
                        height: 60,
                        width: 60,
                      ),
                    ),
                    Text(
                      WeatherUtils.getTemperature(
                          weather: weathers[index],
                          temperatureUnit: temperatureUnit),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
