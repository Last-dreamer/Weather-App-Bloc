import 'dart:convert';

import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String weatherStateName;
  final String weatherStateAbbr;
  final String created;
  final double minTemp;
  final double maxTemp;
  final double temp;
  final String title;
  final int woeid;
  final DateTime lastUpdated;
  
  Weather({
    required this.weatherStateName,
    required this.weatherStateAbbr,
    required this.created,
    required this.minTemp,
    required this.maxTemp,
    required this.temp,
    required this.title,
    required this.woeid,
    required this.lastUpdated,
  });


factory Weather.initial() =>  Weather(weatherStateName: "", weatherStateAbbr: "",
 created: "", minTemp: 0, maxTemp: 0, temp: 0, 
 title: "title", woeid: -9, 
 lastUpdated: DateTime.now()
 );

  Map<String, dynamic> toMap() {
    return {
      'weatherStateName': weatherStateName,
      'weatherStateAbbr': weatherStateAbbr,
      'created': created,
      'minTemp': minTemp,
      'maxTemp': maxTemp,
      'temp': temp,
      'title': title,
      'woied': woeid,
      'lastUpdated': lastUpdated.millisecondsSinceEpoch,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      weatherStateName: map['weatherStateName'] ?? '',
      weatherStateAbbr: map['weatherStateAbbr'] ?? '',
      created: map['created'] ?? '',
      minTemp: map['minTemp']?.toDouble() ?? 0.0,
      maxTemp: map['maxTemp']?.toDouble() ?? 0.0,
      temp: map['temp']?.toDouble() ?? 0.0,
      title: map['title'] ?? '',
      woeid: map['woied']?.toInt() ?? 0,
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(map['lastUpdated']),
    );
  }



 factory Weather.fromJson(Map<String, dynamic> json) {
    final consolidatedWeather = json['consolidated_weather'][0];

    return Weather(
      weatherStateName: consolidatedWeather['weather_state_name'],
      weatherStateAbbr: consolidatedWeather['weather_state_abbr'],
      created: consolidatedWeather['created'],
      minTemp: consolidatedWeather['min_temp'],
      maxTemp: consolidatedWeather['max_temp'],
      temp: consolidatedWeather['the_temp'],
      title: json['title'],
      woeid: json['woeid'],
      lastUpdated: DateTime.now(),
    );
  }


  @override
  List<Object> get props {
    return [
      weatherStateName,
      weatherStateAbbr,
      created,
      minTemp,
      maxTemp,
      temp,
      title,
      woeid,
      lastUpdated,
    ];
  }
 }
