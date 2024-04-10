import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meteo_sncf/service/model/weather_reading.dart';

class IconWeatherReadingWidget extends StatelessWidget {
  final WeatherReading reading;

  const IconWeatherReadingWidget({super.key, required this.reading});

  @override
  Widget build(BuildContext context) {
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
}
