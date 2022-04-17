import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_cubit/cubits/temp_settings/temp_settings_cubit.dart';
import 'package:weather_cubit/cubits/theme_cubit/theme_cubit.dart';
import 'package:weather_cubit/pages/home_page.dart';
import 'package:weather_cubit/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:weather_cubit/services/weather_api_services.dart';

import 'cubits/theme_cubit/theme_cubit_state.dart';
import 'cubits/weather/weather_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(weatherApiServices: WeatherApiServices(httpClient: http.Client())),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherCubit>(create: (context) => WeatherCubit(weatherRepository: context.read<WeatherRepository>())),
          BlocProvider<TempSettingsCubit>(create: (context) => TempSettingsCubit()),
          BlocProvider<ThemeCubit>(create: (context)=> ThemeCubit(weatherCubit: context.read<WeatherCubit>()))
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
                  title: "weather app",
                  debugShowCheckedModeBanner: false,
                  theme: state.appTheme == ThemeApp.light ? ThemeData.light() : ThemeData.dark(),
                  home: const HomePage(),
                );
          },
        ),
      ),
    );
  }
}
