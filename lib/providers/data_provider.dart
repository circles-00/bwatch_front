import 'package:bwatch_front/database.dart';
import 'package:flutter/cupertino.dart';

class DataProvider with ChangeNotifier {
  static final DataProvider _instance = DataProvider._internal();

  static DataProvider get instance => _instance;

  DataProvider._internal();

  factory DataProvider({String token = 'init'}) {
    _instance.token = token;
    return _instance;
  }

  late String token;
  List<int> _favoriteIDs = [];
  List<int> _watchListIDs = [];
  late String _firstName;
  late String _lastName;

  // MoviesProvider(this.token);

  Future<void> addFavorite(int id) async {
    await addFavoriteMovie(token, id);
    notifyListeners();
  }

  Future<void> removeFavorite(int id) async {
    await removeFavoriteMovie(token, id);
    notifyListeners();
  }

  Future<void> addMovieToWatchList(int id) async {
    await addToWatchList(token, id);
    notifyListeners();
  }

  Future<void> removeMovieFromWatchList(int id) async {
    await removeFromWatchList(token, id);
    notifyListeners();
  }

  // Getters
  List<int> get favorites {
    return _favoriteIDs;
  }

  List<int> get watchList {
    return _watchListIDs;
  }

  // ignore: unnecessary_getters_setters
  String getFirstName() {
    return _firstName;
  }

  String getLastName() {
    return _lastName;
  }

  // Setters
  setFavoriteIDs(favIds) {
    _favoriteIDs = favIds;
  }

  setWatchListIDs(watchIds) {
    _watchListIDs = watchIds;
  }

  // ignore: unnecessary_getters_setters
  setFirstName(String name) {
    _firstName = name;
  }

  setLastName(String name) {
    _lastName = name;
  }
}
