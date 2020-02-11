import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_flutter_app/domain/enums/TemperatureUnits.dart';

class TemperatureUnitsState extends Equatable {
  final TemperatureUnits temperatureUnit;

  TemperatureUnitsState({@required this.temperatureUnit})
      : assert(temperatureUnit != null);

  @override
  List<Object> get props => [temperatureUnit];
}
