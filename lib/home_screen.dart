import "package:flutter/material.dart";

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ExpendiSure"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
          child: Container(),
        padding: EdgeInsets.all(15.0);
      )
    );
  }
}
