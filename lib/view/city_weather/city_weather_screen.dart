import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meteo_sncf/service/get_forecast_for_city_uc.dart';
import 'package:meteo_sncf/service/model/city_forecast.dart';

class CityWeatherScreen extends StatelessWidget {
  // TODO: GetIt plus Cubit
  final GetForecastForCityUC _getForecastForCityUC = GetForecastForCityUC();

  CityWeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Welcome, Ryan'),
      ),
      // TODO: Cubit et bloc
      body: FutureBuilder<CityForecast?>(
          future: _getForecastForCityUC.handle('Paris'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();

            final forecast = snapshot.data;

            if (forecast == null || snapshot.hasError) {
              return const Text(
                'Oops we had a problem loading the weather for this location',
              );
            }

            return Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
              ),
              child: Column(
                children: [
                  Text(
                    forecast.cityName,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          Divider(color: Colors.black.withOpacity(0.1)),
                      itemCount: forecast.weatherDays.length,
                      itemBuilder: (context, index) {
                        final day = forecast.weatherDays[index];
                        return Column(
                          children: [
                            Text(
                              DateFormat.MMMMEEEEd().format(day.date),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Min: ${day.minTemp}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  'Max: ${day.maxTemp}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: day.weatherReadings
                                    .map((reading) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: Column(
                                            children: [
                                              Text(DateFormat.jm()
                                                  .format(reading.date)),
                                              Image.network(
                                                reading.conditionIconUrl,
                                                width: 64,
                                                height: 64,
                                              ),
                                            ],
                                          ),
                                        ))
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
          }),
    );
  }
}
