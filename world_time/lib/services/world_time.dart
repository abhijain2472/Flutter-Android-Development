import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String url;
  String flag;
  bool isDaytime;

  WorldTime({this.location, this.url, this.flag});

  Future<void> getTime() async {
    try {
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      String offset = data['utc_offset'].substring(1, 3);
      String offsetmin = data['utc_offset'].substring(4, 6);
      String datetime = data['datetime'];
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset),minutes:int.parse(offsetmin)));
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('error caught : $e');
      time = 'can not get Time !!';
    }
  }
}
