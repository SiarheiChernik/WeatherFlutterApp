import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_flutter_app/domain/bloc/temperature/TemperatureUnitsBloc.dart';
import 'package:weather_flutter_app/domain/bloc/themes/ThemeBloc.dart';
import 'package:weather_flutter_app/domain/bloc/themes/ThemeState.dart';
import 'package:weather_flutter_app/domain/bloc/weather/WeatherBloc.dart';
import 'package:weather_flutter_app/domain/managers/SettingsManager.dart';
import 'package:weather_flutter_app/domain/managers/WeatherManager.dart';
import 'package:weather_flutter_app/domain/utils/ThemeUtils.dart';
import 'package:weather_flutter_app/repositories/DBProvider.dart';
import 'package:weather_flutter_app/repositories/DataRepository.dart';
import 'package:weather_flutter_app/repositories/SettingsRepository.dart';
import 'package:weather_flutter_app/repositories/WeatherRepository.dart';
import 'package:weather_flutter_app/ui/widgets/Weather.dart';

import 'SimpleBlocDelegate.dart';

void main() {
  final DBProvider _database = DBProvider.db;
  final SettingsRepository _settingsRepository =
      SettingsRepository(database: _database);
  final WeatherRepository _weatherRepository =
      WeatherRepository("e80578c62b40caf8bd44d75cda461c55");
  final DataRepository _dataRepository = DataRepository(database: _database);
  final SettingsManager _settingsManager =
      SettingsManager(settingsRepository: _settingsRepository);
  final WeatherManager _weatherManager = WeatherManager(
      weatherRepository: _weatherRepository, dataRepository: _dataRepository);

  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(settingsManager: _settingsManager),
        ),
        BlocProvider<TemperatureUnitsBloc>(
          create: (context) =>
              TemperatureUnitsBloc(settingsManager: _settingsManager),
        ),
      ],
      child: MyApp(weatherManager: _weatherManager),
    ),
  );
}

class MyApp extends StatelessWidget {
  final WeatherManager weatherManager;

  MyApp({Key key, @required this.weatherManager})
      : assert(weatherManager != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          theme: ThemeUtils.getThemeData(theme: themeState.themesUnit),
          home: BlocProvider(
            create: (context) => WeatherBloc(
              weatherManager: weatherManager,
            ),
            child: Weather(),
          ),
        );
      },
    );
  }
}
