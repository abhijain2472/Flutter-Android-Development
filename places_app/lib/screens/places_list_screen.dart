import 'package:flutter/material.dart';
import 'package:placesapp/providers/great_places.dart';
import 'package:placesapp/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place List'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              }),
        ],
      ),
      body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
              ? Center(
            child: CircularProgressIndicator(),
          ):Consumer<GreatPlaces>(
            child: Center(
              child: Text('No PLaces added yet !!'),
            ),
            builder: (ctx, greatPlaces, ch) =>greatPlaces.items.length<=0 ? ch : ListView.builder(
              itemCount: greatPlaces.items.length,
              itemBuilder: (ctx, i) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(greatPlaces.items[i].image),
                ),
                title: Text(greatPlaces.items[i].title),
              ),
            ),
          ),
      )
    );
  }
}
