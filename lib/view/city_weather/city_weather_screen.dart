import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meteo_sncf/app_colors.dart';
import 'package:meteo_sncf/service/model/city_forecast.dart';
import 'package:meteo_sncf/service/model/weather_reading.dart';
import 'package:meteo_sncf/view/city_weather/city_weather_cubit.dart';
import 'package:meteo_sncf/view/city_weather/city_weather_state.dart';

class CityWeatherScreen extends StatelessWidget {
  const CityWeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bienvenue, Ryan'), scrolledUnderElevation: 0),
      body: BlocConsumer<CityWeatherCubit, CityWeatherState>(
        bloc: CityWeatherCubit(),
        buildWhen: (_, newState) => newState is! CityWeatherFailed,
        builder: (context, state) {
          switch (state) {
            case CityWeatherLoaded():
              return _buildForecastView(state.cityForecast);
            case CityWeatherLoadStarted():
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
        listener: (context, state) {
          if (state is CityWeatherFailed) {
            _showErrorSnackbar(context);
          }
        },
      ),
    );
  }

  Widget _buildForecastView(CityForecast forecast) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Column(
        children: [
          Text(
            forecast.cityName,
            style: TextStyle(
              color: AppColors.actionLightBlue,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: forecast.weatherDays.length,
              itemBuilder: (context, index) {
                final day = forecast.weatherDays[index];
                return Column(
                  children: [
                    Text(
                      DateFormat.MMMMEEEEd().format(day.date),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Min: ${day.minTemp}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Max: ${day.maxTemp}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: day.weatherReadings
                            .map((reading) => _buildIconReadingView(reading))
                            .toList(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconReadingView(WeatherReading reading) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          Text(
            DateFormat.jm().format(reading.date),
            style: const TextStyle(color: Colors.white),
          ),
          Image.network(reading.conditionIconUrl, width: 64, height: 64),
        ],
      ),
    );
  }

  void _showErrorSnackbar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Une erreur est survenue lors du chargement'),
      showCloseIcon: true,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
