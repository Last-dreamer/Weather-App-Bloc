
import 'dart:convert';
import 'dart:developer' as dev;

import 'package:http/http.dart' as http;
 

import '../constants/constant.dart';
import '../exceptions/weather_exception.dart';
import '../models/weather_model.dart';
import 'http_error_handler.dart';

class WeatherApiServices {
  final http.Client httpClient;
  WeatherApiServices({
    required this.httpClient,
  });


Future<int> getWoeid(String city) async {
  final Uri uri = Uri(
    scheme: "https",
    host: KHost,
    path: "/api/location/search/",
    queryParameters: {
      "query":city,
    }
  );
  try {
    final http.Response res = await http.get(uri);
    if(res.statusCode != 200){
     throw Exception(httpErrorHandler(res));
    }

    final resBody = json.decode(res.body);
    if(resBody.isEmpty){
      throw WeatherException("cannot get woeid of $city");
    }

    if(resBody.length > 1){
      throw WeatherException("There is multiple candidate for $city \n Plase specify further..!");
    }
    return resBody[0]['woeid'];
  } catch (e) {
    rethrow;
  }
}

  
Future<Weather> getWeather(int woeid) async {
  final Uri uri = Uri(scheme:  "http", host: KHost, path: '/api/location/$woeid', );
  try {
    final http.Response res = await http.get(uri);
    if(res.statusCode != 200){
      throw Exception(httpErrorHandler(res));
    } 

   final weatherJson = json.decode(res.body);
   final weather = Weather.fromJson(weatherJson);
    dev.log("weather $weather");
   return weather;
  } catch (e) {
    rethrow;
  }
}

}
