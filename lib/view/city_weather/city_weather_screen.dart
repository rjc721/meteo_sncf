import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_sncf/app_colors.dart';
import 'package:meteo_sncf/service/model/sncf_city.dart';
import 'package:meteo_sncf/view/city_weather/city_weather_cubit.dart';
import 'package:meteo_sncf/view/city_weather/city_weather_state.dart';
import 'package:meteo_sncf/view/city_weather/widgets/forecast_view_widget.dart';
import 'package:meteo_sncf/view/login/login_screen.dart';

class CityWeatherScreen extends StatelessWidget {
  final String userName;
  final CityWeatherCubit _weatherCubit = CityWeatherCubit();

  CityWeatherScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CityWeatherCubit, CityWeatherState>(
      bloc: _weatherCubit,
      buildWhen: (_, newState) => newState is! CityWeatherFailed,
      listener: (context, state) {
        if (state is CityWeatherFailed) {
          _showErrorSnackbar(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Bienvenue, ${userName}'),
            actions: [
              PopupMenuButton<SNCFCity>(
                  initialValue: state.selectedCity,
                  onSelected: (SNCFCity city) {
                    _weatherCubit.selectCity(city);
                  },
                  itemBuilder: (BuildContext context) => SNCFCity.values
                      .map((city) => PopupMenuItem<SNCFCity>(
                            value: city,
                            child: Text(city.name),
                          ))
                      .toList()),
              IconButton(
                onPressed: () => _logout(context),
                icon: Icon(Icons.logout_outlined,
                    color: AppColors.actionLightBlue),
              ),
            ],
            scrolledUnderElevation: 0,
          ),
          body: _buildBodyForState(state),
        );
      },
    );
  }

  Widget _buildBodyForState(CityWeatherState state) {
    switch (state) {
      case CityWeatherLoaded():
        return ForecastViewWidget(forecast: state.cityForecast);
      case CityWeatherLoadStarted():
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }

  void _showErrorSnackbar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Une erreur est survenue lors du chargement'),
      showCloseIcon: true,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _logout(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
