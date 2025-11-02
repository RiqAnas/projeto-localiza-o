import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:novoprojetolocaliz/models/place.dart';

class Mappage extends StatefulWidget {
  final PlaceLocation initialLoc;
  final bool isReadOnly;

  Mappage({
    this.initialLoc = const PlaceLocation(lat: 36.4, long: -122.07),
    this.isReadOnly = false,
  });

  @override
  State<Mappage> createState() => _MappageState();
}

class _MappageState extends State<Mappage> {
  LatLng? _pickedPos;

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPos = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecione o local"),
        centerTitle: true,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        actions: [
          if (!widget.isReadOnly)
            IconButton(
              onPressed: _pickedPos == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedPos);
                    },
              icon: Icon(Icons.save),
            ),
        ],
      ),
      //gera o mapa
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLoc.lat!, widget.initialLoc.long!),
          zoom: 13,
        ),
        //coloca função que altere a posição selecionada(que depois será a função do marcador)
        onTap: widget.isReadOnly ? null : _selectPosition,
        //define como os marcadores serão postos(alterando a posição deles)
        markers: _pickedPos == null
            ? {
                Marker(
                  markerId: MarkerId("p"),
                  position: LatLng(
                    widget.initialLoc.lat!,
                    widget.initialLoc.long!,
                  ),
                ),
              }
            : {Marker(markerId: MarkerId("p"), position: _pickedPos!)},
      ),
    );
  }
}
