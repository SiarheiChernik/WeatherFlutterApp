import 'package:flutter/cupertino.dart';
import 'package:weather_flutter_app/domain/enums/TemperatureUnits.dart';
import 'package:weather_flutter_app/domain/enums/ThemesUnits.dart';
import 'package:weather_flutter_app/repositories/SettingsRepository.dart';

class SettingsManager {
  final SettingsRepository settingsRepository;
  final String _temperature = "temperature";
  final String _theme = "theme";

  SettingsManager({@required this.settingsRepository})
      : assert(settingsRepository != null);

  Future<TemperatureUnits> getTemperatureUnit() async {
    final String temperature =
        await settingsRepository.getSettings(_temperature);

    if (TemperatureUnits.kelvin.toString().contains(temperature)) {
      return TemperatureUnits.kelvin;
    }

    if (TemperatureUnits.fahrenheit.toString().contains(temperature)) {
      return TemperatureUnits.fahrenheit;
    }

    if (TemperatureUnits.celsius.toString().contains(temperature)) {
      return TemperatureUnits.celsius;
    }

    return TemperatureUnits.celsius;
  }

  setTemperatureUnit({@required TemperatureUnits temperatureUnit}) async {
    settingsRepository.saveSettings(_temperature, temperatureUnit.toString());
  }

  Future<ThemesUnits> getThemesUnit() async {
    final String theme = await settingsRepository.getSettings(_theme);

    if (ThemesUnits.light.toString().contains(theme)) {
      return ThemesUnits.light;
    } else {
      return ThemesUnits.dark;
    }
  }

  setThemesUnit({@required ThemesUnits themesUnit}) async {
    settingsRepository.saveSettings(_theme, themesUnit.toString());
  }
}
