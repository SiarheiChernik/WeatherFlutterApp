import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  WeatherEvent();
}

class LoadWeather extends WeatherEvent {
  LoadWeather();
}