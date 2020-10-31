import 'package:expendisureapp/mapbox.dart';
import 'package:flutter/material.dart';
import 'weather.dart';

class ContentPage extends StatefulWidget {
  final String country;
  final String city;
  final Image image;
  final String rating;
  final double latitude;
  final double longitude;
  ContentPage(
      {@required this.country,
      @required this.city,
      @required this.image,
      @required this.rating,
      @required this.longitude,
      @required this.latitude});
  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  var weatherData = {};
  var country;
  var city;
  var image;
  var rating;
  var latitude;
  var longitude;

  @override
  void initState() {
    country = widget.country;
    city = widget.city;
    image = widget.image;
    rating = widget.rating;
    latitude = widget.latitude;
    longitude = widget.longitude;

    getWeather(latitude, longitude);
    print(weatherData.toString());
    super.initState();
  }

  Future getWeather(double lat, double long) async {
    Weather weather = Weather(latitude: lat, longitude: long);
    weatherData = await weather.getLocationWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.map),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapScreen(
                longitude: longitude,
                latitude: latitude,
              ),
            ),
          );
        },
      ),
      backgroundColor: Color(0xff30395A),
      body: Container(
//        width: ,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                child: Image(
                  image: image?.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 20),
                          child: Container(
                            child: Text(
                              city,
                              style: TextStyle(
                                color: Color(0xffAFB6D2),
                                fontSize: 40,
                                fontFamily: 'Circular',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                          child: Container(
                            child: Text(
                              country,
                              style: TextStyle(
                                color: Color(0xffAFB6D2),
                                fontSize: 20,
                                fontFamily: 'Circular',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                          child: Container(
                            child: Text(
                              'Rating: ' + rating,
                              style: TextStyle(
                                color: Color(0xffAFB6D2),
                                fontSize: 20,
                                fontFamily: 'Circular',
                              ),
                            ),
                          ),
                        ),
                      ),
//                      Container(
//                        child: Padding(
//                          padding: EdgeInsets.only(left: 20, right: 20, top: 5),
//                          child: Container(
//                            child: Text(
//                              weatherData.weather[0].description,
//                              style: TextStyle(
//                                color: Color(0xffAFB6D2),
//                                fontSize: 20,
//                                fontFamily: 'Circular',
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
