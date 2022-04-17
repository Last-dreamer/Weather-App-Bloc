

import 'package:weather_cubit/exceptions/weather_exception.dart';
import 'package:weather_cubit/models/custom_error.dart';
import 'package:weather_cubit/services/weather_api_services.dart';
import 'dart:developer' as dev;

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
