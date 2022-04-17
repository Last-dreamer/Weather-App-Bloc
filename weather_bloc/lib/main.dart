import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:http/http.dart' as http;
import 'package:weather_bloc/bloc/temp/temp_settings_bloc.dart';
import 'package:weather_bloc/bloc/theme/theme_bloc.dart';
import 'package:weather_bloc/pages/home_page.dart';
import 'package:weather_bloc/repositories/weather_repository.dart';
import 'package:weather_bloc/services/weather_api_services.dart';
import 'bloc/weather/weather_bloc.dart';
 

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
          BlocProvider<WeatherBloc>(create: (context) => WeatherBloc(weatherRepository: context.read<WeatherRepository>())),
          BlocProvider<TempSettingsBloc>(create: (context) => TempSettingsBloc()),
          BlocProvider<ThemeBloc>(create: (context)=> ThemeBloc(weatherBloc: context.read<WeatherBloc>()))
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
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
