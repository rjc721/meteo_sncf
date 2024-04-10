import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_sncf/app_colors.dart';
import 'package:meteo_sncf/view/city_weather/city_weather_cubit.dart';
import 'package:meteo_sncf/view/city_weather/city_weather_state.dart';
import 'package:meteo_sncf/view/city_weather/widgets/forecast_view_widget.dart';
import 'package:meteo_sncf/view/login/login_screen.dart';

class CityWeatherScreen extends StatelessWidget {
  final String userName;

  const CityWeatherScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Bienvenue, ${userName}'),
          actions: [
            IconButton(
                onPressed: () => _logout(context),
                icon: Icon(
                  Icons.logout_outlined,
                  color: AppColors.actionLightBlue,
                )),
          ],
          scrolledUnderElevation: 0),
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

  void _logout(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
