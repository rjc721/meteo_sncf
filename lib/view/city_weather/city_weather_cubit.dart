import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meteo_sncf/service/get_forecast_for_city_uc.dart';
import 'package:meteo_sncf/service/model/sncf_city.dart';
import 'package:meteo_sncf/view/city_weather/city_weather_state.dart';

class CityWeatherCubit extends Cubit<CityWeatherState> {
  CityWeatherCubit() : super(CityWeatherInitial()) {
    _loadForecast(state.selectedCity);
  }

  Future<void> _loadForecast(SNCFCity city) async {
    try {
      final forecast = await GetIt.I<GetForecastForCityUC>().handle(city);
      emit(CityWeatherLoaded(selectedCity: city, cityForecast: forecast));
    } catch (_) {
      emit(CityWeatherFailed(selectedCity: state.selectedCity));
    }
  }

  Future<void> refreshWeather() => _loadForecast(state.selectedCity);

  void selectCity(SNCFCity city) => _loadForecast(city);
}
