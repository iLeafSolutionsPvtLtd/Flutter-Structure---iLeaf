// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

import 'dart:convert';

import 'package:equatable/equatable.dart';

class Temperatures extends Equatable {
  const Temperatures({
    this.latitude,
    this.longitude,
    this.generationTimeMs,
    this.utcOffsetSeconds,
    this.timezone,
    this.timezoneAbbreviation,
    this.elevation,
    this.currentWeather,
    this.dailyUnits,
    this.daily,
  });

  // static Temperatures parse(dynamic json) {
  //   return Temperatures.fromJson(json);
  // }

  factory Temperatures.fromRawJson(dynamic json) =>
      Temperatures.fromJson(json as Map<String, dynamic>);

  factory Temperatures.fromJson(Map<String, dynamic> json) => Temperatures(
        latitude: double.parse(json['latitude'].toString()),
        longitude: double.parse(json['longitude'].toString()),
        generationTimeMs: double.parse(json['generationtime_ms'].toString()),
        utcOffsetSeconds: int.parse(json['utc_offset_seconds'].toString()),
        timezone: json['timezone'].toString(),
        timezoneAbbreviation: json['timezone_abbreviation'].toString(),
        elevation: double.parse(json['elevation'].toString()),
        currentWeather: CurrentWeather.fromJson(
          json['current_weather'] as Map<String, dynamic>,
        ),
        dailyUnits: json['daily_units'] == null
            ? null
            : DailyUnits.fromJson(
                json['daily_units'] as Map<String, dynamic>,
              ),
        daily: json['daily'] == null
            ? null
            : Daily.fromJson(json['daily'] as Map<String, dynamic>),
      );
  final double? latitude;
  final double? longitude;
  final double? generationTimeMs;
  final int? utcOffsetSeconds;
  final String? timezone;
  final String? timezoneAbbreviation;
  final double? elevation;
  final CurrentWeather? currentWeather;
  final DailyUnits? dailyUnits;
  final Daily? daily;
  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'generationtime_ms': generationTimeMs,
        'utc_offset_seconds': utcOffsetSeconds,
        'timezone': timezone,
        'timezone_abbreviation': timezoneAbbreviation,
        'elevation': elevation,
        'current_weather': currentWeather?.toJson(),
        'daily_units': dailyUnits?.toJson(),
        'daily': daily?.toJson(),
      };

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        generationTimeMs,
        utcOffsetSeconds,
        timezone,
        timezoneAbbreviation,
        elevation,
        currentWeather,
        dailyUnits,
        daily,
      ];
}

class CurrentWeather extends Equatable {
  const CurrentWeather({
    required this.temperature,
    required this.windSpeed,
    required this.windDirection,
    required this.weatherCode,
    required this.isDay,
    required this.time,
  });

  factory CurrentWeather.fromRawJson(String str) =>
      CurrentWeather.fromJson(json.decode(str) as Map<String, dynamic>);

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
        temperature: double.parse(json['temperature'].toString()),
        windSpeed: double.parse(json['windspeed'].toString()),
        windDirection: int.parse(json['winddirection'].toString()),
        weatherCode: int.parse(json['weathercode'].toString()),
        isDay: int.parse(json['is_day'].toString()),
        time: json['time'].toString(),
      );
  final double temperature;
  final double windSpeed;
  final int windDirection;
  final int weatherCode;
  final int isDay;
  final String time;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'temperature': temperature,
        'windspeed': windSpeed,
        'winddirection': windDirection,
        'weathercode': weatherCode,
        'is_day': isDay,
        'time': time,
      };

  @override
  List<Object?> get props => [
        temperature,
        windSpeed,
        windDirection,
        weatherCode,
        isDay,
        time,
      ];
}

// class CurrentWeatherUnits {
//   CurrentWeatherUnits({
//     this.time,
//     this.temperature,
//     this.windspeed,
//     this.winddirection,
//     this.isDay,
//     this.weathercode,
//   });

//   factory CurrentWeatherUnits.fromRawJson(String str) =>
//       CurrentWeatherUnits.fromJson(json.decode(str));

//   factory CurrentWeatherUnits.fromJson(Map<String, dynamic> json) =>
//       CurrentWeatherUnits(
//         time: json['time'],
//         temperature: json['temperature'],
//         windspeed: json['windspeed'],
//         winddirection: json['winddirection'],
//         isDay: json['is_day'],
//         weathercode: json['weathercode'],
//       );
//   final String? time;
//   final String? temperature;
//   final String? windspeed;
//   final String? winddirection;
//   final String? isDay;
//   final String? weathercode;

