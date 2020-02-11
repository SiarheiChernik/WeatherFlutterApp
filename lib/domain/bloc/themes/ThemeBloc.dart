import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:weather_flutter_app/domain/bloc/themes/ThemeEvent.dart';
import 'package:weather_flutter_app/domain/bloc/themes/ThemeState.dart';
import 'package:weather_flutter_app/domain/enums/ThemesUnits.dart';
import 'package:weather_flutter_app/domain/managers/SettingsManager.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SettingsManager settingsManager;

  ThemeBloc({@required this.settingsManager}) : assert(settingsManager != null);

  @override
  ThemeState get initialState => ThemeState(themesUnit: ThemesUnits.light);

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ChangeTheme) {
      yield* _mapChangeThemeData(event.themesUnit);
    }

    if (event is GetThemeUnit) {
      yield* _mapLoadThemeData();
    }
  }

  Stream<ThemeState> _mapChangeThemeData(ThemesUnits themesUnit) async* {
    settingsManager.setThemesUnit(themesUnit: themesUnit);

    yield ThemeState(themesUnit: themesUnit);
  }

  Stream<ThemeState> _mapLoadThemeData() async* {
    try {
      final ThemesUnits themesUnit = await settingsManager.getThemesUnit();

      yield ThemeState(themesUnit: themesUnit);
    } catch (_) {
      yield ThemeState(themesUnit: ThemesUnits.light);
    }
  }
}
