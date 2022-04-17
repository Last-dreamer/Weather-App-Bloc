import 'package:equatable/equatable.dart';

enum TempUnit {
  celsius,
  fehrenheit
}


class TempSettingsState extends Equatable {

  final TempUnit tempUnit;
  const TempSettingsState({
      this.tempUnit = TempUnit.celsius,
  });
  

factory TempSettingsState.initialState(){
 return const TempSettingsState();
}
  @override
  List<Object> get props => [tempUnit];

  @override
  String toString() => 'TempSettings(tempUnit: $tempUnit)';

  TempSettingsState copyWith({
    TempUnit? tempUnit,
  }) {
    return TempSettingsState(
      tempUnit: tempUnit ?? this.tempUnit,
    );
  }
}
