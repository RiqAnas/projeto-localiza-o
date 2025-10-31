import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class Imageinput extends StatefulWidget {
  final Function onSelectedImage;

  Imageinput(this.onSelectedImage);

  @override
  State<Imageinput> createState() => _ImageinputState();
}

class _ImageinputState extends State<Imageinput> {
  File? _storedImage;

  _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    XFile imagePicked =
        await _picker.pickImage(source: ImageSource.camera, maxWidth: 600)
            as XFile;

    setState(() {
      _storedImage = File(imagePicked.path);
    });

    final appDir = await syspath.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');
    widget.onSelectedImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(border: Border.all(width: 1)),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Text("Nenhuma Imagem"),
        ),
        SizedBox(width: 10),
        TextButton.icon(
          onPressed: _takePicture,
          label: Text("Tirar Foto"),
          icon: Icon(Icons.camera),
        ),
      ],
    );
  }
}
