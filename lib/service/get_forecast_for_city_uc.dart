import 'package:meteo_sncf/data/model/forecast_period.dart';
import 'package:meteo_sncf/data/open_weather_repository.dart';
import 'package:meteo_sncf/service/model/city_forecast.dart';
import 'package:meteo_sncf/service/model/weather_day.dart';
import 'package:meteo_sncf/service/model/weather_reading.dart';

class GetForecastForCityUC {
  final OpenWeatherRepository _openWeatherRepository = OpenWeatherRepository();

  Future<CityForecast> handle(String cityName) {
    // TODO: Handle doing the geocode for the city coordinates
    return _openWeatherRepository
        .getForecast(latitude: 48.8543789, longitude: 2.3418425)
        .then((fiveDayForecast) {
      final weatherReadings = fiveDayForecast.periodList
          .map((period) => _getWeatherReadingsForForecastPeriod(period));
      final weatherDays = _splitReadingsIntoWeatherDays(weatherReadings);
      weatherDays.sort((day1, day2) => day1.date.compareTo(day2.date));

      return CityForecast(
        cityName: fiveDayForecast.city.name,
        weatherDays: weatherDays,
      );
    });
  }

  WeatherReading _getWeatherReadingsForForecastPeriod(ForecastPeriod period) {
    return WeatherReading(
      date: DateTime.fromMillisecondsSinceEpoch(period.timestamp * 1000),
      temperature: period.tempPressureConditions.temp.round(),
      conditionIconUrl:
          _openWeatherRepository.getIconUrl(period.weather.first.icon),
      precipitationPercent: period.precipProbability,
      maxTemp: period.tempPressureConditions.maxTemperature.round(),
      minTemp: period.tempPressureConditions.minTemperature.round(),
    );
  }

  List<WeatherDay> _splitReadingsIntoWeatherDays(
    Iterable<WeatherReading> weatherReadings,
  ) {
    var weatherDayMap = <DateTime, List<WeatherReading>>{};
    for (var reading in weatherReadings) {
      final normalizedDate = DateTime(
        reading.date.year,
        reading.date.month,
        reading.date.day,
      );
      (weatherDayMap[normalizedDate] ??= []).add(reading);
    }

    return weatherDayMap.entries.map((entry) {
      return WeatherDay(date: entry.key, weatherReadings: entry.value);
    }).toList();
  }
}
