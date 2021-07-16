import 'package:bwatch_front/providers/data_provider.dart';
import 'package:bwatch_front/screens/single_movie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<dynamic> singleMovieRoute(context, snapshot, globalData, index) {
  return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<DataProvider>.value(
                value: DataProvider(token: globalData.token),
                child: SingleMovie(
                    id: snapshot.data[index].id,
                    title: snapshot.data[index].title,
                    overview: snapshot.data[index].overview,
                    image: snapshot.data[index].image),
              )));
}

Future<dynamic> singleRelatedMovieRoute(context, snapshot, globalData, index) {
  return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<DataProvider>.value(
                value: DataProvider(token: globalData.token),
                child: SingleMovie(
                    id: snapshot.data[index].id,
                    title: snapshot.data[index].title,
                    overview: snapshot.data[index].overview,
                    image: snapshot.data[index].image),
              )));
}
