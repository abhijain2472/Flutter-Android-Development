import 'package:flutter/material.dart';

class DayWeather {
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
  final String dayName;

  DayWeather(
    {
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
    this.dayName,
  }
  );
}
