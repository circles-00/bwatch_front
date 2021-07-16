import 'package:bwatch_front/providers/movies_provider.dart';
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
  @override
  void initState() {
    super.initState();
    APIService.getJWT().then((value) {
      _userData = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => MoviesProvider(token: _userData!['token']),
      child: MaterialApp(
        title: "BWatch",
        home: StartupWidget(userData: _userData),
      ),
    );
  }
}
