import 'package:flutter/material.dart';
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
  var monochromeStyle = "mapbox://styles/adrak/ckgxjy9y32g2i19pgzdiyo2hq";
  var streetStyle = "mapbox://styles/adrak/ckgw24hrx0x3019pd9osgdbxu";
  var selectedStyle;
  var lat, long;

  @override
  void initState() {
    lat = widget.latitude;
    long = widget.longitude;
    selectedStyle = monochromeStyle;
    super.initState();
  }

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
        child: Icon(Icons.track_changes),
        onPressed: () {
          if (selectedStyle == monochromeStyle) {
            setState(() {
              selectedStyle = streetStyle;
            });
          } else {
            setState(() {
              selectedStyle = monochromeStyle;
            });
          }
        },
      ),
      body: Container(
        child: Center(
          child: MapboxMap(
            styleString: selectedStyle,
            onMapCreated: _onMapCreated,
            initialCameraPosition:
                CameraPosition(target: LatLng(lat, long), zoom: 11),
          ),
        ),
      ),
    );
  }
}
