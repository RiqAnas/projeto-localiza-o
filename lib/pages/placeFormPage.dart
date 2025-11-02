import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:novoprojetolocaliz/components/imageInput.dart';
import 'package:novoprojetolocaliz/components/locationInput.dart';

import 'package:novoprojetolocaliz/providers/createPlace.dart';
import 'package:provider/provider.dart';

class Placeformpage extends StatefulWidget {
  @override
  State<Placeformpage> createState() => _PlaceformpageState();
}

class _PlaceformpageState extends State<Placeformpage> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPosition;

  void _selectPosition(LatLng pos) {
    setState(() {
      _pickedPosition = pos;
    });
  }

  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  bool _isValid() {
    return _titleController.text.isNotEmpty &&
        _pickedImage != null &&
        _pickedPosition != null;
  }

  _submitForm() {
    if (!_isValid()) {
      return;
    }

    final provider = Provider.of<Createplace>(context, listen: false);
    provider.addPlace(_titleController.text, _pickedImage!, _pickedPosition!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicione localização"),
        centerTitle: true,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(label: Text("Digite o local")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Imageinput(this._selectImage),
                ),
                SizedBox(height: 30),
                Locationinput(this._selectPosition),
              ],
            ),
          ),
          Spacer(),
          ElevatedButton.icon(
            onPressed: _isValid() ? _submitForm : null,
            label: Text("Adicionar"),
            icon: Icon(Icons.add),
            style: ElevatedButton.styleFrom(
              shape: LinearBorder(),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}
