import 'package:bwatch_front/database.dart';
import 'package:flutter/cupertino.dart';

class MoviesProvider with ChangeNotifier {
  static final MoviesProvider _instance = MoviesProvider._internal();

  static MoviesProvider get instance => _instance;

  MoviesProvider._internal();

  factory MoviesProvider({String token = 'init'}) {
    _instance.token = token;
    return _instance;
  }

  late String token;
  List<int> _favoriteIDs = [];
  List<int> _watchListIDs = [];

  // MoviesProvider(this.token);
  List<int> get favorites {
    return _favoriteIDs;
  }

  List<int> get watchList {
    return _watchListIDs;
  }

  setFavoriteIDs(favIds) {
    _favoriteIDs = favIds;
  }

  Future<void> addFavorite(int id) async {
    await addFavoriteMovie(token, id);
    notifyListeners();
  }

  Future<void> removeFavorite(int id) async {
    await removeFavoriteMovie(token, id);
    notifyListeners();
  }

  setWatchListIDs(watchIds) {
    // print(token);
    _watchListIDs = watchIds;
  }

  Future<void> addMovieToWatchList(int id) async {
    await addToWatchList(token, id);
    notifyListeners();
  }

  Future<void> removeMovieFromWatchList(int id) async {
    await removeFromWatchList(token, id);
    notifyListeners();
  }
}
