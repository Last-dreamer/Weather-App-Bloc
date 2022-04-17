
 
part of 'weather_bloc.dart';


enum WeatherStatus {
  initial,
  loading,
  loaded,
  error
}

class WeatherState extends Equatable {
  final WeatherStatus weatherStatus;
  final Weather weather;
  final CustomError error;
  const WeatherState({
    required this.weatherStatus,
    required this.weather,
    required this.error,
  });

  factory WeatherState.initial(){
    return WeatherState(
      weatherStatus: WeatherStatus.initial,
      weather: Weather.initial(),
      error: const CustomError(errMsg: '')
    );
  }

  WeatherState copyWith({
    WeatherStatus? weatherStatus,
    Weather? weather,
    CustomError? error,
  }) {
    return WeatherState(
      weatherStatus: weatherStatus ?? this.weatherStatus,
      weather: weather ?? this.weather,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'WeatherState(weatherStatus: $weatherStatus, weather: $weather, customError: $error)';

  

  @override
  List<Object> get props => [weatherStatus, weather, error];
}
