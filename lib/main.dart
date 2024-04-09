import 'package:flutter/material.dart';
import 'package:meteo_sncf/app_theme.dart';
import 'package:meteo_sncf/view/city_weather/city_weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: CityWeatherScreen(),
    );
  }
}
