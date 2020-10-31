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
  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://graphite-7b9e9.appspot.com');
  StorageUploadTask _uploadTask;
  final _fire=fireauth();

  Future<File> cropImage(PickedFile imageFile) async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
    );
    return cropped ?? File(imageFile.path);
  }

  final ImagePicker _picker = ImagePicker();
  Future<PickedFile> pickImage(ImageSource source) async {
    PickedFile selected = await _picker.getImage(source: source,imageQuality: 20);
    return selected;
  }



  Future<Widget> getImage(BuildContext context,String path) async {
    Image m;
    String image=path;
    await FireStorageService.loadFromStorage(context, image).then((downloadUrl) {
      m = Image.network(
        downloadUrl.toString(),
        fit: BoxFit.scaleDown,
      );
    });

    return m;
  }

  startUpload(File file,String path) async{
    String filePath = path;
    _uploadTask = _storage.ref().child(filePath).putFile(file);
    }

  startUploadMeta(File file,String path, StorageMetadata metaData) async{
    String filePath = path;
    _uploadTask = _storage.ref().child(filePath).putFile(file,metaData);
  }


  Future<String> getname() async{
    User current=await _fire.Current();
    String name=current.displayName;
    return name;
  }
  }
