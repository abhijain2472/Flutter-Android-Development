import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/screens/city_weather_screen.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/models/city_weather.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CityWeather _cityWeather;
  bool isLoading = true;

  @override
  void initState() {
    getWeather();

    super.initState();
  }

  void getWeather() async {
    _cityWeather = await WeatherService().getCurrentWeather();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: _cityWeather != null
                  ? CityWeatherScreen(
                      cityWeather: _cityWeather,
                    )
                  : Center(
                      child: Text(
                        'Invalid City Name, No Data Found',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
            ),
    );
  }
}
