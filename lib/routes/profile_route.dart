import 'package:bwatch_front/providers/data_provider.dart';
import 'package:bwatch_front/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<dynamic> profileRoute(context, snapshot, globalData, index) {
  return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider<DataProvider>.value(
          value: DataProvider(token: globalData.token),
          child: Profile(
            id: snapshot.data[index].id,
            firstName: snapshot.data[index].firstName,
            lastName: snapshot.data[index].lastName,
            favoriteIDs: snapshot.data[index].favoriteIDs,
            watchListIDs: snapshot.data[index].watchListIDs,
          ),
        ),
      ));
}
