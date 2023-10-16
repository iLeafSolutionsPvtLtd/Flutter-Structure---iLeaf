// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'weather_repository_mock.dart';

void main() {
  group('WeatherRepository', () {
    test('can be instantiated', () {
      expect(WeatherRepositoryMock(), isNotNull);
    });
    test('Returns weather data when latitude and longitude are valid', () {
      /// Arrange
      final repository = WeatherRepositoryMock();
      const latitude = '37.7749';
      const longitude = '-122.4194';

      /// Act
      final result = repository.fetchCurrentWeather(
        latitude: latitude,
        longitude: longitude,
      );

      /// Assert
      expect(result, completes);
    });
    test('Returns weather data when API response is successful', () async {
      /// Arrange
      final weatherRepository = WeatherRepositoryMock();
      const latitude = '37.7749';
      const longitude = '-122.4194';

      /// Act
      final dynamic result = await weatherRepository.fetchCurrentWeather(
        latitude: latitude,
        longitude: longitude,
      );

      /// Assert
      expect(result, isNotNull);
    });
  });
}
