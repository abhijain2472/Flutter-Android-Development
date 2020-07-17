import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/day_weather.dart';

class DayWeatherTile extends StatelessWidget {
  final List<DayWeather> dayWeather;

  DayWeatherTile({this.dayWeather});

  @override
  Widget build(BuildContext context) {
    return Container(
//      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: this.dayWeather.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.white.withOpacity(0.4),
          indent: 25.0,
          endIndent: 25.0,
        ),
        padding: EdgeInsets.only(left: 10, right: 10),
        itemBuilder: (context, index) {
          final item = this.dayWeather[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                DateFormat('MMM dd').format(item.timeStamp),
                style: TextStyle(color: Colors.white),
              ),
              Text(
                item.dayName,
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                item.getIconData(),
                size: 20.0,
                color: Colors.white,
              ),
              Text(
                item.condition,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '${item.temperature.toStringAsFixed(1)}°',
                style: TextStyle(color: Colors.white),
              )
            ],
          );
        },
      ),
    );
  }
}
