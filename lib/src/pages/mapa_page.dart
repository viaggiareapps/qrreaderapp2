import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';


class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  final map = MapController();
  String tipoMapa = 'streets-v11';

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
            onPressed: (){
              map.move(scan.getLatLng(), 15);
            },
          )
        ],
      ),
      body: _crearFlutterMap(context, scan),
      floatingActionButton: _crearBotonFlotante(context, scan),
    );
  }

  Widget _crearBotonFlotante(BuildContext context,ScanModel scan ){

    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        if (tipoMapa == 'streets-v11') {
          tipoMapa = 'outdoors-v11';
        }else if(tipoMapa == 'outdoors-v11'){
          tipoMapa = 'light-v10';
        }else if(tipoMapa == 'light-v10'){
          tipoMapa = 'dark-v10';
        }else if(tipoMapa == 'dark-v10'){
          tipoMapa = 'satellite-v9';
        }else if(tipoMapa == 'satellite-v9'){
          tipoMapa = 'satellite-streets-v11';
        }else{
          tipoMapa = 'streets-v11';
        }
        setState(() {});
        map.move(scan.getLatLng(), 30);
        Future.delayed(Duration(milliseconds: 50),(){
          map.move(scan.getLatLng(), 15);
        });
      },
    );

  }

  Widget _crearFlutterMap(BuildContext context, ScanModel scan){
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15
        
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(context, scan),
      ],
    );
  }


  _crearMapa(){
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/'
                  '{z}/{x}/{y}?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1IjoidmlhZ2dpYXJlYXBwcyIsImEiOiJja2U5NmVmcjQxYm1hMnJyM254bTZlN2h5In0.XRO0ii2IYVV0wxf7iJAaTw',
        'id': 'mapbox/$tipoMapa',
      }
    );
  }

  _crearMarcadores(BuildContext context, ScanModel scan){

    return MarkerLayerOptions(
      markers: [
        Marker(
          width: 120.0,
          height: 120.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
            child: Icon(Icons.location_on,
            size: 80.0,
            color: Theme.of(context).primaryColor,),
          ),
        )
      ]
    );

  }

}