import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class fireauth
{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> EmailPass(String email, String pass)
  async{
    FirebaseUser user=await _auth.signInWithEmailAndPassword(email: email, password: pass);
    return user;
  }

  Future<FirebaseUser> Create(String email, String pass)
  async{
    FirebaseUser user=await _auth.createUserWithEmailAndPassword(email: email, password: pass);
    return user;
  }

  Future<FirebaseUser> Current()
  async{
    FirebaseUser current=await _auth.currentUser();
    return current;
  }
}