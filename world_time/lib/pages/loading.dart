import 'package:flutter/material.dart';
import 'package:worldtime/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  void setWorldTime()async{
    WorldTime instance=WorldTime(location:'Kolkata',flag: 'usai.png',url: 'Asia/Kolkata');
    await instance.getTime();
    Navigator.pushReplacementNamed(context,'/home',arguments: {
      'location':instance.location,
      'time':instance.time,
      'flag':instance.flag,
      'isDayTime': instance.isDaytime,
    });

  }


  @override
  void initState() {
    setWorldTime();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: SpinKitCircle(
            color: Colors.white,
            size: 80.0,
          ),

        ),
      ),
    );
  }
}
