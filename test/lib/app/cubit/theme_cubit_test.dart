// ignore_for_file: non_constant_identifier_names
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_structure/app/cubit/theme_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockStorage extends Mock implements Storage {}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Verify that the initial state of the theme cubit is correct.', () {
    late Storage storage;
    late ThemeCubit cubit;

    setUp(() {
      storage = MockStorage();
      when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
      HydratedBloc.storage = storage;
      cubit = ThemeCubit();
    });
    test('Verify initial state', () {
      expect(cubit.state, const ThemeState());
    });
    blocTest<ThemeCubit, ThemeState>(
      'Verify that the theme is dark',
      build: () => cubit,
      act: (cubit) => cubit.toggleDarkMode(),
      expect: () => const <ThemeState>[ThemeState(isDark: true)],
    );
    blocTest<ThemeCubit, ThemeState>(
      'Verify that the theme is light',
      build: () => cubit,
      act: (cubit) {
        cubit.toggleDarkMode();
      },
      expect: () => const <ThemeState>[
        ThemeState(isDark: true),
      ],
    );

    test(
      'Verify fromJson() converts JSON object to ThemeState object',
      () => testFromJson,
    );
    test(
      'Verify toJson() converts ThemeState object to JSON object',
      () => test_toJson_converts_ThemeState_object_to_JSON_object,
    );
    test(
      'Verify copyWith method with isDark set to true',
      () => test_copyWith_isDark_true,
    );
    test(
      'Verify fromJson with null argument',
      () => test_fromJson_with_null_argument,
    );
  });
}

/// fromJson() converts JSON object to ThemeState object
void testFromJson() {
  // Arrange
  final json = {
    'isDark': true,
  };

  // Act
  final result = ThemeCubit().fromJson(json);

  // Assert
  expect(result, isA<ThemeState>());
  expect(result!.isDark, true);
}

/// toJson() converts ThemeState object to JSON object
void test_toJson_converts_ThemeState_object_to_JSON_object() {
  // Arrange
  final themeCubit = ThemeCubit();
  const themeState = ThemeState(isDark: true);

  // Act
  final json = themeCubit.toJson(themeState);

  // Assert
  expect(json, isA<Map<String, dynamic>>());
  expect(json!['isDark'], true);
}

// Call copyWith method with isDark set to true
void test_copyWith_isDark_true() {
  // Arrange
  const themeState = ThemeState();

  // Act
  final updatedThemeState = themeState.copyWith(isDark: true);

  // Assert
  expect(updatedThemeState.isDark, true);
}

// Call fromJson with null argument
void test_fromJson_with_null_argument() {
  const json = null;
  final state = ThemeState.fromJson(json as Map<String, dynamic>);
  expect(state, isNull);
}
