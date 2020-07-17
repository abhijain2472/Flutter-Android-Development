import 'package:flutter/material.dart';
import 'package:weather_app/models/day_weather.dart';
import 'package:weather_app/models/hourly_weather.dart';
import 'package:weather_app/utils/icondata.dart';

class CityWeather {
  final String cityName;
  final DateTime sunset;
  final DateTime sunrise;
  final String iconCode;
  final double temperature;
  final double feelsLike;
  final int pressure;
  final double tempMin;
  final double tempMax;
  final int seaLevel;
  final int groundLevel;
  final int humidity;
  final String condition;
  final String description;
  final double windSpeed;
  final int windDegree;
  final DateTime timeStamp;
  final List<HourlyWeather> hourlyWeatherList;
  final List<DayWeather> dayWeatherList;

  CityWeather({
    this.cityName,
    this.sunset,
    this.sunrise,
    this.iconCode,
    this.temperature,
    this.feelsLike,
    this.humidity,
    this.pressure,
    this.tempMin,
    this.tempMax,
    this.seaLevel,
    this.groundLevel,
    this.condition,
    this.description,
    this.windSpeed,
    this.windDegree,
    this.timeStamp,
    this.dayWeatherList,
    this.hourlyWeatherList,
  });

  factory CityWeather.fromJson(Map<String, dynamic> data) {
    List<HourlyWeather> _hourlyWeather = [];
    List<DayWeather> _dayWeather = [];
    DateTime todayDate = DateTime.now();
    var i = 0;
    List _weatherData = data['list'];
    _weatherData.sublist(0, 8).forEach((element) {
      _hourlyWeather.add(HourlyWeather.fromJson(element));
    });

    _weatherData.forEach((element) {
      DateTime elementDate =
          DateTime.fromMillisecondsSinceEpoch((element['dt']) * 1000);
      if (elementDate.day == (todayDate.day + i)) {
        _dayWeather.add(DayWeather.fromJson(element));
        i = i + 1;
      } else {
        return;
      }
    });

    return CityWeather(
      cityName: data['city']['name'],
      sunset:
          DateTime.fromMillisecondsSinceEpoch((data['city']['sunset']) * 1000),
      sunrise:
          DateTime.fromMillisecondsSinceEpoch((data['city']['sunrise']) * 1000),
      temperature: data['list'][0]['main']['temp'] - 273.15,
      feelsLike: data['list'][0]['main']['feels_like'] - 273.15,
      tempMax: data['list'][0]['main']['temp_max'] - 273.15,
      tempMin: data['list'][0]['main']['temp_min'] - 273.15,
      pressure: data['list'][0]['main']['pressure'],
      seaLevel: data['list'][0]['main']['sea_level'],
      humidity: data['list'][0]['main']['humidity'],
      groundLevel: data['list'][0]['main']['grnd_level'],
      windSpeed: data['list'][0]['wind']['speed'],
      windDegree: data['list'][0]['wind']['deg'],
      condition: data['list'][0]['weather'][0]['main'],
      description: data['list'][0]['weather'][0]['description'],
      iconCode: data['list'][0]['weather'][0]['icon'],
      timeStamp:
          DateTime.fromMillisecondsSinceEpoch((data['list'][0]['dt']) * 1000),
      hourlyWeatherList: _hourlyWeather,
      dayWeatherList: _dayWeather,
    );
  }

  IconData getIconData(){
    switch(this.iconCode){
      case '01d': return WeatherIcons.clear_day;
      case '01n': return WeatherIcons.clear_night;
      case '02d': return WeatherIcons.few_clouds_day;
      case '02n': return WeatherIcons.few_clouds_day;
      case '03d':
      case '04d':
        return WeatherIcons.clouds_day;
      case '03n':
      case '04n':
        return WeatherIcons.clear_night;
      case '09d': return WeatherIcons.shower_rain_day;
      case '09n': return WeatherIcons.shower_rain_night;
      case '10d': return WeatherIcons.rain_day;
      case '10n': return WeatherIcons.rain_night;
      case '11d': return WeatherIcons.thunder_storm_day;
      case '11n': return WeatherIcons.thunder_storm_night;
      case '13d': return WeatherIcons.snow_day;
      case '13n': return WeatherIcons.snow_night;
      case '50d': return WeatherIcons.mist_day;
      case '50n': return WeatherIcons.mist_night;
      default: return WeatherIcons.clear_day;
    }
  }

}
