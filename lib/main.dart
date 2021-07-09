import 'package:bwatch_front/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BMusic());
}

class BMusic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BWatch",
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
