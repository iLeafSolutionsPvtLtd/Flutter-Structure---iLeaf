import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(const ThemeState());

  /// Toggles the dark mode of the theme state and emits the updated state
  /// using `emit()`.
  void toggleDarkMode() {
    emit(state.copyWith(isDark: !state.isDark));
  }

  /// Overrides the `fromJson()` method from `HydratedCubit` to convert a
  /// JSON object to a `ThemeState` object.
  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromJson(json);
  }

  /// Overrides the `toJson()` method from `HydratedCubit` to convert a
  /// `ThemeState` object to a JSON object.
  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return ThemeState.toJson(state);
  }
}
