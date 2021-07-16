import 'package:bwatch_front/constants.dart';
import 'package:bwatch_front/providers/data_provider.dart';
import 'package:bwatch_front/screens/login_screen.dart';
import 'package:bwatch_front/screens/search_screen.dart';
import 'package:bwatch_front/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomeScreenAppBar extends StatelessWidget {
  late String _firstName;
  late String _token;
  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<DataProvider>(context, listen: false);
    _firstName = globalData.getFirstName();
    _token = globalData.token;
    return AppBar(
      brightness: Brightness.dark,
      backgroundColor: Color(kPrimaryColor),
      elevation: 0,
      leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ChangeNotifierProvider<DataProvider>.value(
                  value: DataProvider(token: _token),
                  child: SearchScreen(),
                ),
              ),
            );
          },
          child: Icon(Icons.search)),
      actions: [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ' + _firstName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // Text('Macedonia', style: TextStyle(fontSize: 10)),
          ],
        ),
        Padding(
            padding: EdgeInsets.only(right: 8, left: 15),
            child: GestureDetector(
              onTap: () async {
                APIService auth = APIService();
                await auth.logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Icon(
                Icons.logout,
                size: 30,
              ),
            ))
      ],
    );
  }
}
