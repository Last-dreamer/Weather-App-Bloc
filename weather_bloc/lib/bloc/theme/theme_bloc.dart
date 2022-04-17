import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_bloc/constants/constant.dart';

import '../weather/weather_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  late final StreamSubscription weatherSubscription;
  final WeatherBloc weatherBloc;
  ThemeBloc({ required this.weatherBloc}) : super(ThemeState.initial()) {

    weatherSubscription = weatherBloc.stream.listen((e) {
      if(e.weather.temp > wormOrNot){
        add(const ChangeEvent(themeApp: ThemeApp.light));
      }else{
        add(const ChangeEvent(themeApp: ThemeApp.dark));
      }

     });
     on<ChangeEvent>((event, emit){
       emit(state.copyWith(appTheme: event.themeApp));
     }
     );
  }

  @override
  Future<void> close() {
    weatherSubscription.cancel();
    return super.close();
  }

}
