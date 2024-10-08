import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harvest_hero/configurations/configurations.dart';
import 'package:harvest_hero/features/home/blocs/weather_cubit.dart';
import 'package:harvest_hero/utils/weather_code_to_icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final weather = context.watch<WeatherCubit>().state.weather;
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.all(kPadding),
      padding: const EdgeInsets.only(bottom: kPadding),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.6),
        borderRadius: BorderRadius.circular(kPadding * 3),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kPadding * 4,
              vertical: kPadding * 2,
            ),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(kPadding * 3),
            ),
            child: Row(
              children: [
                Icon(
                  weatherIcon(weather?.weatherMain),
                  color: colorScheme.onPrimary,
                  size: kPadding * 10,
                ),
                const SizedBox(
                  width: kPadding * 3,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weather?.weatherMain ?? "",
                      style: theme.textTheme.titleMedium?.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      weather?.areaName ?? "",
                      style: theme.textTheme.titleMedium?.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  "${weather?.temperature?.celsius?.toInt()}°C",
                  style: theme.textTheme.titleLarge?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: kPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info,
                color: colorScheme.onSurface,
                size: kPadding * 4,
              ),
              const SizedBox(width: kPadding),
              Text(
                appLocalizations.thunderStormWarning,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
