import 'dart:convert';

import 'package:bwatch_front/screens/login_screen.dart';
import 'package:bwatch_front/screens/main_screen.dart';
import 'package:flutter/material.dart';

import 'services/auth_service.dart';

void main() {
  runApp(BWatch());
}

class BWatch extends StatelessWidget {
  // Future<Map<String, dynamic>?> getJWT() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   var userData =
  //       json.decode(prefs.getString('userData')!) as Map<String, dynamic>;

  //   var jwt = userData['token'];
  //   if (jwt == "init") {
  //     return null;
  //   }
  //   return userData;
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "BWatch",
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: APIService.getJWT(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              final userData = snapshot.data as Map<String, dynamic>;
              var jwt = userData['token'].split(".");

              if (jwt.length != 3) {
                return LoginScreen();
              } else {
                var payload = json.decode(
                    ascii.decode(base64.decode(base64.normalize(jwt[1]))));
                if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                    .isAfter(DateTime.now())) {
                  return MainScreen(
                      firstName: userData['firstName'],
                      token: userData['token']);
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
