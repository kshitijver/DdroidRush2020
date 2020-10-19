import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'content_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  final User curr;
  HomeScreen({@required this.curr});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  User curr;
  @override
  void initState() {
    curr=widget.curr;
    Fluttertoast.showToast(
        msg: "Login Successful",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 12.0
    );
    super.initState();
    print(curr.displayName);
    print(curr.email);
  }
  @override
  List<Color> colors= [Color(0xff3A4266), Color(0xff262E45)];

  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text("Graphite"),
//        backgroundColor: Color(0xffF05298),
//      ),
      backgroundColor: Color(0xff3A4266),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment(0.0, -1.0),
                  end: Alignment(0.0, 1.0),
                colors: [Color(0xff3A4266), Color(0xff262E45)]
                   ),),
          child: ListView(
            children: <Widget>[
//              Container(
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Padding(
//                      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
//                      child: Text(
//                        'welcome back,',
//                        style: TextStyle(
//                            color: Color(0xffAFB6D2),
//                            fontSize: 22,
//                            fontWeight: FontWeight.bold,
//                            fontFamily: 'Circular'),
//                        textAlign: TextAlign.left,
//                      ),
//                    ),
//                    Padding(
//                      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
//                      child: Text(
//                        'Kshitij',
//                        style: TextStyle(
//                            color: Color(0xffAFB6D2),
//                            fontSize: 22,
//                            fontWeight: FontWeight.bold, fontFamily: 'Circular'),
//                        textAlign: TextAlign.left,
//                      ),
//                    ),
//                  ],
//                ),
//              ),
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
                              enabledBorder:
                                  UnderlineInputBorder(borderSide: BorderSide.none),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffAFB6D2),
                                ),
                              ),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
                              labelText: 'Search term'),
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.account_circle),
                          iconSize: 40.0,
                          onPressed:(){ Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfilePage(curr: curr,)));
                          print(curr.displayName);},
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 289,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    CityCards(
                        image: 'assets/images/NewYork.jpg',
                        city: 'New York',
                        country: 'North America'),
                    CityCards(
                        image: 'assets/images/Germany.jpg',
                        city: 'Berlin',
                        country: 'Germany'),
                    CityCards(
                        image: 'assets/images/France.jpg',
                        city: 'Paris',
                        country: 'France'),
                    CityCards(
                        image: 'assets/images/Rome.jpg',
                        city: 'Rome',
                        country: 'Italy'),
                    CityCards(
                        image: 'assets/images/Norway.jpg',
                        city: 'Oslo',
                        country: 'Norway'),
                  ],
                ),
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
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: CircleAvatar(
                        backgroundColor: Color(0xff98B4FF),
                        child: Icon(
                          Icons.local_airport,
                          size: 30,
                          color: Color(0xff193C95),
                        ),
                        radius: 30.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: CircleAvatar(
                        backgroundColor: Color(0xffFFF1AB),
                        child: Icon(
                          Icons.airline_seat_individual_suite,
                          size: 30,
                          color: Color(0xffC3A938),
                        ),
                        radius: 30.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3, bottom: 3, left: 20),
                      child: CircleAvatar(
                        backgroundColor: Color(0xffFFA8DB),
                        child: Icon(
                          Icons.train,
                          size: 30,
                          color: Color(0xff811956),
                        ),
                        radius: 30.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: CircleAvatar(
                        backgroundColor: Color(0xffFFBDC5),
                        child: Icon(
                          Icons.restaurant,
                          size: 30,
                          color: Color(0xffA60718),
                        ),
                        radius: 30.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: CircleAvatar(
                        backgroundColor: Color(0xff92FFBE),
                        child: Icon(
                          Icons.local_taxi,
                          size: 30,
                          color: Color(0xff076831),
                        ),
                        radius: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
//            Padding(
//              padding: EdgeInsets.symmetric(horizontal: 10),
//              child: StaggeredGridView.countBuilder(
//                crossAxisCount: 4,
//                itemCount: 8,
//                itemBuilder: (BuildContext context, int index) => Container(
//                    color: Colors.green,
//                    child: Center(
//                      child: CircleAvatar(
//                        backgroundColor: Colors.white,
//                        child: Text('$index'),
//                      ),
//                    )),
//                staggeredTileBuilder: (int index) =>
//                    StaggeredTile.count(2, index.isEven ? 2 : 1),
//                mainAxisSpacing: 4.0,
//                crossAxisSpacing: 4.0,
//              ),
//            ),
            ],
          ),
        ),
      ),
    );
  }
}

class CityCards extends StatelessWidget {
  final String image;
  final String country;
  final String city;

  CityCards({this.image, this.city, this.country});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),

//          color: Color(0xff1D2541),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
            ),
            Container(
              width: 170,
              height: 79,
//            margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
//              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff232A44),
//              borderRadius: BorderRadius.only(
//                bottomRight: Radius.circular(20),
//                bottomLeft: Radius.circular(20),
//              ),
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
                          style: TextStyle(color: Colors.white, fontSize: 15),
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
                          style: TextStyle(color: Colors.white, fontSize: 12),
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
                          'Lorem Ipsum',
                          style: TextStyle(color: Colors.white, fontSize: 12),
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
