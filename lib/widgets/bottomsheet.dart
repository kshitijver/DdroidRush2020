import 'package:flutter/material.dart';

class bottomsheet
{
  void settingModalBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera_alt),
                    title: new Text('Upload from Camera'),
                    onTap: () => {}
                ),
                new ListTile(
                  leading: new Icon(Icons.photo),
                  title: new Text('Upload from Gallery'),
                  onTap: () => {},
                ),
              ],
            ),
          );
        }
    );
  }
}