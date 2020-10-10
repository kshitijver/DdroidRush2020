import 'package:flutter/material.dart';


class MyTextField extends StatelessWidget {
  MyTextField({this.text,this.onchange,this.obscure});
final String text; final Function onchange; final bool obscure;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      width: double.infinity,
      child: TextField(
        textAlign: TextAlign.center,
        onChanged: onchange,
        obscureText: obscure,
        decoration: InputDecoration(
            hintText: text,
            hintStyle: TextStyle(),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0)
            )
        ),

      ),
    );
  }
}
