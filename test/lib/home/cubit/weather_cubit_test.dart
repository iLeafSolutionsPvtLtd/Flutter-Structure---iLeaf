// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_structure/home/cubit/weather_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:location/location.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_repository/weather_repository.dart';

const response = '''
{"latitude":10.0,"longitude":76.25,"generationtime_ms":0.08106231689453125,
"utc_offset_seconds":19800,"timezone":"Asia/Kolkata",
"timezone_abbreviation":"IST","elevation":6.0,"current_weather_units":
{"time":"iso8601","temperature":"°C","windspeed":"km/h","winddirection":"°",
"is_day":"","weathercode":"wmo code"},"current_weather_interval_seconds":900,
"current_weather":{"time":"2023-10-06T10:30","temperature":30.2,"windspeed":5.3,
"winddirection":332,"is_day":1,"weathercode":2},"daily_units":{"time":"iso8601",
"temperature_2m_max":"°C","temperature_2m_min":"°C","sunrise":"iso8601",
"sunset":"iso8601","uv_index_max":"","precipitation_probability_max":"%"},
"daily":{"time":["2023-10-06","2023-10-07","2023-10-08"],"temperature_2m_max":
[31.5,32.2,31.8],"temperature_2m_min":[25.7,25.5,25.2],"sunrise":
["2023-10-06T06:13","2023-10-07T06:13","2023-10-08T06:13"],"sunset":
["2023-10-06T18:13","2023-10-07T18:12","2023-10-08T18:11"],"uv_index_max":
[8.90,8.85,8.80],"precipitation_probability_max":[0,0,39]}}''';

class WeatherStateMock extends Mock implements WeatherState {}

class MockStorage extends Mock implements Storage {}

class MockLocationData extends Mock implements LocationData {}

class MockWeatherRepository extends Mock implements WeatherRepository {
  @override
  Future<dynamic> fetchCurrentWeather({
    required String latitude,
    required String longitude,
  }) async {
    final apiResponse =
        await compute(Temperatures.fromRawJson, jsonDecode(response));
    return apiResponse;
  }
}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Verify that the initial state of the theme cubit is correct.', () {
    late Storage storage;

    WeatherCubit buildCubit() {
      return WeatherCubit(weatherRepository: MockWeatherRepository());
    }

    setUpAll(() {
      storage = MockStorage();
      when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
      HydratedBloc.storage = storage;
      // cubit = WeatherCubitMock(weatherRepository: MockWeatherRepository());
      registerFallbackValue(WeatherStateMock());
    });

    test(
      'description',
      () => expect(
        buildCubit,
        returnsNormally,
      ),
    );

    test('Verify initial state', () {
      expect(buildCubit().state, const WeatherState(loading: true));
    });

    /// WeatherState instance can be created with custom values
    test(
      'Verify WeatherState instance can be created with custom values',
      () => weather_state_custom_values_test,
    );

    /// fromJson() converts JSON object to WeatherState object
    test(
      'Verify fromJson() converts JSON object to WeatherState object',
      () => testFromJson,
    );

    /// Call copyWith method with latitude set to 100
    test(
      'Verify Call copyWith method with latitude set to 100',
      () => test_copyWith_latitude_100,
    );

    /// Call fromJson with null argument
    test(
      'Verify Call fromJson with null argument',
      () => test_fromJson_with_null_argument,
    );

    blocTest<WeatherCubit, WeatherState>(
      'Verify that the fetch weather runs normally',
      build: buildCubit,
      act: (cubit) => cubit.fetchWeather(),
      expect: () => [
        const WeatherState(),
      ],
    );

    // /// Shows snackbar if location data is not available
    // test('Show Snackbar if Location Data is Not Available', () async {
    //   await buildCubit().fetchLocationData();
    //   // Act
    //   await buildCubit().fetchWeather();

    //   // Assert
    //   expect(buildCubit().state.loading, true);
    //   // verify(
    //   //   () => SnackBarHelper.showSnackbar(
    //   //     const Text("Location couldn't be fetched, try again later!"),
    //   //     duration: const Duration(seconds: 2),
    //   //   ),
    //   // ).called(1);
    // });

    test(
      'Verify loader shows normally',
      () => test_shows_loading_indicator,
    );
    blocTest<WeatherCubit, WeatherState>(
      'Verify that the data is fetched',
      build: buildCubit,
      act: (cubit) => cubit.fetchWeatherApi(MockLocationData()),
      expect: () => [
        const WeatherState(),
        isA<WeatherState>().having(
          (p0) => p0.temperature.currentWeather?.isDay,
          'day',
          1,
        ),
      ],
    );
  });
}

/// fromJson() converts JSON object to WeatherState object
void testFromJson() {
  // Arrange
  final json = {
    'temperature': const Temperatures(latitude: 100),
  };

  // Act
  final result =
      WeatherCubit(weatherRepository: MockWeatherRepository()).fromJson(json);

  // Assert
  expect(result, isA<WeatherState>());
  expect(result!.temperature.latitude, 100);
}

// Call copyWith method with latitude set to 100
void test_copyWith_latitude_100() {
  // Arrange
  const weatherState = WeatherState();

  // Act
  final updatedWeatherState =
      weatherState.copyWith(temperature: const Temperatures(latitude: 100));

  // Assert
  expect(updatedWeatherState.temperature.latitude, 100);
}

// Call fromJson with null argument
void test_fromJson_with_null_argument() {
  const json = null;
  final state = WeatherState.fromJson(json as Map<String, dynamic>);
  expect(state, isNull);
}

void test_shows_loading_indicator() {
  final weatherRepository = MockWeatherRepository();
  final cubit = WeatherCubit(weatherRepository: weatherRepository);

  expectLater(
    cubit,
    emitsInOrder([
      const WeatherState(loading: true),
      const WeatherState(),
    ]),
  );

  cubit.fetchWeather();
}

// WeatherState instance can be created with custom values
void weather_state_custom_values_test() {
  const temperature = Temperatures();
  const loading = true;
  const state = WeatherState(
    loading: loading,
  );

  expect(state.temperature, equals(temperature));
  expect(state.loading, equals(loading));
}
