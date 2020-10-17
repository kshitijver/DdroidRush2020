
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class fireauth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final google = GoogleSignIn();

  Future<UserCredential> EmailPass(String email, String pass) async {
    UserCredential user = await _auth.signInWithEmailAndPassword(
        email: email, password: pass);
    return user;
  }

  Future<UserCredential> Create(String email, String pass) async {
    UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email, password: pass);
    return user;
  }

  void out()
  async{
    await _auth.signOut();
  }

  Future<User> Current() async {
    User current = await _auth.currentUser;
    return current;
  }

  Future<UserCredential> googleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await google.signIn();
    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;


      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      UserCredential result = await _auth.signInWithCredential(credential);


      return result;
    }
  }
}
