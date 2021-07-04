import 'package:flutter/material.dart';

import 'screens/main_screen.dart';

void main() {
  runApp(BMusic());
}

class BMusic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BWatch",
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
