import 'package:flutter/material.dart';
import 'package:weather_flutter_app/domain/enums/ThemesUnits.dart';

class ThemeUtils {
  static ThemeData getThemeData({@required ThemesUnits theme}) {
    if (theme == ThemesUnits.light) {
      return ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.deepOrangeAccent,
          primaryColorDark: Colors.deepOrange,
          accentColor: Colors.orangeAccent);
    } else {
      return ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blueGrey[999],
          primaryColorDark: Colors.blueGrey,
          accentColor: Colors.white);
    }
  }
}
