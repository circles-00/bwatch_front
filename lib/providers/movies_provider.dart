import 'package:bwatch_front/database.dart';
import 'package:flutter/cupertino.dart';

class MoviesProvider with ChangeNotifier {
  final String token;
  List<int> _favoriteIDs = [];
  List<int> _watchListIDs = [];

  MoviesProvider(this.token);

  Future<List<int>> get favoriteIDs async {
    // print(token);
    await getFavoriteMovies(token).then((value) {
      _favoriteIDs = value;
    });
    // print(_ids);
    return _favoriteIDs;
  }

  Future<void> addFavorite(int id) async {
    await addFavoriteMovie(token, id);
  }

  Future<void> removeFavorite(int id) async {
    await removeFavoriteMovie(token, id);
  }

  Future<List<int>> get watchListIDs async {
    // print(token);
    await getWatchList(token).then((value) {
      _watchListIDs = value;
    });
    // print(_ids);
    return _watchListIDs;
  }

  Future<void> addMovieToWatchList(int id) async {
    await addToWatchList(token, id);
  }

  Future<void> removeMovieFromWatchList(int id) async {
    await removeFromWatchList(token, id);
  }
}
