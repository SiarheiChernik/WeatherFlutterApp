import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_flutter_app/domain/models/Weather.dart';

abstract class WeatherState extends Equatable {
  WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  final List<Weather> weatherFiveDays;

  WeatherLoaded({@required this.weather, @required this.weatherFiveDays})
      : assert(weather != null),
        assert(weatherFiveDays != null);

  @override
  List<Object> get props => [weather, weatherFiveDays];
}

class WeatherError extends WeatherState {}
