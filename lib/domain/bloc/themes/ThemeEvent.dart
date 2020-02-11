import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_flutter_app/domain/enums/ThemesUnits.dart';

abstract class ThemeEvent extends Equatable {
  ThemeEvent();
}

class ChangeTheme extends ThemeEvent {
  final ThemesUnits themesUnit;

  ChangeTheme({@required this.themesUnit}) : assert(themesUnit != null);

  @override
  List<Object> get props => [themesUnit];
}

class GetThemeUnit extends ThemeEvent {
  GetThemeUnit();

  @override
  List<Object> get props => [];
}
