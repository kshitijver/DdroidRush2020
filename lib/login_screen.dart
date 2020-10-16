import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'signin.dart';
import 'sign_up.dart';
import 'widgets/RoundOutlineButton.dart';
import 'fireauth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  fireauth _auth=fireauth();
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Background.png'),
            fit: BoxFit.cover
          )
        ),
        child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 150.0,),
                        Center(child: Text("Welcome to ",textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Circular',fontSize: 15,color: Colors.white))),
                        SizedBox(height: 15.0,),
                        Text("Graphite",textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Circular',fontSize: 40,color: Colors.white,fontWeight: FontWeight.bold))
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: ButtonTheme(
                                  minWidth: double.infinity,
                                  child: RaisedButton(
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                                    child: Text("Sign in with Google",style: TextStyle(color: Colors.white),),
                                    onPressed: ()async{
                                       UserCredential user=await _auth.googleSignIn();
                                    },
                                  ),
                                ),
                              ),
                              RoundOutlineButton(tex: "Sign In",onpress:(){ Navigator.push(context,MaterialPageRoute(builder: (context)=>SignInPage()));}),
                              RoundOutlineButton(tex: "Sign Up",onpress:(){ Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUp()));}),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )

      ),
    );
  }
}


