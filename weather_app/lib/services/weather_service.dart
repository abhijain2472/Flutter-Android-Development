import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

class WeatherService {
  final String locationUrl = 'http://ip-api.com/json';
  final String weatherBaseUrl =
      'http://api.weatherstack.com/current?access_key=2b77eff7facde6b90af8a722878861b3&query=';
  String cityName;

  Future<String> getCurrentCity() async {
    http.Response response = await http.get(locationUrl);
    var data = jsonDecode(response.body);
    String city = data['city'];
    return city;
  }

  Future<Weather> getCurrentWeather({String city}) async {
    cityName = city ?? await getCurrentCity();
    http.Response response = await http.get(weatherBaseUrl + cityName);
    var data = jsonDecode(response.body);
    if(data['success']==null){
      return Weather.fromJson(data);
    }
   return null;
  }
}
