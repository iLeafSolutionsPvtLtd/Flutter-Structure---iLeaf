// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $noInternetPageRouter,
      $homePageRouter,
    ];

RouteBase get $noInternetPageRouter => GoRouteData.$route(
      path: '/no-internet',
      factory: $NoInternetPageRouterExtension._fromState,
    );

extension $NoInternetPageRouterExtension on NoInternetPageRouter {
  static NoInternetPageRouter _fromState(GoRouterState state) =>
      NoInternetPageRouter();

  String get location => GoRouteData.$location(
        '/no-internet',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homePageRouter => GoRouteData.$route(
      path: '/home',
      factory: $HomePageRouterExtension._fromState,
    );

extension $HomePageRouterExtension on HomePageRouter {
  static HomePageRouter _fromState(GoRouterState state) => HomePageRouter(
        text: state.uri.queryParameters['text'] ?? '',
      );

  String get location => GoRouteData.$location(
        '/home',
        queryParams: {
          if (text != '') 'text': text,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
