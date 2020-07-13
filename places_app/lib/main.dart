import 'package:flutter/material.dart';
import 'package:placesapp/providers/great_places.dart';
import 'package:placesapp/screens/add_place_screen.dart';
import 'package:placesapp/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.indigo,
          accentColor: Colors.amber
        ) ,
        home:PlacesListScreen() ,
        routes:{
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen()
        } ,
      ),

    );

  }
}

