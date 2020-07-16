import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Weather _weather;
  bool isLoading = true;

  @override
  void initState() {
    getWeather();
    var date = new DateTime.fromMillisecondsSinceEpoch(1594911600*1000,isUtc: false);
    print(date);
    print(DateFormat('hh:mm a').format(date));
    super.initState();
  }

  void getWeather() async {
    _weather = await WeatherService().getCurrentWeather(city: 'Mumbai');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: _weather != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _weather.city,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                          Image.network(
                            _weather.icon,
                            width: 40.0,
                          ),
                          Text(
                            'Temperature : ${_weather.temperature}',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            'Humidity : ${_weather.humidity}',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            'Wind Speed : ${_weather.windSpeed}',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
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
