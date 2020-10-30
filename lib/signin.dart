import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'widgets/mytextfield.dart';
import 'fireauth.dart';
import 'home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  String email, password;
  fireauth _fire=fireauth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Sign In"),
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 100.0,
          ),
          Image.asset('assets/images/Graphite.PNG'),
          Spacer(),
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
                    child: Text("Sign In",style: TextStyle(color: Colors.white),),
                    textColor: Colors.white,
                    disabledColor: Colors.black,
                    color: Colors.black,
                    hoverColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                    onPressed: ()
                    async{
                      try
                      {UserCredential user=await _fire.EmailPass(email, password);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(curr: user.user)));}
                      catch(e)
                      {
                        Fluttertoast.showToast(
                            msg: e.message,
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 12.0
                        );
                      }
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

