import 'package:flutter/material.dart';
import 'package:novoprojetolocaliz/components/placeListTile.dart';
import 'package:novoprojetolocaliz/models/place.dart';
import 'package:novoprojetolocaliz/providers/createPlace.dart';
import 'package:provider/provider.dart';

class Placelist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: Provider.of<Createplace>(context, listen: false).loadPlaces(),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
          ? Center(child: CircularProgressIndicator())
          : Consumer<Createplace>(
              builder: (context, data, child) {
                List<Place> placeList = data.items;
                return ListView.builder(
                  itemCount: placeList.length,
                  itemBuilder: (context, index) =>
                      Placelisttile(placeList[index]),
                );
              },
            ),
    );
  }
}
