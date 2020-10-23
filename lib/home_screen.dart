import 'package:expendisureapp/image_handling.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'content_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'firestorageservice.dart';

final _firestore = FirebaseFirestore.instance;
final handler = image_handler();
final FirebaseStorage _storage =
    FirebaseStorage(storageBucket: 'gs://graphite-7b9e9.appspot.com');

class HomeScreen extends StatefulWidget {
  final User curr;
  HomeScreen({@required this.curr});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User curr;
//  List<Future<Widget>> dests;

  @override
  void initState() {
    curr = widget.curr;
    super.initState();
    print(curr.displayName);
    print(curr.email);
//    for (int i = 0; i < 6; i++) {
//      dests.add(getImage(context, i));
//    }
  }

  Future<Widget> getImage(BuildContext context, int index) async {
    Image m;
    String image = "destinations/dest-$index.jpg";
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
  List<Color> colors = [Color(0xff3A4266), Color(0xff262E45)];
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3A4266),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(0.0, -1.0),
                end: Alignment(0.0, 1.0),
                colors: [Color(0xff3A4266), Color(0xff262E45)]),
          ),
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Theme(
                  data: ThemeData(
                    cursorColor: Color(0xffAFB6D2),
                    hintColor: Colors.transparent,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              labelStyle: TextStyle(color: Color(0xffAFB6D2)),
                              prefixIcon: Icon(
                                Icons.search,
                                size: 30,
                                color: Color(0xffAFB6D2),
                              ),
                              filled: true,
                              fillColor: Color(0xff252C49),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffAFB6D2),
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              labelText: 'Search term'),
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.account_circle),
                          iconSize: 40.0,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage(
                                          curr: curr,
                                        )));
                            print(curr.displayName);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 289,
                child: CityCardBuilder(),
              ),
              Row(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 7, right: 20, bottom: 15, left: 20),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'See all',
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 66,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    CategoryOption(
                      icon: Icon(
                        Icons.local_airport,
                        size: 30,
                        color: Color(0xff193C95),
                      ),
                      bgColor: Color(0xff98B4FF),
                    ),
                    CategoryOption(
                      icon: Icon(
                        Icons.airline_seat_individual_suite,
                        size: 30,
                        color: Color(0xffC3A938),
                      ),
                      bgColor: Color(0xffFFF1AB),
                    ),
                    CategoryOption(
                      icon: Icon(
                        Icons.train,
                        size: 30,
                        color: Color(0xff811956),
                      ),
                      bgColor: Color(0xffFFA8DB),
                    ),
                    CategoryOption(
                      icon: Icon(
                        Icons.restaurant,
                        size: 30,
                        color: Color(0xffA60718),
                      ),
                      bgColor: Color(0xffFFBDC5),
                    ),
                    CategoryOption(
                      icon: Icon(
                        Icons.local_taxi,
                        size: 30,
                        color: Color(0xff076831),
                      ),
                      bgColor: Color(0xff92FFBE),
                    ),
                  ],
                ),
              ),
              Container(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 20, right: 20, bottom: 15, left: 20),
                  child: Text(
                    'Best Destinations',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
              ),
              Expanded(
                child: Container(
//                  decoration:
//                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  height: 578,
                  child: GridView.count(
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    scrollDirection: Axis.horizontal,
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 2,
                    // Generate 100 widgets that display their index in the List.
                    children: List.generate(6, (index) {
                      return FutureBuilder(
                        future: getImage(context, index),
                        builder: (BuildContext context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          Image dest = snapshot.data;
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: dest.image, fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(15)),
//                              child: dest,
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryOption extends StatelessWidget {
  final Color bgColor;
  final Icon icon;

  CategoryOption({this.icon, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: CircleAvatar(
        backgroundColor: bgColor,
        child: icon,
        radius: 30.0,
      ),
    );
  }
}

class CityCards extends StatefulWidget {
  final Image image;
  final String country;
  final String city;
  final rating;

  CityCards({this.image, this.city, this.country, this.rating});

  @override
  _CityCardsState createState() => _CityCardsState();
}

class _CityCardsState extends State<CityCards> {
  var country;
  var image;
  var city;
  var rating;

  @override
  void initState() {
    country = widget.country;
    city = widget.city;
    rating = widget.rating;
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
                          )));
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
                                country,
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
                                city,
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

class CityCardBuilder extends StatefulWidget {
  @override
  _CityCardBuilderState createState() => _CityCardBuilderState();
}

class _CityCardBuilderState extends State<CityCardBuilder> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("CityCards").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final cards = snapshot.data.docs;
          List<CityCards> cityCards = [];

          for (var citycard in cards) {
            var cityCard;
            final cityName = citycard.data()['city'];
            final countryName = citycard.data()['country'];
            final placeRating = citycard.data()['rating'];

            cityCard = CityCards(
              city: cityName,
              country: countryName,
              rating: placeRating,
            );
            cityCards.add(cityCard);
          }

          return ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: cityCards,
          );
        });
  }
}
