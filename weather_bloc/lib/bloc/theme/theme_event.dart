
part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
  @override
  List<Object> get props => [];
}

class ChangeEvent extends ThemeEvent {
final ThemeApp themeApp;
 const  ChangeEvent({
    required this.themeApp,
  });

  @override
  List<Object> get props => [themeApp];
}
