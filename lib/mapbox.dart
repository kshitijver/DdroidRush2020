import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapScreen extends StatefulWidget {
  var latitude;
  var longitude;
  MapScreen({this.longitude, this.latitude});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMapController mapController;
  final monochromeStyle = "mapbox://styles/adrak/ckgxjy9y32g2i19pgzdiyo2hq";

  var lat, long;

  @override
  void initState() {
    lat = widget.latitude;
    long = widget.longitude;
    super.initState();
  }

//
  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Location'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.directions),
        onPressed: () {},
      ),
      body: Container(
        child: Center(
          child: MapboxMap(
            styleString: monochromeStyle,
            onMapCreated: _onMapCreated,
            initialCameraPosition:
                CameraPosition(target: LatLng(lat, long), zoom: 11),
          ),
        ),
      ),
    );
  }
}
