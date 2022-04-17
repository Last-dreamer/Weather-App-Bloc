
import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:weather_cubit/cubits/theme_cubit/theme_cubit_state.dart';
import 'package:weather_cubit/cubits/weather/weather_cubit.dart';

import '../../constants/constant.dart';

class ThemeCubit extends Cubit<ThemeState> {
  late final streamSubscription;
  final WeatherCubit weatherCubit;
  ThemeCubit({
    required this.weatherCubit
  }) : super(ThemeState.initial()){
    streamSubscription = weatherCubit.stream.listen((event) {
      log("chekcing $event");
      if(event.weather.temp > wormOrNot){
        emit(state.copyWith(appTheme: ThemeApp.light));
      }else{
        emit(state.copyWith(appTheme: ThemeApp.dark));
      }
     });
  }


  
@override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }

}
