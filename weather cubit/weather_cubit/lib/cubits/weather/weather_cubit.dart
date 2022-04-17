import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:weather_cubit/models/weather_model.dart';
import 'package:weather_cubit/repositories/weather_repository.dart';

import '../../models/custom_error.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {

  final WeatherRepository weatherRepository;
  WeatherCubit({
    required this.weatherRepository,
  }) : super(WeatherState.initial());


  Future<void> fetchWeather(String city)async {
    emit(state.copyWith(weatherStatus: WeatherStatus.loading));
    try {
      final weather = await weatherRepository.fetchWeather(city);
      emit(state.copyWith(weatherStatus: WeatherStatus.loaded, weather: weather,));      
    } on CustomError catch (e) {
    emit(state.copyWith(weatherStatus: WeatherStatus.error, error: e));
    }
  }
}
