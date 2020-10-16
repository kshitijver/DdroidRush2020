import 'package:flutter/material.dart';
import 'package:expendisureapp/SplashPage.dart';
import 'package:firebase_core/firebase_core.dart';
<<<<<<< HEAD
import 'login_screen.dart';
=======
import 'package:flutter/services.dart';
>>>>>>> master

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
