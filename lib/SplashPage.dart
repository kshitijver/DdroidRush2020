import 'package:flutter/material.dart';
import 'package:expendisureapp/fireauth.dart';
import 'login_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'home_screen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}
enum LoginStatus{
  NotDetermined,
  LoggedIn,
  NotLoggedIn
}
class _SplashPageState extends State<SplashPage> {
  LoginStatus status=LoginStatus.NotDetermined;
  @override
  void initState() {
    fireauth _fire=fireauth();
    Future.delayed(const Duration(seconds: 3), () {
    _fire.Current().then((current)
    {
      setState(() {
        status=current==null?LoginStatus.NotLoggedIn:LoginStatus.LoggedIn;
      });
    });});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    switch(status)
    {
      case LoginStatus.NotDetermined:
        {
          return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Image.asset('assets/images/Graphite.PNG')
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 50.0, left: 10.0, right: 10.0),
                      child:
                        SpinKitFadingCube(color: Colors.black)
                    ),
                  )
                ],
              )
          );
        }
      case LoginStatus.LoggedIn:
        {
          return HomeScreen();
        }
      case LoginStatus.NotLoggedIn:
        {
          return LoginScreen();
        }
    }
  }
}

