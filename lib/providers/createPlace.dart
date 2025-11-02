import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:novoprojetolocaliz/Utils/db_util.dart';
import 'package:novoprojetolocaliz/Utils/locationUtil.dart';
import 'package:novoprojetolocaliz/models/place.dart';

class Createplace with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place getItemByIndex(int index) {
    return _items[index];
  }

  Future<void> loadPlaces() async {
    final datalist = await DbUtil.loadPlaces();
    _items = datalist
        .map(
          (item) => Place(
            id: item["id"],
            title: item["title"],
            location: PlaceLocation(
              lat: item["lat"],
              long: item["long"],
              address: item["address"],
            ),
            image: File(item["imagepath"]),
          ),
        )
        .toList();
    notifyListeners();
  }

  void addPlace(String placeT, File placeI, LatLng location) async {
    String address = await Locationutil.getAdressFromLatLng(location);
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: placeT,
      location: PlaceLocation(
        lat: location.latitude,
        long: location.longitude,
        address: address,
      ),
      image: placeI,
    );
    _items.add(newPlace);

    DbUtil.insert("places", {
      "id": newPlace.id,
      "title": newPlace.title,
      "imagepath": newPlace.image!.path,
      "lat": location.latitude,
      "long": location.longitude,
      "address": address,
    });
    notifyListeners();
  }
}
