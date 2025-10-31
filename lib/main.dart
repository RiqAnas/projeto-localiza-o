import 'package:flutter/material.dart';
import 'package:novoprojetolocaliz/Utils/appRoutes.dart';
import 'package:novoprojetolocaliz/pages/placeFormPage.dart';
import 'package:novoprojetolocaliz/pages/primaryPage.dart';
import 'package:novoprojetolocaliz/providers/createPlace.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData lightTheme() {
    return ThemeData(
      secondaryHeaderColor: Colors.teal,
      colorSchemeSeed: Colors.teal,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
      create: (context) => Createplace(),
      child: MaterialApp(
        theme: lightTheme(),
        title: 'AppLocalizacao',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          Approutes.HOMEPAGE: (context) => Primarypage(),
          Approutes.FORMPAGE: (context) => Placeformpage(),
        },
      ),
    );
  }
}
