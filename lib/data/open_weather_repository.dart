import 'package:dio/dio.dart';
import 'package:meteo_sncf/data/model/five_day_forecast.dart';

class OpenWeatherRepository {
  final Dio _dio = Dio(); // TODO: Register in GetIt avec une config
  static const String _weatherApiUrl =
      'http://api.openweathermap.org/data/2.5/forecast';
  static const String _iconApiUrl =
      'https://openweathermap.org/img/wn/:iconName:@2x.png';
  static const String _apiKey = '4d5fbee42b3f530df5abab5f2fa772a6';

  Future<FiveDayForecast> getForecast({
    required double latitude,
    required double longitude,
  }) {
    final params = {
      'lat': latitude,
      'lon': longitude,
      'units': 'metric', // TODO: Permettre la configuration?
      'appid': _apiKey,
    };
    return _dio
        .get(_weatherApiUrl, queryParameters: params)
        .then((resp) => FiveDayForecast.fromJson(resp.data));
  }

  String getIconUrl(String iconName) {
    return _iconApiUrl.replaceAll(':iconName:', iconName);
  }
}
