part of 'weather_cubit.dart';

class WeatherState extends Equatable {
  const WeatherState({
    this.temperature = const Temperatures(),
    this.loading = false,
  });
  final Temperatures temperature;
  final bool loading;

  @override
  List<Object> get props => [
        temperature,
        loading,
      ];

  WeatherState copyWith({Temperatures? temperature, bool? loading}) {
    return WeatherState(
      temperature: temperature ?? this.temperature,
      loading: loading ?? this.loading,
    );
  }

  static WeatherState? fromJson(Map<String, dynamic> json) {
    if (json['temperatures'] != null) {
      return WeatherState(
        temperature: Temperatures.fromRawJson(
          jsonDecode(
            json['temperatures'].toString(),
          ),
        ),
      );
    }
    return null;
  }

  static Map<String, dynamic>? toJson(WeatherState state) {
    return {
      'temperatures': state.temperature.toRawJson(),
    };
  }
}
