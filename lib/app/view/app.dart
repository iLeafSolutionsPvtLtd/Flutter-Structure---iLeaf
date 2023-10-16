import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_structure/app/cubit/connectivity_cubit.dart';
import 'package:flutter_structure/app/cubit/theme_cubit.dart';
import 'package:flutter_structure/helpers/snackbar.dart';
import 'package:flutter_structure/helpers/theme.dart';
import 'package:flutter_structure/helpers/values.dart';
import 'package:flutter_structure/home/cubit/weather_cubit.dart';
import 'package:flutter_structure/l10n/l10n.dart';
import 'package:flutter_structure/router/app_services.dart';
import 'package:flutter_structure/router/router.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_repository/weather_repository.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => WeatherRepositoryImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ConnectivityCubit>(
            create: (context) => ConnectivityCubit(),
            lazy: false,
          ),
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
            lazy: false,
          ),
          BlocProvider<WeatherCubit>(
            create: (context) => WeatherCubit(
              weatherRepository:
                  RepositoryProvider.of<WeatherRepositoryImpl>(context),
            ),
            lazy: false,
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({
    super.key,
  });

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late final GoRouter router;

  @override
  void initState() {
    router = AppRoute(
      AppService(
        context.read<ConnectivityCubit>(),
      ),
    ).router;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (themeContext, themeState) {
        return ScreenUtilInit(
          // designSize: const Size(360, 690),
          designSize: const Size(2556, 1179),
          minTextAdapt: true,
          splitScreenMode: true,
          child: SafeArea(
            top: false,
            // bottom: false,
            maintainBottomViewPadding: true,
            child: MaterialApp.router(
              theme: CustomThemeData.light,
              darkTheme: CustomThemeData.dark,
              themeMode: themeState.isDark ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate,
              routeInformationProvider: router.routeInformationProvider,
              scaffoldMessengerKey: SnackBarHelper.key,
              builder: (context, child) {
                child = EasyLoading.init()(context, child);
                EasyLoading.instance
                  ..displayDuration =
                      const Duration(milliseconds: AppValues.highDuration)
                  ..indicatorType = EasyLoadingIndicatorType.fadingCircle
                  ..loadingStyle = EasyLoadingStyle.custom
                  ..boxShadow = []
                  // ..indicatorSize = 100.0
                  // ..radius = 10.0
                  // ..progressColor = Colors.yellow
                  ..backgroundColor = Colors.transparent
                  ..indicatorColor = Colors.transparent
                  ..textColor = Colors.black
                  // ..maskColor = Colors.blue.withOpacity(0.5)
                  ..userInteractions = true
                  ..dismissOnTap = false;
                return child;
              },
            ),
          ),
        );
      },
    );
  }
}
