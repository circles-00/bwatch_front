import 'package:bwatch_front/screens/login_screen.dart';
import 'package:bwatch_front/screens/main_screen.dart';
import 'package:flutter/material.dart';

class StartupWidget extends StatelessWidget {
  final userData;

  const StartupWidget({Key? key, this.userData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (userData != null) {
      if (DateTime.fromMillisecondsSinceEpoch(userData['tokenExp'] * 1000)
          .isAfter(DateTime.now())) {
        return MainScreen(
            firstName: userData['firstName'],
            lastName: userData['lastName'],
            token: userData['token'],
            id: userData['id']);
      } else {
        return LoginScreen();
      }
    } else
      return LoginScreen();
  }
}
