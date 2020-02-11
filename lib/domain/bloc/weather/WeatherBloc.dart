import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:weather_flutter_app/domain/managers/WeatherManager.dart';
import 'package:weather_flutter_app/domain/models/Weather.dart';

import 'WeatherEvent.dart';
import 'WeatherState.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherManager weatherManager;

  WeatherBloc({@required this.weatherManager}) : assert(weatherManager != null);

  @override
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is LoadWeather) {
      yield* _mapLoadWeatherToState(event);
    }
  }

  Stream<WeatherState> _mapLoadWeatherToState(LoadWeather event) async* {
    yield WeatherLoading();
    try {
      Stream<Weather> weather = weatherManager.getCurrentWeatherCache();
      Stream<List<Weather>> weatherFiveDays =
          weatherManager.getWeatherFiveDaysCache();

      yield WeatherLoaded(
          weather: await weather.last,
          weatherFiveDays: await weatherFiveDays.last);

      weather = weatherManager.getCurrentWeather();
      weatherFiveDays = weatherManager.getWeatherFiveDays();

      yield WeatherLoaded(
          weather: await weather.last,
          weatherFiveDays: await weatherFiveDays.last);
    } catch (_) {
      yield WeatherError();
    }
  }
}
