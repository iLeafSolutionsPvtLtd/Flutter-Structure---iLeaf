import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_structure/app/cubit/connectivity_cubit.dart';

class AppService extends ChangeNotifier {
  AppService(
    this.connectivityCubit,
  ) {
    _cubitStreamConn = connectivityCubit.stream.listen((event) {
      // log(event.networkStatus.toString());
      notifyListeners();
    });
  }

  late final StreamSubscription<ConnectivityState> _cubitStreamConn;

  final ConnectivityCubit connectivityCubit;

  @override
  void dispose() {
    _cubitStreamConn.cancel();
    super.dispose();
  }
}
