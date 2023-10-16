import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_structure/app/cubit/connectivity_cubit.dart';
import 'package:flutter_structure/helpers/no_internet.dart';
import 'package:flutter_structure/helpers/unfocus.dart';
import 'package:flutter_structure/home/home.dart';
import 'package:flutter_structure/router/app_services.dart';
import 'package:go_router/go_router.dart';

part 'router.g.dart';

class AppRoute {
  AppRoute(this.appService);
  late final AppService appService;

  late final GoRouter router = GoRouter(
    refreshListenable: appService,
    redirect: (BuildContext context, GoRouterState state) async {
      final connectivityCubit = context.read<ConnectivityCubit>();

      final networkConnected =
          connectivityCubit.state.networkStatus == NetworkConnection.connected;
      const loggedIn = true;

      /// check internet or redirect to no internet page
      if (!networkConnected) {
        return NoInternetPageRouter().location;
      }

      /// the user is logged in and headed to /login, no need to login again
      if (loggedIn) {
        return HomePageRouter().location;
      }

      /// no need to redirect at all
      // return null;
    },
    routes: $appRoutes,
    initialLocation: HomePageRouter().location,
    debugLogDiagnostics: kDebugMode,
    observers: [],
  );
}

@TypedGoRoute<NoInternetPageRouter>(path: '/no-internet')
class NoInternetPageRouter extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Unfocus(child: NoInternetPage());
  }
}

@TypedGoRoute<HomePageRouter>(path: '/home')
class HomePageRouter extends GoRouteData {
  HomePageRouter({this.text = ''});

  final String text;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Unfocus(
      child: HomePage(
          // trip: Trip.fromJson(json.decode(trip)),
          ),
    );
  }
}
