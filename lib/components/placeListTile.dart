import 'package:flutter/material.dart';
import 'package:novoprojetolocaliz/models/place.dart';

class Placelisttile extends StatelessWidget {
  final Place place;

  Placelisttile(this.place);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          spacing: 10,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(border: BoxBorder.all(width: 1)),
              child: Image.file(place.image!, fit: BoxFit.cover, scale: 0.5),
            ),
            Text(place.title!),
          ],
        ),
      ),
    );
  }
}
