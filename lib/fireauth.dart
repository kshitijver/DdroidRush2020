
import 'package:firebase_auth/firebase_auth.dart';


class fireauth
{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> EmailPass(String email, String pass)
  async{
    UserCredential user=await _auth.signInWithEmailAndPassword(email: email, password: pass);
    return user;
  }

  Future<UserCredential> Create(String email, String pass)
  async{
    UserCredential user=await _auth.createUserWithEmailAndPassword(email: email, password: pass);
    return user;
  }

  Future<User> Current()
  async{
    User current=await _auth.currentUser;
    return current;
  }
}