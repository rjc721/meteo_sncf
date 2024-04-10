import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'SNCF Connect Météo',
      theme: AppTheme.theme,
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
      // home: CityWeatherScreen(),
    );
  }
}
