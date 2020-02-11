import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_flutter_app/domain/bloc/temperature/TemperatureUnitsBloc.dart';
import 'package:weather_flutter_app/domain/bloc/temperature/TemperatureUnitsEvent.dart';
import 'package:weather_flutter_app/domain/bloc/temperature/TemperatureUnitsState.dart';
import 'package:weather_flutter_app/domain/bloc/themes/ThemeBloc.dart';
import 'package:weather_flutter_app/domain/bloc/themes/ThemeEvent.dart';
import 'package:weather_flutter_app/domain/bloc/themes/ThemeState.dart';
import 'package:weather_flutter_app/domain/enums/TemperatureUnits.dart';
import 'package:weather_flutter_app/domain/enums/ThemesUnits.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: <Widget>[
          BlocBuilder<TemperatureUnitsBloc, TemperatureUnitsState>(
            builder: (context, state) {
              TemperatureUnits _temperatureUnit = state.temperatureUnit;
              return ListTile(
                title: Text(
                  'Temperature',
                ),
                trailing: DropdownButton<TemperatureUnits>(
                  value: _temperatureUnit,
                  icon: Icon(Icons.arrow_downward),
                  items: TemperatureUnits.values
                      .map((TemperatureUnits temperatureUnit) {
                    return new DropdownMenuItem<TemperatureUnits>(
                      value: temperatureUnit,
                      child: new Text(temperatureUnit.toString().split(".")[1]),
                    );
                  }).toList(),
                  onChanged: (TemperatureUnits value) {
                    BlocProvider.of<TemperatureUnitsBloc>(context).add(
                      ChangeTemperatureUnit(temperatureUnit: value),
                    );
                    setState(() {});
                  },
                ),
              );
            },
          ),
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              bool _themesUnit = state.themesUnit == ThemesUnits.dark;
              return ListTile(
                title: Text(
                  'Theme',
                ),
                isThreeLine: true,
                subtitle: Text('Dark mode'),
                trailing: Switch(
                  value: _themesUnit,
                  onChanged: (_) => BlocProvider.of<ThemeBloc>(context).add(
                      ChangeTheme(
                          themesUnit: _themesUnit
                              ? ThemesUnits.light
                              : ThemesUnits.dark)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
