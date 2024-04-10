import 'package:flutter/material.dart';
import 'package:meteo_sncf/app_theme.dart';
import 'package:meteo_sncf/dependency_register.dart';
import 'package:meteo_sncf/view/login/login_screen.dart';

void main() async {
  await DependencyRegister.register();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
      // home: CityWeatherScreen(),
    );
  }
}
