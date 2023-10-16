import 'dart:convert';

import 'package:network_repository/network_repository.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherRepositoryMock implements WeatherRepository {
  @override
  Future<Temperatures> fetchCurrentWeather({
    required String latitude,
    required String longitude,
  }) async {
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
    final apiResponse =
        await compute(Temperatures.fromRawJson, jsonDecode(response));
    return apiResponse;
  }
}
