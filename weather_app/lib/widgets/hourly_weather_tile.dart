import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/hourly_weather.dart';
import 'package:weather_app/widgets/value_tile.dart';

class HourlyWeatherTile extends StatelessWidget {
  final List<HourlyWeather> hourlyWeather;

  const HourlyWeatherTile({this.hourlyWeather});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: this.hourlyWeather.length,
        separatorBuilder: (context, index) => Divider(
          height: 100,
          color: Colors.white,
        ),
        padding: EdgeInsets.only(left: 10, right: 10),
        itemBuilder: (context, index) {
          final item = this.hourlyWeather[index];
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              color: Colors.white.withOpacity(0.1),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 8.0,
                ),
                child: Center(
                  child: ValueTile(
                    DateFormat('E, h a').format(item.timeStamp),
                    '${item.temperature.toStringAsFixed(1)}°',
                    iconData: item.getIconData(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
