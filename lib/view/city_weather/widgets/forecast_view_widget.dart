import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meteo_sncf/app_colors.dart';
import 'package:meteo_sncf/service/model/city_forecast.dart';
import 'package:meteo_sncf/view/city_weather/widgets/icon_weather_reading_widget.dart';

class ForecastViewWidget extends StatelessWidget {
  final CityForecast forecast;
  final Future<void> Function() onPullToRefresh;

  const ForecastViewWidget({
    super.key,
    required this.forecast,
    required this.onPullToRefresh,
  });

  @override
  Widget build(BuildContext context) {
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
            child: RefreshIndicator(
              onRefresh: onPullToRefresh,
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(height: 30),
                itemCount: forecast.weatherDays.length,
                itemBuilder: (context, index) {
                  final day = forecast.weatherDays[index];
                  return Column(
                    children: [
                      Text(
                        DateFormat.MMMMEEEEd().format(day.date),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Min: ${day.minTemp}°',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Max: ${day.maxTemp}°',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: day.weatherReadings
                              .map((reading) =>
                                  IconWeatherReadingWidget(reading: reading))
                              .toList(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
