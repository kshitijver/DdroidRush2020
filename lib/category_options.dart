import 'package:flutter/material.dart';

class CategoryOption extends StatelessWidget {
  final Color bgColor;
  final Icon icon;

  CategoryOption({this.icon, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: CircleAvatar(
        backgroundColor: bgColor,
        child: icon,
        radius: 30.0,
      ),
    );
  }
}
