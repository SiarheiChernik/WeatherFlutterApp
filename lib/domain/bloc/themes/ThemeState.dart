import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_flutter_app/domain/enums/ThemesUnits.dart';

class ThemeState extends Equatable {
  final ThemesUnits themesUnit;

  ThemeState({@required this.themesUnit}) : assert(themesUnit != null);

  @override
  List<Object> get props => [themesUnit];
}
