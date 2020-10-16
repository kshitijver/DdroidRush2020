import 'package:flutter/material.dart';

class ContentPage extends StatelessWidget {
  final String country;
  final String city;
  final String image;

  ContentPage(
      {@required this.country, @required this.city, @required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('$city-$country'),
//        backgroundColor: Colors.lightBlueAccent,
//      ),
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
                  image: AssetImage(image),
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
                          padding: EdgeInsets.all(20),
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
