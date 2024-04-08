class WeatherReading {
  final DateTime date;
  final int temperature;
  final String conditionIconUrl;
  final double precipitationPercent;
  final int maxTemp;
  final int minTemp;

  WeatherReading({
    required this.date,
    required this.temperature,
    required this.conditionIconUrl,
    required this.precipitationPercent,
    required this.maxTemp,
    required this.minTemp,
  });
}
