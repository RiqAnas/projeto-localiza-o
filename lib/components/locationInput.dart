import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:novoprojetolocaliz/Utils/locationUtil.dart';
import 'package:novoprojetolocaliz/pages/mapPage.dart';

class Locationinput extends StatefulWidget {
  final Function onSelectedPosition;

  Locationinput(this.onSelectedPosition);

  @override
  State<Locationinput> createState() => _LocationinputState();
}

class _LocationinputState extends State<Locationinput> {
  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    //pega localização atual do dispositivo
    final locData = await Location().getLocation();

    //gerar imagem no mapa
    final staticMapImageUrl = Locationutil.generationLocationPreviewImage(
      latitude: locData.latitude,
      longitude: locData.longitude,
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });

    //passar para o formulário
    widget.onSelectedPosition(LatLng(locData.latitude!, locData.longitude!));
  }

  Future<void> _selectOnMap() async {
    //faz com que ao dar um pop na tela seja retornado um valor
    final LatLng? selected = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Mappage(),
        fullscreenDialog: true,
      ),
    );

    if (selected == null) return;

    final staticMapImageUrl = Locationutil.generationLocationPreviewImage(
      latitude: selected.latitude,
      longitude: selected.longitude,
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });

    //vai passar o LatLang assim que o pop do Mappage for feito
    widget.onSelectedPosition(selected);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text("Nenhuma localização informada")
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _getCurrentUserLocation,
                label: Text("Localização atual"),
                icon: Icon(Icons.location_on),
                style: ElevatedButton.styleFrom(maximumSize: Size(150, 90)),
              ),
              ElevatedButton.icon(
                onPressed: _selectOnMap,
                label: Text("Selecione no mapa"),
                icon: Icon(Icons.map),
                style: ElevatedButton.styleFrom(maximumSize: Size(150, 90)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
