import 'package:expendisureapp/image_handling.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'citycard_builder.dart';
import 'profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'firestorageservice.dart';
import 'category_options.dart';

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

  @override
  void initState() {
    curr = widget.curr;
    Fluttertoast.showToast(
        msg: "Login Successful",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 12.0);
    if(!curr.emailVerified)
      {
        Fluttertoast.showToast(
            msg: "Verify email to sign in again",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0);
      }
    super.initState();
    print(curr.displayName);
    print(curr.email);
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
                    'Places other users have visited',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
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
