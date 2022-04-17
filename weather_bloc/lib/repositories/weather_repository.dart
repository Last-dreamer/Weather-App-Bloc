
import 'dart:developer' as dev;

import 'package:weather_bloc/services/weather_api_services.dart';

import '../exceptions/weather_exception.dart';
import '../models/custom_error.dart';
import '../models/weather_model.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository({
    required this.weatherApiServices,
  });


Future<Weather> fetchWeather(String city) async {
  try {
    final int woeid  = await weatherApiServices.getWoeid(city);
    dev.log("woeid $woeid");
    final weather = await weatherApiServices.getWeather(woeid);
    dev.log("weather $weather");
    return weather;
  } on WeatherException  catch(e){
    throw CustomError(errMsg: e.message);
  }  catch (e) {
    throw CustomError(errMsg: e.toString());
  }
}

}
