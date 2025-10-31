import 'dart:io';

import 'package:flutter/material.dart';
import 'package:novoprojetolocaliz/components/imageInput.dart';

import 'package:novoprojetolocaliz/providers/createPlace.dart';
import 'package:provider/provider.dart';

class Placeformpage extends StatefulWidget {
  @override
  State<Placeformpage> createState() => _PlaceformpageState();
}

class _PlaceformpageState extends State<Placeformpage> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  _submitForm() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }

    final provider = Provider.of<Createplace>(context, listen: false);
    provider.addPlace(_titleController.text, _pickedImage!);

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
              ],
            ),
          ),
          Spacer(),
          ElevatedButton.icon(
            onPressed: _submitForm,
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
