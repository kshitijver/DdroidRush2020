import 'package:flutter/material.dart';
import 'content_page.dart';
import 'firestorageservice.dart';

class CityCards extends StatefulWidget {
  final String country;
  final String city;
  final String rating;
  final double latitude;
  final double longitude;

  CityCards(
      {this.city, this.country, this.rating, this.longitude, this.latitude});

  @override
  _CityCardsState createState() => _CityCardsState();
}

class _CityCardsState extends State<CityCards> {
  var country;
  var image;
  var city;
  var rating;
  var latitude;
  var longitude;

  @override
  void initState() {
    country = widget.country;
    city = widget.city;
    rating = widget.rating;
    latitude = widget.latitude;
    longitude = widget.longitude;
    getImage(context, city).then((value) {
      setState(() {
        image = value;
      });
    });
    if (image == null) {
      image = Image.asset("assets/images/landscape.png");
    }
    super.initState();
  }

  Future<Widget> getImage(BuildContext context, String city) async {
    Image m;
    String image = "images/$city.jpg";
    await FireStorageService.loadFromStorage(context, image)
        .then((downloadUrl) {
      m = Image.network(
        downloadUrl.toString(),
        fit: BoxFit.cover,
      );
    });

    return m;
  }

  @override
  Widget build(BuildContext context) {
    return (image == Image.asset("assets/images/landscape.png"))
        ? CircularProgressIndicator()
        : GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContentPage(
                    country: country,
                    image: image,
                    city: city,
                    rating: rating,
                    latitude: latitude,
                    longitude: longitude,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff061E28).withOpacity(0.6),
                    blurRadius: 10.0,
                    spreadRadius: 5.5,
                    offset: Offset(5.0, 5.0), // shadow direction: bottom right
                  )
                ],
              ),
              margin: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: image?.image,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                  ),
                  Container(
                    width: 170,
                    height: 79,
                    decoration: BoxDecoration(
                      color: Color(0xff232A44),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 7, top: 7),
                            child: Container(
//                    padding: EdgeInsets.all(6),
                              child: Text(
                                city,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 7, top: 7),
                            child: Container(
//                    padding: EdgeInsets.all(6),
                              child: Text(
                                country,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 7, top: 7),
                            child: Container(
//                    padding: EdgeInsets.all(6),
                              child: Text(
                                'Rating: $rating',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
