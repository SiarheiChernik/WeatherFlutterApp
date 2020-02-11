import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_flutter_app/domain/enums/TemperatureUnits.dart';

abstract class TemperatureUnitsEvent extends Equatable {
  TemperatureUnitsEvent();
}

class ChangeTemperatureUnit extends TemperatureUnitsEvent {
  final TemperatureUnits temperatureUnit;

  ChangeTemperatureUnit({@required this.temperatureUnit})
      : assert(temperatureUnit != null);

  @override
  List<Object> get props => [temperatureUnit];
}

class GetTemperatureUnit extends TemperatureUnitsEvent {
  GetTemperatureUnit();

  @override
  List<Object> get props => [];
}
