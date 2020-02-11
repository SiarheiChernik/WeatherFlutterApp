import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_flutter_app/domain/models/Weather.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  static const String TABLE_SETTINGS = "Settings";
  static const String COLUMN_KEY = "key";
  static const String COLUMN_VALUE = "value";

  static const String TABLE_WEATHERS = "Weathers";
  static const String COLUMN_ID = "id";
  static const String COLUMN_DESCRIPTION = "weatherDescription";
  static const String COLUMN_ICON = "weatherIcon";
  static const String COLUMN_DATE = "date";
  static const String COLUMN_AREA = "areaName";
  static const String COLUMN_CELSIUS = "temperatureCelsius";
  static const String COLUMN_FAHRENHEIT = "temperatureFahrenheit";
  static const String COLUMN_KELVIN = "temperatureKelvin";

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    final String documentsDirectory = await getDatabasesPath();
    final String path = join(documentsDirectory, "WeatherDB.db");
    const String SETTINGS = "CREATE TABLE " +
        TABLE_SETTINGS +
        " (" +
        COLUMN_KEY +
        " TEXT," +
        COLUMN_VALUE +
        " TEXT"
            ")";

    const String WEATHER = "CREATE TABLE " +
        TABLE_WEATHERS +
        " (" +
        "id INTEGER PRIMARY KEY," +
        COLUMN_DESCRIPTION +
        " TEXT," +
        COLUMN_ICON +
        " TEXT," +
        COLUMN_DATE +
        " TEXT," +
        COLUMN_AREA +
        " TEXT," +
        COLUMN_CELSIUS +
        " REAL," +
        COLUMN_FAHRENHEIT +
        " REAL," +
        COLUMN_KELVIN +
        " REAL"
            ")";

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(SETTINGS);
      await db.execute(WEATHER);
    });
  }

  Future<void> insertWeather(Weather weather) async {
    final db = await database;

    await db.insert(
      TABLE_WEATHERS,
      weather.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Weather>> getWeathers() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(TABLE_WEATHERS);

    return List.generate(maps.length, (i) {
      return Weather(
        maps[i][COLUMN_ID],
        maps[i][COLUMN_DESCRIPTION],
        maps[i][COLUMN_ICON],
        DateTime.parse(maps[i][COLUMN_DATE]),
        maps[i][COLUMN_AREA],
        double.parse(maps[i][COLUMN_CELSIUS]),
        double.parse(maps[i][COLUMN_FAHRENHEIT]),
        double.parse(maps[i][COLUMN_KELVIN]),
      );
    });
  }

  Future<void> saveData(String key, String value) async {
    final db = await database;
    final String data = await getData(key);

    if (data == null) {
      return await db.insert(
          TABLE_SETTINGS,
          {
            COLUMN_KEY: key,
            COLUMN_VALUE: value,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      return await db.update(
          TABLE_SETTINGS,
          {
            COLUMN_KEY: key,
            COLUMN_VALUE: value,
          },
          where: COLUMN_KEY + " = ?",
          whereArgs: [key],
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<String> getData(String key) async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps = await db
          .query(TABLE_SETTINGS, where: COLUMN_KEY + " = ?", whereArgs: [key]);
      final List<Map<String, String>> results = List.generate(maps.length, (i) {
        return {
          COLUMN_KEY: maps[i][COLUMN_KEY],
          COLUMN_VALUE: maps[i][COLUMN_VALUE]
        };
      });

      return results[0][COLUMN_VALUE];
    } catch (_) {
      return null;
    }
  }
}
