import 'package:get_it/get_it.dart';
import 'package:meteo_sncf/data/weather/open_weather_repository.dart';
import 'package:meteo_sncf/data/weather/model/forecast_period.dart';
import 'package:meteo_sncf/service/model/city_forecast.dart';
import 'package:meteo_sncf/service/model/sncf_city.dart';
import 'package:meteo_sncf/service/model/weather_day.dart';
import 'package:meteo_sncf/service/model/weather_reading.dart';

class GetForecastForCityUC {
  final _openWeatherRepository = GetIt.I<OpenWeatherRepository>();

  Future<CityForecast> handle(SNCFCity city) {
    return _openWeatherRepository
        .getForecast(latitude: city.latitude, longitude: city.longitude)
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
