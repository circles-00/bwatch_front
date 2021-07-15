import 'package:bwatch_front/providers/favorites_provider.dart';
import 'package:bwatch_front/screens/single_movie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<dynamic> singleMovieRoute(context, snapshot, favoritesData, index) {
  return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<FavoritesProvider>.value(
                value: FavoritesProvider(favoritesData.token),
                child: SingleMovie(
                    id: snapshot.data[index].id,
                    title: snapshot.data[index].title,
                    overview: snapshot.data[index].overview,
                    image: snapshot.data[index].image),
              )));
}
