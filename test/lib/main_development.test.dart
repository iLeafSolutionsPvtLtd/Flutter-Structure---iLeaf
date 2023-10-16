// Bootstrap function is called with a valid App instance.
import 'package:flutter_structure/app/app.dart';
import 'package:flutter_structure/bootstrap.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Bootstrap function is called with a valid App instance', () {
    bootstrap(() => const App());
    // Add assertions here to verify the behavior
  });
}
