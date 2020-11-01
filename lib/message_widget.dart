import 'package:flutter/material.dart';

class ContentMessage extends StatelessWidget {
  final String message;

  ContentMessage({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 5),
        child: Container(
          child: Text(
            message,
            style: TextStyle(
              color: Color(0xffAFB6D2),
              fontSize: 20,
              fontFamily: 'Circular',
            ),
          ),
        ),
      ),
    );
  }
}
