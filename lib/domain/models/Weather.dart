class Weather {
  final int id;
  final String weatherDescription;
  final String weatherIcon;
  final DateTime date;
  final String areaName;
  final double temperatureCelsius;
  final double temperatureFahrenheit;
  final double temperatureKelvin;

  Weather(
      this.id,
      this.weatherDescription,
      this.weatherIcon,
      this.date,
      this.areaName,
      this.temperatureCelsius,
      this.temperatureFahrenheit,
      this.temperatureKelvin);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'weatherDescription': weatherDescription,
      'weatherIcon': weatherIcon,
      'date': date.toIso8601String(),
      'areaName': areaName,
      'temperatureCelsius': temperatureCelsius,
      'temperatureFahrenheit': temperatureFahrenheit,
      'temperatureKelvin': temperatureKelvin,
    };
  }
}
