import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/bloc/temp/temp_settings_bloc.dart';


class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Setting Page"),),
      body:  Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: const Text("Temperature Unit"),
          subtitle: const Text("Celsius/Fahrenheit  (Default: Celsius)"),
          trailing: Switch(value: context.watch<TempSettingsBloc>().state.tempUnit == TempUnit.celsius, 
          onChanged: (value){
            context.read<TempSettingsBloc>().add(ToggleTempEvent());
          }),
        ),
      ),
    );
  }
}
