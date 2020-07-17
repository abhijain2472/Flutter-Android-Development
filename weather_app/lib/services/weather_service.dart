import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/city_weather.dart';
class WeatherService {
  final String locationUrl = 'http://ip-api.com/json';
  final String weatherBaseUrl =
      'http://api.openweathermap.org/data/2.5/forecast?q=';
  String cityName;
  final String appId='f5bc481e9be1b46aa675e128e24096ad';

  Future<String> getCurrentCity() async {
    http.Response response = await http.get(locationUrl);
    var data = jsonDecode(response.body);
    String city = data['city'];
    return city;
  }

  Future<CityWeather> getCurrentWeather({String city}) async {
    cityName = city ?? await getCurrentCity();
    http.Response response = await http.get(
      "http://api.openweathermap.org/data/2.5/forecast?q=ahmedabad&appid=f5bc481e9be1b46aa675e128e24096ad",

    );
    var data = jsonDecode(response.body);
    print(data);

    if (data['cod'].toString()=='200') {
      return CityWeather.fromJson(data);
    }else{
      return null;
    }

  }
}
