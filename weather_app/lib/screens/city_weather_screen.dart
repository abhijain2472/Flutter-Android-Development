import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/city_weather.dart';
import 'package:weather_app/widgets/day_weather_tile.dart';
import 'package:weather_app/widgets/hourly_weather_tile.dart';
import 'package:weather_app/widgets/value_tile.dart';

class CityWeatherScreen extends StatelessWidget {
  final CityWeather cityWeather;

  const CityWeatherScreen({this.cityWeather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                this.cityWeather.cityName.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 5,
                    color: Colors.amber,
                    fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                this.cityWeather.description.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.w100,
                    letterSpacing: 5,
                    fontSize: 15,
                    color: Theme.of(context).primaryColor),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    cityWeather.getIconData(),
                    color: Theme.of(context).primaryColor,
                    size: 70,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '${this.cityWeather.temperature.toStringAsFixed(2)}°',
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.w100,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ValueTile(
                        "max",
                        '${this.cityWeather.tempMax.toStringAsFixed(2)}°',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Center(
                          child: Container(
                            width: 1,
                            height: 30,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      ValueTile(
                        "min",
                        '${this.cityWeather.tempMin.toStringAsFixed(2)}°',
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                child: Divider(
                  color: Colors.grey,
                  indent: 20.0,
                  endIndent: 20.0,
                ),
                padding: EdgeInsets.all(10),
              ),
              HourlyWeatherTile(
                hourlyWeather: cityWeather.hourlyWeatherList,
              ),
//            ForecastHorizontal(weathers: weather.forecast),
              Padding(
                child: Divider(
                  color: Colors.grey,
                  indent: 20.0,
                  endIndent: 20.0,
                ),
                padding: EdgeInsets.all(10),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                ValueTile("wind speed", '${this.cityWeather.windSpeed} m/s'),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Center(
                    child: Container(
                      width: 1,
                      height: 30,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                ValueTile(
                  "sunrise",
                  DateFormat('h:m a').format(this.cityWeather.sunrise),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Center(
                    child: Container(
                      width: 1,
                      height: 30,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                ValueTile(
                  "sunset",
                  DateFormat('h:m a').format(this.cityWeather.sunset),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Center(
                    child: Container(
                      width: 1,
                      height: 30,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                ValueTile("humidity", '${this.cityWeather.humidity}%'),
              ]),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.symmetric(horizontal: 25.0,vertical: 20.0,),
                child: Text(
                  '5-Day Weather Report',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              DayWeatherTile(dayWeather: cityWeather.dayWeatherList,),
              SizedBox(height: 45.0,),
            ],
          ),
        ),
      ),
    );
  }
}