//   String toRawJson() => json.encode(toJson());

//   Map<String, dynamic> toJson() => {
//         'time': time,
//         'temperature': temperature,
//         'windspeed': windspeed,
//         'winddirection': winddirection,
//         'is_day': isDay,
//         'weathercode': weathercode,
//       };
// }

class Daily extends Equatable {
  const Daily({
    this.time,
    this.temperature2MMax,
    this.temperature2MMin,
    this.sunrise,
    this.sunset,
    this.uvIndexMax,
    this.precipitationProbabilityMax,
  });

  factory Daily.fromRawJson(String str) =>
      Daily.fromJson(json.decode(str) as Map<String, dynamic>);

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        time: json['time'] == null
            ? null
            : DateTime.parse(
                json['time'][0].toString(),
              ),
        temperature2MMax: json['temperature_2m_max'] == null
            ? 0.0
            : double.parse(json['temperature_2m_max']![0].toString()),
        temperature2MMin: json['temperature_2m_min'] == null
            ? 0.0
            : double.parse(json['temperature_2m_min'][0].toString()),
        sunrise: json['sunrise'] == null ? '' : json['sunrise']![0].toString(),
        sunset: json['sunset'] == null ? '' : json['sunset']![0].toString(),
        uvIndexMax: json['uv_index_max'] == null
            ? 0.0
            : double.parse(json['uv_index_max']![0].toString()),
        precipitationProbabilityMax: json['precipitation_probability_max'] ==
                null
            ? 0
            : int.parse(json['precipitation_probability_max']![0].toString()),
      );
  final DateTime? time;
  final double? temperature2MMax;
  final double? temperature2MMin;
  final String? sunrise;
  final String? sunset;
  final double? uvIndexMax;
  final int? precipitationProbabilityMax;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'time': time == null
            ? ['']
            : [
                """
${time!.year.toString().padLeft(4, '0')}-${time!.month.toString().
padLeft(2, '0')}-${time!.day.toString().padLeft(2, '0')}""",
              ],
        'temperature_2m_max':
            temperature2MMax == null ? [0.0] : [temperature2MMax],
        'temperature_2m_min':
            temperature2MMin == null ? [0.0] : [temperature2MMin],
        'sunrise': sunrise == null ? [''] : [sunrise],
        'sunset': sunset == null ? [''] : [sunset],
        'uv_index_max': uvIndexMax == null ? [0.0] : [uvIndexMax],
        'precipitation_probability_max': precipitationProbabilityMax == null
            ? [0]
            : [precipitationProbabilityMax],
      };

  @override
  List<Object?> get props => [
        time,
        temperature2MMax,
        temperature2MMin,
        sunrise,
        sunset,
        uvIndexMax,
        precipitationProbabilityMax,
      ];
}

class DailyUnits extends Equatable {
  const DailyUnits({
    this.time,
    this.temperature2MMax,
    this.temperature2MMin,
    this.sunrise,
    this.sunset,
    this.uvIndexMax,
    this.precipitationProbabilityMax,
  });

  factory DailyUnits.fromRawJson(dynamic json) =>
      DailyUnits.fromJson(json as Map<String, dynamic>);

  factory DailyUnits.fromJson(Map<String, dynamic> json) => DailyUnits(
        time: json['time'].toString(),
        temperature2MMax: json['temperature_2m_max'].toString(),
        temperature2MMin: json['temperature_2m_min'].toString(),
        sunrise: json['sunrise'].toString(),
        sunset: json['sunset'].toString(),
        uvIndexMax: json['uv_index_max'].toString(),
        precipitationProbabilityMax:
            json['precipitation_probability_max'].toString(),
      );
  final String? time;
  final String? temperature2MMax;
  final String? temperature2MMin;
  final String? sunrise;
  final String? sunset;
  final String? uvIndexMax;
  final String? precipitationProbabilityMax;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'time': time,
        'temperature_2m_max': temperature2MMax,
        'temperature_2m_min': temperature2MMin,
        'sunrise': sunrise,
        'sunset': sunset,
        'uv_index_max': uvIndexMax,
        'precipitation_probability_max': precipitationProbabilityMax,
      };

  @override
  List<Object?> get props => [
        time,
        temperature2MMax,
        temperature2MMin,
        sunrise,
        sunset,
        uvIndexMax,
        precipitationProbabilityMax,
      ];
}
