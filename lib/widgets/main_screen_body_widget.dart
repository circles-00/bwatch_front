import 'package:flutter/material.dart';

class MSBodyText extends StatelessWidget {
  final String text;
  MSBodyText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20),
        child: Text(
          this.text,
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ));
  }
}
