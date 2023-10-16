import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_structure/helpers/colors.dart';
import 'package:flutter_structure/helpers/location.dart';
import 'package:flutter_structure/helpers/snackbar.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:location/location.dart';
import 'package:weather_repository/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends HydratedCubit<WeatherState> {
  WeatherCubit({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(const WeatherState()) {
    fetchWeather();
  }
  final WeatherRepository _weatherRepository;

  /// Fetches the current weather data using the weather repository.
  ///
  /// It first shows a loading indicator, then fetches the user's location.
  /// If the location is not available, it shows a snackbar with an error
  /// message.
  /// If the location is available, it fetches the weather data using the
  /// weather repository
  /// and updates the state with the fetched data.
  /// Finally, it hides the loading indicator.
  Future<void> fetchWeather() async {
    // final isTest = Platform.environment.containsKey('FLUTTER_TEST');
    try {
      emit(state.copyWith(loading: true));
      LocationData? locationData;
      try {
        locationData = await fetchLocationData();
      } on Exception catch (_) {
        locationData = null;
      }
      if (locationData == null) {
        emit(state.copyWith(loading: false));
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          SnackBarHelper.showSnackbar(
            const Text("Location couldn't be fetched, try again later!"),
            backgroundColor: AppColors.baseColorLight,
            duration: const Duration(seconds: 2),
          );
        });
        return;
      }
      await fetchWeatherApi(locationData);
      emit(state.copyWith(loading: false));
    } catch (_) {
      emit(state.copyWith(loading: false));
    }
  }

  Future<LocationData?>? fetchLocationData() async {
    return LocationHelper.fetchLocation().timeout(
      const Duration(seconds: 10),
      onTimeout: () => null,
    );
  }

  Future<void> fetchWeatherApi(LocationData locationData) async {
    final weatherData = await _weatherRepository.fetchCurrentWeather(
      latitude: locationData.latitude.toString(),
      longitude: locationData.longitude.toString(),
    );
    log(weatherData.toString());
    emit(state.copyWith(temperature: weatherData as Temperatures));
  }

  /// Overrides the `fromJson` method from the `HydratedCubit` class to convert
  /// a JSON map to a `WeatherState` object.
  @override
  WeatherState? fromJson(Map<String, dynamic> json) =>
      WeatherState.fromJson(json);

  /// Overrides the `toJson` method from the `HydratedCubit` class to convert
  /// a `WeatherState` object to a JSON map.
  @override
  Map<String, dynamic>? toJson(WeatherState state) =>
      WeatherState.toJson(state);
}
