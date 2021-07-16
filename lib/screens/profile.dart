import 'package:bwatch_front/constants.dart';
import 'package:bwatch_front/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<DataProvider>(context);
    return Scaffold(
      backgroundColor: Color(kPrimaryColor),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 50),
              width: 125,
              height: 125,
              child: Image(image: AssetImage('assets/images/empty_avatar.png')),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
              child: Text(
            globalData.getFirstName() + ' ' + globalData.getLastName(),
            style: TextStyle(fontSize: 25, color: Colors.white),
          ))
        ],
      ),
    );
  }
}
