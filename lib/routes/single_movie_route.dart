import 'package:bwatch_front/providers/movies_provider.dart';
import 'package:bwatch_front/screens/single_movie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<dynamic> singleMovieRoute(context, snapshot, moviesData, index) {
  return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<MoviesProvider>.value(
                value: MoviesProvider(token: moviesData.token),
                child: SingleMovie(
                    id: snapshot.data[index].id,
                    title: snapshot.data[index].title,
                    overview: snapshot.data[index].overview,
                    image: snapshot.data[index].image),
              )));
}

Future<dynamic> singleRelatedMovieRoute(context, snapshot, moviesData, index) {
  return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<MoviesProvider>.value(
                value: MoviesProvider(token: moviesData.token),
                child: SingleMovie(
                    id: snapshot.data[index].id,
                    title: snapshot.data[index].title,
                    overview: snapshot.data[index].overview,
                    image: snapshot.data[index].image),
              )));
}
