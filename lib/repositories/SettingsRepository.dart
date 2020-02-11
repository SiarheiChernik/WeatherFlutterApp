import 'package:flutter/material.dart';

import 'DBProvider.dart';

class SettingsRepository {
  final DBProvider database;

  SettingsRepository({@required this.database}) : assert(database != null);

  saveSettings(String key, String value) async {
    await database.saveData(key, value);
  }

  Future<String> getSettings(String key) async {
    return await database.getData(key);
  }
}
