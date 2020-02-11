import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_flutter_app/domain/bloc/temperature/TemperatureUnitsBloc.dart';
import 'package:weather_flutter_app/domain/bloc/temperature/TemperatureUnitsEvent.dart';
import 'package:weather_flutter_app/domain/bloc/temperature/TemperatureUnitsState.dart';
import 'package:weather_flutter_app/domain/bloc/themes/ThemeBloc.dart';
import 'package:weather_flutter_app/domain/bloc/themes/ThemeEvent.dart';
import 'package:weather_flutter_app/domain/bloc/weather/WeatherBloc.dart';
import 'package:weather_flutter_app/domain/bloc/weather/WeatherEvent.dart';
import 'package:weather_flutter_app/domain/bloc/weather/WeatherState.dart';
import 'package:weather_flutter_app/ui/widgets/CurrentLocation.dart';
import 'package:weather_flutter_app/ui/widgets/Settings.dart';
import 'package:weather_flutter_app/ui/widgets/WeatherOneDay.dart';
import 'package:weather_flutter_app/ui/widgets/WeatherSomeDays.dart';

class Weather extends StatefulWidget {
  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();

    BlocProvider.of<ThemeBloc>(context).add(
      GetThemeUnit(),
    );

    BlocProvider.of<TemperatureUnitsBloc>(context).add(
      GetTemperatureUnit(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          },
          child:
              BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
            if (state is WeatherLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is WeatherLoaded) {
              final weather = state.weather;
              final weatherFiveDays = state.weatherFiveDays;

              return RefreshIndicator(
                onRefresh: () {
                  BlocProvider.of<WeatherBloc>(context).add(
                    LoadWeather(),
                  );
                  return _refreshCompleter.future;
                },
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 32.0),
                      child: CurrentLocation(currentLocation: weather.areaName),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
                      child: BlocBuilder<TemperatureUnitsBloc,
                          TemperatureUnitsState>(builder: (context, state) {
                        return WeatherOneDay(
                            weather: weather,
                            temperatureUnit: state.temperatureUnit);
                      }),
                    ),
                    BlocBuilder<TemperatureUnitsBloc, TemperatureUnitsState>(
                        builder: (context, state) {
                      return WeatherSomeDays(
                          weathers: weatherFiveDays,
                          temperatureUnit: state.temperatureUnit);
                    }),
                  ],
                ),
              );
            }

            if (state is WeatherEmpty) {
              BlocProvider.of<WeatherBloc>(context).add(
                LoadWeather(),
              );
            }

            if (state is WeatherError) {
              return Center(
                  child: Text(
                'Weather Error!',
                style: TextStyle(color: Colors.red),
              ));
            }

            return Center(
                child: Text(
              'Something wrong!',
              style: TextStyle(color: Colors.red),
            ));
          }),
        ),
      ),
    );
  }
}
