import 'package:flutter/material.dart';
import 'package:novoprojetolocaliz/Utils/appRoutes.dart';
import 'package:novoprojetolocaliz/components/placeList.dart';

class Primarypage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Localiz"),
        centerTitle: true,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(Approutes.FORMPAGE),
            icon: Icon(Icons.accessibility),
          ),
        ],
      ),
      body: Placelist(),
    );
  }
}
