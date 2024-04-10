import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_sncf/view/city_weather/city_weather_cubit.dart';
import 'package:meteo_sncf/view/city_weather/city_weather_state.dart';
import 'package:meteo_sncf/view/city_weather/widgets/forecast_view_widget.dart';

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
              return ForecastViewWidget(forecast: state.cityForecast);
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

  void _showErrorSnackbar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Une erreur est survenue lors du chargement'),
      showCloseIcon: true,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
