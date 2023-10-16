// ignore_for_file: one_member_abstracts

import 'package:network_repository/network_repository.dart';
import 'package:weather_repository/src/models/weather.dart';

///
/// The `WeatherRepository` class is a sealed class that represents a repository
///  for fetching current weather data.
/// It has a single method `fetchCurrentWeather` that takes latitude and
/// longitude as required parameters and returns a `Future` of dynamic type.
abstract class WeatherRepository {
  /// Fetches the current weather data based on latitude and longitude
  /// coordinates.
  ///
  /// @param latitude The latitude coordinate.
  /// @param longitude The longitude coordinate.
  /// @return A `Future` of dynamic type representing the weather data.
  Future<dynamic> fetchCurrentWeather({
    required String latitude,
    required String longitude,
  });
}

/// The implementation of the `WeatherRepository` class.
class WeatherRepositoryImpl implements WeatherRepository {
  /// Fetches the current weather data based on latitude and longitude
  ///  coordinates.
  ///
  /// @param latitude The latitude coordinate.
  /// @param longitude The longitude coordinate.
  /// @return A `Future` of dynamic type representing the weather data.
  @override
  Future<dynamic> fetchCurrentWeather({
    required String latitude,
    required String longitude,
  }) async {
    final dynamic response = await NetworkAdapter.shared.send(
      endPoint: EndPoint.forecast,
      params: {
        'latitude': latitude,
        'longitude': longitude,
        'current_weather': 'true',
        'daily': '''
temperature_2m_max,temperature_2m_min,sunrise,sunset,uv_index_max,
precipitation_probability_max,''',
        'timezone': 'auto',
        'forecast_days': '1',
      },
    );
    if (response is Response) {
      final apiResponse =
          await compute(Temperatures.fromRawJson, response.body);
      // log('$apiResponse');
      return apiResponse;
    } else {
      final apiResponse = await compute(Temperatures.fromRawJson, response);
      // log('$apiResponse');
      return apiResponse;
    }
  }
}
