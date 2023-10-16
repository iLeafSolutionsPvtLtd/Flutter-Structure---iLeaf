import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(const ConnectivityState()) {
    listenNetwork();
  }

  void listenNetwork() {
    listener =
        InternetConnection().onStatusChange.listen((InternetStatus status) {
      // log(status.toString());

      switch (status) {
        case InternetStatus.connected:
          // The internet is now connected
          emit(state.copyWith(networkStatus: NetworkConnection.connected));
        case InternetStatus.disconnected:
          // The internet is now disconnected
          emit(state.copyWith(networkStatus: NetworkConnection.disconnected));
      }
    });
  }

  void listenNetworkMock(InternetStatus status) {
    switch (status) {
      case InternetStatus.connected:
        // The internet is now connected
        emit(state.copyWith(networkStatus: NetworkConnection.connected));
      case InternetStatus.disconnected:
        // The internet is now disconnected
        emit(state.copyWith(networkStatus: NetworkConnection.disconnected));
    }
  }

  late final StreamSubscription<InternetStatus> listener;

  @override
  Future<void> close() {
    listener.cancel();
    return super.close();
  }
}
