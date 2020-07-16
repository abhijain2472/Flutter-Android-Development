import 'package:flutter/material.dart';
import 'package:weather_app/models/day_weather.dart';
import 'package:weather_app/models/hourly_weather.dart';

class CityWeather {
  final String cityName;
  final DateTime sunset;
  final DateTime sunrise;
  final int temperature;
  final int feelsLike;
  final int pressure;
  final int tempMin;
  final int tempMax;
  final int seaLevel;
  final int groundLevel;
  final String condition;
  final String description;
  final String windSpeed;
  final String windDegree;
  final DateTime timeStamp;
  final List<HourlyWeather> hourlyWeatherList;
  final List<DayWeather> dayWeatherList;

  CityWeather({
    this.cityName,
    this.sunset,
    this.sunrise,
    this.temperature,
    this.feelsLike,
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
    return CityWeather(
      cityName: data['city']['name'],
      sunset:
          DateTime.fromMillisecondsSinceEpoch((data['city']['sunset']) * 1000),
      sunrise:
          DateTime.fromMillisecondsSinceEpoch((data['city']['sunrise']) * 1000),
      temperature: data['list'][0]['main']['temp'],
      feelsLike: data['list'][0]['main']['feels_like'],
      tempMax: data['list'][0]['main']['temp_max'],
      tempMin: data['list'][0]['main']['temp_min'],
      pressure: data['list'][0]['main']['pressure'],
      seaLevel: data['list'][0]['main']['sea_level'],
      groundLevel: data['list'][0]['main']['grnd_level'],
      windSpeed: data['list'][0]['wind']['speed'],
      windDegree: data['list'][0]['wind']['deg'],
      condition: data['list'][0]['weather'][0]['main'],
      description: data['list'][0]['weather'][0]['description'],
      timeStamp:
          DateTime.fromMillisecondsSinceEpoch((data['list'][0]['dt']) * 1000),

    );
  }
}
