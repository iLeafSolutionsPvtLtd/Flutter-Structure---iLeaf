// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:network_repository/network_repository.dart';

void main() {
  group('NetworkRepository', () {
    test('can be instantiated', () {
      expect(NetworkAdapter.shared, isNotNull);
    });
  });
}
