class Weather {
  final String city;
  final String region;
  final String country;
  final int temperature;
  final String icon;
  final String description;
  final int windSpeed;
  final int pressure;
  final int humidity;
  final bool isDay;
  final int windDegree;

  Weather(
    {this.city,
    this.region,
    this.country,
    this.temperature,
    this.icon,
    this.description,
    this.windSpeed,
    this.pressure,
    this.humidity,
    this.isDay,
    this.windDegree,}
  );

  factory Weather.fromJson(Map<String,dynamic> data){
    return Weather(
      city: data['location']['name'],
     region:  data['location']['region'],
      country: data['location']['country'],
      temperature: data['current']['temperature'],
      icon: data['current']['weather_icons'][0],
      description: data['current']['weather_descriptions'][0],
      humidity:data['current']['humidity'],
      windSpeed: data['current']['wind_speed'],
      windDegree: data['current']['wind_degree'],
      pressure: data['current']['pressure'],
      isDay: data['current']['is_day']=='yes'?true:false,

    );
  }
}
