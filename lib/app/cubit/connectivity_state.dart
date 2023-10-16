part of 'connectivity_cubit.dart';

enum NetworkConnection {
  unknown,
  connected,
  disconnected,
}

class ConnectivityState extends Equatable {
  const ConnectivityState({
    this.networkStatus = NetworkConnection.connected,
  });
  final NetworkConnection networkStatus;

  ConnectivityState copyWith({NetworkConnection? networkStatus}) {
    return ConnectivityState(
      networkStatus: networkStatus ?? this.networkStatus,
    );
  }

  @override
  List<Object> get props => [
        networkStatus,
      ];
}
