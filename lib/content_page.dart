import 'package:expendisureapp/category_options.dart';
import 'package:expendisureapp/mapbox.dart';
import 'package:flutter/material.dart';
import 'weather.dart';
import 'message_widget.dart';

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
  bool showWeather;
  var weatherData;
  var temp, desc, maxTemp, minTemp, humidity;
  var country;
  var city;
  var image;
  var rating;
  var latitude;
  var longitude;

  @override
  void initState() {
    showWeather = false;
    country = widget.country;
    city = widget.city;
    image = widget.image;
    rating = widget.rating;
    latitude = widget.latitude;
    longitude = widget.longitude;

    getWeather(latitude, longitude);
    super.initState();
  }

  void updateUI(dynamic weatherData) {
    if (weatherData == null) {
      temp = 0;
      desc = 'Unable to get weather';
      maxTemp = 0;
      minTemp = 0;
      humidity = 0;
    }
    setState(() {
      temp = (weatherData['main']['temp']).toInt();
      desc = weatherData['weather'][0]['description'];
      maxTemp = weatherData['main']['temp_max'];
      minTemp = weatherData['main']['temp_min'];
      humidity = weatherData['main']['humidity'];
    });
  }

  void getWeather(double lat, double long) async {
    Weather weather = Weather(latitude: lat, longitude: long);
    weatherData = await weather.getLocationWeather();
    updateUI(weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff30395A),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 5,
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
                  child: ListView(
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
                      ContentMessage(
                        message: country,
                      ),
                      ContentMessage(
                        message: 'Place Rating: ' + rating,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (showWeather == false) {
                                  setState(() {
                                    showWeather = true;
                                  });
                                } else {
                                  setState(() {
                                    showWeather = false;
                                  });
                                }
                              },
                              child: CategoryOption(
                                icon: Icon(
                                  Icons.nights_stay,
                                  size: 35,
                                  color: Color(0xff193C95),
                                ),
                                bgColor: Color(0xff98B4FF),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
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
                              child: CategoryOption(
                                icon: Icon(
                                  Icons.map,
                                  size: 30,
                                  color: Color(0xffA60718),
                                ),
                                bgColor: Color(0xffFFBDC5),
                              ),
                            ),
                            GestureDetector(
                              child: CategoryOption(
                                icon: Icon(
                                  Icons.local_taxi,
                                  size: 30,
                                  color: Color(0xff076831),
                                ),
                                bgColor: Color(0xff92FFBE),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: showWeather
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ContentMessage(
                                    message: 'Current Temperature: ${temp}°C',
                                  ),
                                  ContentMessage(
                                    message: 'Weather Conditions: ${desc}',
                                  ),
                                  ContentMessage(
                                    message: 'Max Temperature: ${maxTemp}°C',
                                  ),
                                  ContentMessage(
                                    message: 'Min Temperature: ${minTemp}°C',
                                  ),
                                  ContentMessage(
                                    message: 'Humidity: ${humidity}',
                                  ),
                                ],
                              )
                            : Container(),
                      ),
                      SizedBox(
                        height: 40,
                      )
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
