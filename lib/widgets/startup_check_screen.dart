import 'dart:convert';

import 'package:bwatch_front/screens/login_screen.dart';
import 'package:bwatch_front/screens/main_screen.dart';
import 'package:flutter/material.dart';

class StartupWidget extends StatelessWidget {
  final userData;

  const StartupWidget({Key? key, this.userData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (userData != null) {
      var jwt = userData['token'].split(".");

      if (jwt.length != 3) {
        return LoginScreen();
      } else {
        var payload =
            json.decode(ascii.decode(base64.decode(base64.normalize(jwt[1]))));
        if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
            .isAfter(DateTime.now())) {
          return MainScreen(
              firstName: userData['firstName'], token: userData['token']);
        } else {
          return LoginScreen();
        }
      }
    } else
      return LoginScreen();
  }
}
