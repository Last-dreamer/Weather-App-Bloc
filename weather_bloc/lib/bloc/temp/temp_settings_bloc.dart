import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'temp_settings_event.dart';
part 'temp_settings_state.dart';

class TempSettingsBloc extends Bloc<TempSettingsEvent, TempSettingsState> {
  TempSettingsBloc() : super(TempSettingsState.initialState()) {
    on<ToggleTempEvent>(_toggleTemp);
  }

 FutureOr<void> _toggleTemp(ToggleTempEvent event, Emitter<TempSettingsState> emit) async {
    emit(state.copyWith(tempUnit: state.tempUnit == TempUnit.celsius ? TempUnit.fehrenheit : TempUnit.celsius));
  }
}
