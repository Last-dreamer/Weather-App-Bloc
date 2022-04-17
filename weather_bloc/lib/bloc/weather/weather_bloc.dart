

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_bloc/repositories/weather_repository.dart';

import '../../models/custom_error.dart';
import '../../models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final WeatherRepository weatherRepository;
  WeatherBloc({
    required this.weatherRepository,
  }) : super(WeatherState.initial()) {
    on<FetchWeatherEvent>(_fetchWeather);
  }



 FutureOr<void> _fetchWeather(FetchWeatherEvent event, Emitter<WeatherState> emit) async {
     emit(state.copyWith(weatherStatus: WeatherStatus.loading));
   try{
     
     final weather =  await weatherRepository.fetchWeather(event.city);
     emit(state.copyWith(weather: weather, weatherStatus: WeatherStatus.loaded));

   }on CustomError catch(e){
     emit(state.copyWith(weatherStatus: WeatherStatus.error, error: e));
   }
 }
}
