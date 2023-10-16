import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_structure/app/cubit/theme_cubit.dart';
import 'package:flutter_structure/helpers/assets.dart';
import 'package:flutter_structure/helpers/colors.dart';
import 'package:flutter_structure/helpers/commons.dart';
import 'package:flutter_structure/helpers/icon_data_custom_widget.dart';
import 'package:flutter_structure/helpers/loading.dart';
import 'package:flutter_structure/helpers/snackbar.dart';
import 'package:flutter_structure/home/cubit/weather_cubit.dart';
import 'package:flutter_structure/l10n/l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<WeatherCubit, WeatherState>(
      listener: (context, state) {
        if (state.loading) {
          LoadingHelper.showLoading();
        } else {
          LoadingHelper.hideLoading();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.read<WeatherCubit>().fetchWeather();
            },
            icon: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return const Icon(Icons.refresh);
              },
            ),
          ),
          title: Text(l10n.weatherToday),
          actions: [
            IconButton(
              onPressed: () {
                context.read<ThemeCubit>().toggleDarkMode();
                SnackBarHelper.showSnackbar(
                  Text(
                    context.read<ThemeCubit>().state.isDark
                        ? l10n.dark
                        : l10n.light,
                  ),
                  backgroundColor: context.read<ThemeCubit>().state.isDark
                      ? AppColors.baseColorLight
                      : AppColors.baseColorDark,
                );
              },
              icon: BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return Icon(state.isDark ? Icons.bed : Icons.sunny);
                },
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              BlocBuilder<WeatherCubit, WeatherState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(height: 25),
                      if (state.temperature.currentWeather!.isDay == 1)
                        Image.asset(
                          Assets.assetsSun,
                          scale: 3,
                        )
                      else
                        Image.asset(
                          Assets.assetsMoon,
                          scale: 3,
                        ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconDataCustomWidget(
                            text: l10n.minTemp,
                            value:
                                '''${state.temperature.daily!.temperature2MMin!}${state.temperature.dailyUnits!.temperature2MMin}''',
                            asset: Assets.assetsLowTemperature,
                          ),
                          IconDataCustomWidget(
                            text: l10n.currentTemp,
                            value:
                                '''${state.temperature.currentWeather!.temperature}${state.temperature.dailyUnits!.temperature2MMax}''',
                            asset: Assets.assetsTemperature,
                          ),
                          IconDataCustomWidget(
                            text: l10n.maxTemp,
                            value:
                                '''${state.temperature.daily!.temperature2MMax!}${state.temperature.dailyUnits!.temperature2MMax}''',
                            asset: Assets.assetsHighTemperature,
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconDataCustomWidget(
                            text: l10n.windSpeed,
                            value:
                                '''${state.temperature.currentWeather!.windSpeed} Km/h''',
                            direction: Direction.bottom,
                            asset: Assets.assetsWind,
                          ),
                          IconDataCustomWidget(
                            text: l10n.windDirection,
                            value: Commons.getDirectionFromAngle(
                              state.temperature.currentWeather!.windDirection,
                            ),
                            direction: Direction.bottom,
                            asset: Assets.assetsWindDirection,
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconDataCustomWidget(
                            text: l10n.sunrise,
                            value: Commons.getTimeFromDateAndTime(
                              state.temperature.daily!.sunrise.toString(),
                            ),
                            direction: Direction.bottom,
                            asset: Assets.assetsSunrise,
                          ),
                          IconDataCustomWidget(
                            text: l10n.sunset,
                            value: Commons.getTimeFromDateAndTime(
                              state.temperature.daily!.sunset.toString(),
                            ),
                            direction: Direction.bottom,
                            asset: Assets.assetsSunset,
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconDataCustomWidget(
                            text: l10n.precipitation,
                            value: state.temperature.daily!
                                    .precipitationProbabilityMax
                                    .toString() +
                                state.temperature.dailyUnits!
                                    .precipitationProbabilityMax!,
                            direction: Direction.bottom,
                            asset: Assets.assetsPrecipitation,
                          ),
                          IconDataCustomWidget(
                            text: l10n.uvIndex,
                            value:
                                state.temperature.daily!.uvIndexMax.toString() +
                                    state.temperature.dailyUnits!.uvIndexMax!,
                            direction: Direction.bottom,
                            asset: Assets.assetsUv,
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
