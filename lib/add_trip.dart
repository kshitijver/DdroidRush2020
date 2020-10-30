import 'package:flutter/material.dart';
import 'widgets/appointment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MySpecialCard extends StatefulWidget {
  final User curr;
  MySpecialCard({this.curr});
  @override
  _MySpecialCardState createState() => _MySpecialCardState();
}

class _MySpecialCardState extends State<MySpecialCard> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference trips = FirebaseFirestore.instance.collection('Trips');
  User curr; int exp; String dest; var ret= List<String>();


  Future<void> addTrip(User us,String date, int exp, String dest) {
    return trips
        .add({
      'uid': us.uid,
      'Date': date, // Stokes and Sons
      'Destination': dest,
      'Expenditure': exp// 42
    })
        .then((value) { print("Trip Added");
        ret.add(dest);
        ret.add(date);})
        .catchError((error) => print("Failed to add trip: $error"));
  }
@override
  void initState() {
    curr=widget.curr;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text("Add new trip"),backgroundColor: Colors.black,),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 25.0),
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(21.0),
            boxShadow: [
              BoxShadow(
                blurRadius: 5.0,
                color: Colors.white,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Spacer(),
              Image.asset('assets/images/Graphite.PNG'),
//            Spacer(),
              AppointmentContainer(text: "Where to ?"),
              SizedBox(
                height: 9.0,
              ),
              Container(
                width: 200.0,
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xfff6f6f6),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      hintText: "Total Expenditure"),
                  onChanged: (value){exp=int.parse(value);},
                ),
              ),
              SizedBox(
                height: 9.0,
              ),
              Spacer(),
              Container(

                child: RaisedButton(
                  child: Text("Add Trip",style: TextStyle(color: Colors.white),),
                  textColor: Colors.white,
                  disabledColor: Colors.black,
                  color: Colors.black,
                  hoverColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                  onPressed: ()
                    async{
                    await addTrip(curr, "${AppointmentContainerState.selectedDate.toLocal()}".split(' ')[0], exp, AppointmentContainerState.dest);
                    Navigator.pop(context, ret);
                    },
                ),
                width: double.infinity,
                height: 70.0,
                padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),

              ),
            ],
          ),
        ),
      ),
    );
  }
}


