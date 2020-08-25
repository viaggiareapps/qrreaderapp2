import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';


class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.my_location), 
            onPressed: (){},
          )
        ],
      ),
      body: _crearFlutterMap(scan)
    );
  }

  Widget _crearFlutterMap(ScanModel scan){
    return FlutterMap(
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 10
      ),
      layers: [
        _crearMapa(),
      ],
    );
  }

  _crearMapa(){
    return TileLayerOptions(
      urlTemplate: 'http://a.tiles.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1IjoidmlhZ2dpYXJlYXBwcyIsImEiOiJja2U5NmVmcjQxYm1hMnJyM254bTZlN2h5In0.XRO0ii2IYVV0wxf7iJAaTw',
        'id': 'mapbox.mapbox-streets-v7',
      }
    );
  }

}