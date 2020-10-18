import 'package:flutter/material.dart';
import 'image_handling.dart';
import 'fireauth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class ProfilePage extends StatefulWidget {
  final User curr;
  ProfilePage({this.curr});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final handler=image_handler();
  Image userimage; String name; final _fire=fireauth();
  User curr;

  @override
  void initState() {
    curr=widget.curr;
    print(curr.email);

   handler?.getImage(context,curr.email)?.then((userimg) {
     setState(() {
       userimage=userimg;
     });

   });
   if(userimage==null)
     {
       userimage=Image.asset('assets/images/avatar.png');
     }


    print(curr.displayName);
    print(curr.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          PopupMenuButton(icon: Icon(Icons.more_vert,color: Colors.black,),itemBuilder: (context) => [PopupMenuItem(child: Padding(padding: EdgeInsets.all(2.0),child: Text('Create new trip'),),value: 1,),
            PopupMenuItem(child: Padding(padding: EdgeInsets.all(2.0),child: Text('Sign Out'),),value: 2,)], onSelected: ((value) {
              if(value==2)
                {
                  _fire.out();
                  Phoenix.rebirth(context);
                }
          }),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'tag',
                child: Container(
                  height: 125.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(62.5),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: userimage?.image)),
                ),
              ),
              SizedBox(height: 25.0),
              Text(
                curr?.displayName==null?'Abhishek Agrawal':curr?.displayName,
                style: TextStyle(
                    fontFamily: 'Circular',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.0),
              Text(
                curr?.email==null?'abhishekagr06@gmail.com':curr?.email,
                style: TextStyle(fontFamily: 'Circular', color: Colors.grey),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '\$1400',
                            style: TextStyle(
                                fontFamily: 'Circular',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            'SPENT',
                            style: TextStyle(
                                fontFamily: 'Circular',
                                color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '31',
                            style: TextStyle(
                                fontFamily: 'Circular',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            'TRIPS',
                            style: TextStyle(
                                fontFamily: 'Circular',
                                color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.table_chart)),
                    IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }}