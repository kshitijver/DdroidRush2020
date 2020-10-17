import 'package:expendisureapp/home_screen.dart';
import 'package:flutter/material.dart';
import 'widgets/mytextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'fireauth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email, password,name;
  fireauth _fire=fireauth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Sign Up"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 100.0,
          ),
          Center(
            child: MyTextField(text: "Display Name",obscure: false,onchange: (value){name=value;},),
          ),
          Center(
            child: MyTextField(text: "Email",obscure: false,onchange: (value){email=value;},),
          ),
          SizedBox(height: 10.0,),
          Center(
            child: MyTextField(text: "Password", obscure: true,onchange: (value){password=value;}),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(

                  child: RaisedButton(
                    child: Text("Sign Up",style: TextStyle(color: Colors.white),),
                    textColor: Colors.white,
                    disabledColor: Colors.black,
                    color: Colors.black,
                    hoverColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                    onPressed: () async{
                      UserCredential user=await _fire.Create(email, password);
                      user.user.updateProfile(displayName: name);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                  ),
                  width: double.infinity,
                  height: 70.0,
                  padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),

                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

