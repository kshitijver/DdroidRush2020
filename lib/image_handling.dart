import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'fireauth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firestorageservice.dart';

class image_handler
{
  PickedFile _imageFile;
  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://graphite-7b9e9.appspot.com');
  StorageUploadTask _uploadTask;
  final _fire=fireauth();

  Future<void> cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
    );
    _imageFile = cropped ?? _imageFile;
  }

  final ImagePicker _picker = ImagePicker();
  Future<void> pickImage(ImageSource source) async {
    PickedFile selected = await _picker.getImage(source: source);
    _imageFile = selected;
  }

  void clear() {
    _imageFile = null;
  }

  Future<Widget> getImage(BuildContext context) async {
    Image m; String image=await getname();
    await FireStorageService.loadFromStorage(context, image)
        .then((downloadUrl) {
      m = Image.network(
        downloadUrl.toString(),
        fit: BoxFit.scaleDown,
      );
    });

    return m;
  }

  startUpload(File file) async{
    String name=await getname();
    String filePath = 'ProfilePictures/$name.png';
    _uploadTask = _storage.ref().child(filePath).putFile(file);
    }

  Future<String> getname() async{
    User current=await _fire.Current();
    String name=current.displayName;
    return name;
  }
  }
