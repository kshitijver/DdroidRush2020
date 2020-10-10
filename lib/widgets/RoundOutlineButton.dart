import 'package:flutter/material.dart';

class RoundOutlineButton extends StatelessWidget {
  RoundOutlineButton({this.tex,this.onpress});
  final String tex;
  final Function onpress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ButtonTheme(
        minWidth: double.infinity,
        child: OutlineButton(
          borderSide: BorderSide(color: Colors.white,style: BorderStyle.solid),
          onPressed: onpress,
          child: Text(tex,style: TextStyle(color: Colors.white),),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        ),
      ),
    );
  }
}