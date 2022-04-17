part of 'theme_bloc.dart';



enum ThemeApp {
  light,
  dark
}

class ThemeState extends Equatable {
  final ThemeApp appTheme;
  const ThemeState({
     this.appTheme = ThemeApp.light,
  });


factory ThemeState.initial(){
  return const ThemeState();
}

  ThemeState copyWith({
    ThemeApp? appTheme,
  }) {
    return ThemeState(
      appTheme: appTheme ?? this.appTheme,
    );
  }

  @override
  String toString() => 'ThemeState(appTheme: $appTheme)';

  @override
  List<Object> get props => [appTheme];
}
