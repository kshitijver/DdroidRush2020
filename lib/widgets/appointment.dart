import 'package:flutter/material.dart';


class AppointmentContainer extends StatefulWidget {
  final String text;

  const AppointmentContainer({Key key, this.text}) : super(key: key);

  @override
  AppointmentContainerState createState() => AppointmentContainerState();
}

class AppointmentContainerState extends State<AppointmentContainer> {
  static DateTime selectedDate = DateTime.now();
  static String dest;

  static DateTime giveDate()
  {
    return selectedDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xfff6f6f6),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
              hintText: widget.text),
    onChanged: (value){dest=value;},
        ),
        SizedBox(
          height: 9,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xfff6f6f6),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  hintText: "${selectedDate.toLocal()}".split(' ')[0],
                ),
              ),
            ),
            SizedBox(width: 21),
            IconButton(icon: Icon(Icons.today), color: Colors.grey[600], onPressed: () async{ _selectDate(context);},),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
