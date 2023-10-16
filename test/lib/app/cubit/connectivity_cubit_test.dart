// ignore_for_file: non_constant_identifier_names
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_structure/app/cubit/connectivity_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:http/testing.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// class FakeUri extends Fake implements Uri {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Verify that the initial state of the connectivity cubit is correct.',
      () {
    late ConnectivityCubit cubit;
    // final client = MockClient((request) => any());
    test('Verify initial state', () {
      cubit = ConnectivityCubit();
      expect(cubit.state, const ConnectivityState());
    });
    blocTest<ConnectivityCubit, ConnectivityState>(
      'Verify that the network is disconnected',
      build: ConnectivityCubit.new,
      act: (cubit) => cubit.listenNetworkMock(InternetStatus.disconnected),
      expect: () => const <ConnectivityState>[
        ConnectivityState(networkStatus: NetworkConnection.disconnected),
      ],
    );

    blocTest<ConnectivityCubit, ConnectivityState>(
      'Verify that the network is connected and then disconnected',
      build: ConnectivityCubit.new,
      act: (cubit) => cubit.listenNetworkMock(InternetStatus.connected),
      expect: () => const <ConnectivityState>[
        ConnectivityState(),
      ],
      tearDown: () => cubit.close(),
    );
  });
}
