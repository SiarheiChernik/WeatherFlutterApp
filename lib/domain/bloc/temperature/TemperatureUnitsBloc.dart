import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:weather_flutter_app/domain/bloc/temperature/TemperatureUnitsEvent.dart';
import 'package:weather_flutter_app/domain/bloc/temperature/TemperatureUnitsState.dart';
import 'package:weather_flutter_app/domain/enums/TemperatureUnits.dart';
import 'package:weather_flutter_app/domain/managers/SettingsManager.dart';

class TemperatureUnitsBloc
    extends Bloc<TemperatureUnitsEvent, TemperatureUnitsState> {
  final SettingsManager settingsManager;

  TemperatureUnitsBloc({@required this.settingsManager})
      : assert(settingsManager != null);

  @override
  TemperatureUnitsState get initialState =>
      TemperatureUnitsState(temperatureUnit: TemperatureUnits.celsius);

  @override
  Stream<TemperatureUnitsState> mapEventToState(
      TemperatureUnitsEvent event) async* {
    if (event is ChangeTemperatureUnit) {
      yield* _mapChangeTemperatureData(event.temperatureUnit);
    }

    if (event is GetTemperatureUnit) {
      yield* _mapLoadTemperatureData();
    }
  }

  Stream<TemperatureUnitsState> _mapChangeTemperatureData(
      TemperatureUnits temperatureUnit) async* {
    settingsManager.setTemperatureUnit(temperatureUnit: temperatureUnit);

    yield TemperatureUnitsState(temperatureUnit: temperatureUnit);
  }

  Stream<TemperatureUnitsState> _mapLoadTemperatureData() async* {
    try {
      final TemperatureUnits temperatureUnit =
          await settingsManager.getTemperatureUnit();

      yield TemperatureUnitsState(temperatureUnit: temperatureUnit);
    } catch (_) {
      yield TemperatureUnitsState(temperatureUnit: TemperatureUnits.celsius);
    }
  }
}
