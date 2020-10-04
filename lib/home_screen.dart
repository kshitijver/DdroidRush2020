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
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Row(
                children: <Widget>[
              Expanded(
                child: Container(
                color: Colors.pink,
                  child: Center(child: Text("This is the first container", style: TextStyle(color: Colors.black),))),
              ),
    Expanded(
      child: Container(
      color: Colors.teal,
      child: Center(child: Text("This is the first container"))),
    ),
                ],
              ),
            ),
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.blue,
                  child: Center(child: Text("This is the second container"))
                ),
              )
          ],
        )
      )
    );
  }
}
