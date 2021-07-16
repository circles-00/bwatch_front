import 'package:bwatch_front/providers/data_provider.dart';
import 'package:bwatch_front/widgets/startup_check_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/auth_service.dart';

void main() {
  runApp(BWatch());
}

class BWatch extends StatefulWidget {
  @override
  _BWatchState createState() => _BWatchState();
}

class _BWatchState extends State<BWatch> {
  Map<String, dynamic>? _userData;
  String _token = 'init';

  @override
  Widget build(BuildContext context) {
    APIService.getJWT().then((value) {
      if (_token == 'init') {
        setState(() {
          _userData = value;
          _token = _userData!['token'];
        });
      }
    });

    return ChangeNotifierProvider(
      create: (ctx) => DataProvider(token: _token),
      child: MaterialApp(
        title: "BWatch",
        home: StartupWidget(userData: _userData),
      ),
    );
  }
}
