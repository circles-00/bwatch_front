import 'package:bwatch_front/database.dart';
import 'package:flutter/cupertino.dart';

class FavoritesProvider with ChangeNotifier {
  final String token;
  List<int> _ids = [];

  FavoritesProvider(this.token);

  Future<List<int>> get ids async {
    // print(token);
    await getFavoriteMovies(token).then((value) {
      _ids = value;
    });
    // print(_ids);
    return _ids;
  }

  Future<void> addFavorite(int id) async {
    await addFavoriteMovie(token, id);
  }

  Future<void> removeFavorite(int id) async {
    await removeFavoriteMovie(token, id);
  }
}
