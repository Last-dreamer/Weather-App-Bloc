import 'package:bloc/bloc.dart';
import 'package:weather_cubit/cubits/temp_settings/temp_settings_state.dart';



class TempSettingsCubit extends Cubit<TempSettingsState> {
  TempSettingsCubit() : super(TempSettingsState.initialState());
  
  void toggleTempUnit(){
    emit(state.copyWith(tempUnit: state.tempUnit == TempUnit.celsius ? TempUnit.fehrenheit : TempUnit.celsius ));
  
  }

}
