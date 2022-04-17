import 'package:flutter/material.dart';
import 'package:weather_cubit/constants/constant.dart';
import 'package:weather_cubit/cubits/temp_settings/temp_settings_cubit.dart';
import 'package:weather_cubit/cubits/weather/weather_cubit.dart';
import 'package:weather_cubit/pages/search_page.dart';
import 'dart:developer' as dev;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_cubit/pages/setting_page.dart';
import 'package:weather_cubit/widgets/error_dialog.dart';

import '../cubits/temp_settings/temp_settings_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  String? _city;

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
              onPressed: () async {
                _city = await Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SearchPage()));
                dev.log("city search $_city");
                if (_city != null) {
                  context.read<WeatherCubit>().fetchWeather(_city!);
                }
              },
              icon: const Icon(Icons.search_rounded)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingPage()));
          }, icon: const Icon(Icons.settings))
        ],
      ),
      body: BlocConsumer<WeatherCubit, WeatherState>(
          builder: (context, state) {
        if (state.weatherStatus == WeatherStatus.initial) {
          return const Center(
            child: Text(
              "Select a City",
              style: TextStyle(fontSize: 22),
            ),
          );
        }

        if (state.weatherStatus == WeatherStatus.error &&
            state.weather.title == '') {
          return const Center(
            child: Text(
              "Please select text",
              style: TextStyle(fontSize: 22),
            ),
          );
        }

        if (state.weatherStatus == WeatherStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: [
            SizedBox(
              height: _height / 6,
            ),
            Text(
              state.weather.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              TimeOfDay.fromDateTime(state.weather.lastUpdated).format(context),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
           const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_showTemperature(state.weather.temp),
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                const SizedBox(width: 20,),
                Column(
                  children: [
                    Text(_showTemperature(state.weather.minTemp),
                      style: const TextStyle(fontSize: 16,),),
                    const SizedBox(height: 10,),
                    Text(_showTemperature(state.weather.maxTemp),
                      style: const TextStyle(fontSize: 16),),


                ],),
              ],),

            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                showIcon(state.weather.weatherStateAbbr),
                const SizedBox(width: 5,),
                Text(state.weather.weatherStateName, style: const TextStyle(fontSize: 30, ),),
              ],
            ),
          ],
        );
      }, listener: (context, state) {
        if (state.weatherStatus == WeatherStatus.error) {
          errorDialog(context, state.error.errMsg);
        }
      }),
    );
  }


  Widget showIcon(String abr){
    
    return FadeInImage.assetNetwork(placeholder: "assets/sun_rain_cc.gif", image: "https://$KHost/static/img/weather/png/64/$abr.png", width: 64, height: 64,);
  }

  String _showTemperature(double temp){

    final tempUnit = context.watch<TempSettingsCubit>().state.tempUnit;

    if(tempUnit == TempUnit.fehrenheit){
      return  ((temp * 9 /5) + 32).toStringAsFixed(2) + 'F';
    }

    return temp.toStringAsFixed(2) + '°C';
  }
}
