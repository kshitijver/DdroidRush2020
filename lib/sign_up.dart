import 'package:expendisureapp/home_screen.dart';
import 'package:flutter/material.dart';
import 'widgets/mytextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'fireauth.dart';
import 'image_handling.dart';
import 'widgets/bottomsheet.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_image/firebase_image.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email, password,name; image_handler _img=image_handler();
  fireauth _fire=fireauth(); Image userimg; bottomsheet bs=bottomsheet();
  PickedFile _imageFile; File file;
  @override
  void initState() {
    userimg=Image.asset('assets/images/avatar.png');
    super.initState();
  }
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
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  backgroundImage: userimg.image,
                  radius: 70.0,
                ),
                CircleAvatar(
                  child: IconButton(
                    icon: Icon(Icons.edit,color: Colors.white,
                    ), 
                    onPressed: ()
                    {
                      setState(() {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext bc){
                              return Container(
                                child: new Wrap(
                                  children: <Widget>[
                                    new ListTile(
                                        leading: new Icon(Icons.camera_alt),
                                        title: new Text('Upload from Camera'),
                                        onTap: () async {
                                          _imageFile=await _img.pickImage(ImageSource.camera);
                                          file=await _img.cropImage(_imageFile);
                                          setState(() {
                                            userimg=Image.file(file);
                                          });
                                        }
                                    ),
                                    new ListTile(
                                      leading: new Icon(Icons.photo),
                                      title: new Text('Upload from Gallery'),
                                      onTap: () async {
                                      _imageFile=await _img.pickImage(ImageSource.gallery);
                                      file=await _img.cropImage(_imageFile);
                                      setState(() {
                                        userimg=Image.file(file);
                                      });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                        );
                      });
                    },
                  ),
                  backgroundColor: Colors.black,
                )
              ],
            ),
          ),
          SizedBox(height: 40.0,),
          Center(
            child: MyTextField(text: "Display Name",obscure: false,onchange: (value){name=value;},),
          ),
          SizedBox(height: 10.0),
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
                      await user.user.updateProfile(displayName: name,);
                      await user.user.updateEmail(email);
                      _fire.Reload();
                      User curr=await _fire.Current();
                      await _img.startUpload(file, 'ProfilePictures/$email.png');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(curr: curr)));
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

