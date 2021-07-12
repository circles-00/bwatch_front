import 'dart:convert';

import 'package:bwatch_front/screens/login_screen.dart';
import 'package:bwatch_front/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/auth_service.dart';

void main() {
  runApp(BWatch());
}

class BWatch extends StatelessWidget {
  Future<String> getJWT() async {
    var prefs = await SharedPreferences.getInstance();
    var userData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;

    var jwt = userData['token'];
    if (jwt == "init") {
      return "";
    }
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "BWatch",
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: getJWT(),
          builder: (context, snapshot) {
            if (snapshot.data != "") {
              var str = snapshot.data.toString();
              var jwt = str.split(".");

              if (jwt.length != 3) {
                return LoginScreen();
              } else {
                var payload = json.decode(
                    ascii.decode(base64.decode(base64.normalize(jwt[1]))));
                if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                    .isAfter(DateTime.now())) {
                  return MainScreen();
                } else {
                  return LoginScreen();
                }
              }
            } else
              return LoginScreen();
          },
        ));
  }
}
