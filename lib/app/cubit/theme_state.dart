part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  const ThemeState({this.isDark = false});
  final bool isDark;

  @override
  List<Object> get props => [
        isDark,
      ];
  ThemeState copyWith({bool? isDark}) {
    return ThemeState(
      isDark: isDark ?? this.isDark,
    );
  }

  static ThemeState? fromJson(Map<String, dynamic> json) {
    final isDark = bool.parse(json['isDark'].toString());
    return ThemeState(isDark: isDark);
  }

  static Map<String, dynamic>? toJson(ThemeState state) {
    return {
      'isDark': state.isDark,
    };
  }
}
