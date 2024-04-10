import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meteo_sncf/service/get_forecast_for_city_uc.dart';
import 'package:meteo_sncf/view/city_weather/city_weather_state.dart';

class CityWeatherCubit extends Cubit<CityWeatherState> {
  CityWeatherCubit() : super(CityWeatherLoadStarted()) {
    _loadForecast();
  }

  void _loadForecast() async {
    try {
      // TODO: Enum des villes avec latitude/longitude
      final forecast = await GetIt.I<GetForecastForCityUC>().handle('Paris');
      emit(CityWeatherLoaded(cityForecast: forecast));
    } catch (_) {
      emit(CityWeatherFailed());
    }
  }
}
