import 'dart:convert';

import './models/movie_model.dart';
import 'package:http/http.dart' as http;

import 'models/actor_model.dart';

//Singleton

Future<Movie> getSingleMovie(int id, String token) async {
  var response = await http.get(
      Uri.parse('https://bwatch.herokuapp.com/api/v1/movies/' + id.toString()),
      headers: {"authorization": "Bearer $token"});

  var jsonData = json.decode(response.body)['data'];
  Movie movie = Movie(
    id: jsonData['id'],
    title: jsonData['title'],
    overview: jsonData['overview'],
    image: jsonData['poster_path'],
    rating: jsonData['vote_average'].toStringAsFixed(1),
    genres: jsonData['genres'] == null ? [] : jsonData['genres'],
  );

  return movie;
}

Future<List<Movie>> getMovies(String collectionType) async {
  var response = await http.get(Uri.parse(
      'https://bwatch.herokuapp.com/api/v1/movies/' + collectionType));

  var jsonData = json.decode(response.body)['data']['results'];
  List<Movie> movies = [];

  for (var m in jsonData) {
    Movie movie = Movie(
        id: m['id'],
        title: m['title'],
        overview: m['overview'],
        image: m['poster_path'],
        rating: m['vote_average'].toString(),
        genres: m['genres'] == null ? [] : m['genres']);

    movies.add(movie);
  }

  return movies;
}

Future<List<Movie>> searchMovie(query) async {
  var response = await http.post(
      Uri.parse('https://bwatch.herokuapp.com/api/v1/movies/search/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'movieName': query.toString()}));

  var jsonData = json.decode(response.body)['data'];
  List<Movie> movies = [];

  for (var m in jsonData) {
    Movie movie = Movie(
        id: m['id'],
        title: m['title'],
        overview: m['overview'],
        image: m['poster_path'] == null ? "" : m['poster_path'],
        rating: m['vote_average'].toString(),
        genres: m['genres'] == null ? [] : m['genres']);
    movies.add(movie);
  }

  return movies;
}

Future<List<Movie>> getRecommended(id) async {
  var response = await http.get(Uri.parse(
      'https://bwatch.herokuapp.com/api/v1/movies/recommended/' +
          id.toString()));

  var jsonData = json.decode(response.body)['data']['results'];
  List<Movie> movies = [];

  for (var m in jsonData) {
    Movie movie = Movie(
        id: m['id'],
        title: m['title'],
        overview: m['overview'],
        image: m['poster_path'],
        rating: m['vote_average'].toStringAsFixed(1),
        genres: m['genres'] == null ? [] : m['genres']);
    movies.add(movie);
  }

  return movies;
}

// Get favorite movies of user
Future<List<int>> getFavoriteMoviesIds(String token) async {
  // print(token);
  var response = await http.get(
      Uri.parse('https://bwatch.herokuapp.com/api/v1/users/favorites/'),
      headers: {"authorization": "Bearer $token"});

  var jsonData = json.decode(response.body)['data'];
  List<int> movies = [];

  for (var m in jsonData) {
    movies.add(m);
  }

  return movies;
}

Future<List<Movie>> getFavoriteMovies(
    List<int> favoriteIds, String token) async {
  var ids = favoriteIds;
  List<Movie> movies = [];

  for (var id in ids) {
    Movie movie = await getSingleMovie(id, token);
    movies.add(movie);
  }

  return movies;
}

Future<void> addFavoriteMovie(String token, int id) async {
  await http.get(
      Uri.parse('https://bwatch.herokuapp.com/api/v1/users/favorites/add/' +
          id.toString()),
      headers: {"authorization": "Bearer $token"});
}

Future<void> removeFavoriteMovie(String token, int id) async {
  await http.get(
      Uri.parse('https://bwatch.herokuapp.com/api/v1/users/favorites/remove/' +
          id.toString()),
      headers: {"authorization": "Bearer $token"});
}

// WATCH-LIST
Future<List<int>> getWatchListIds(String token) async {
  var response = await http.get(
      Uri.parse('https://bwatch.herokuapp.com/api/v1/users/watch-list/'),
      headers: {"authorization": "Bearer $token"});

  var jsonData = json.decode(response.body)['data'];
  List<int> movies = [];

  for (var m in jsonData) {
    movies.add(m);
  }

  return movies;
}

Future<List<Movie>> getWatchList(List<int> watchListIds, String token) async {
  var ids = watchListIds;

  List<Movie> movies = [];

  for (var id in ids) {
    Movie movie = await getSingleMovie(id, token);
    movies.add(movie);
  }

  return movies;
}

Future<void> addToWatchList(String token, int id) async {
  await http.get(
      Uri.parse('https://bwatch.herokuapp.com/api/v1/users/watch-list/add/' +
          id.toString()),
      headers: {"authorization": "Bearer $token"});
}

Future<void> removeFromWatchList(String token, int id) async {
  await http.get(
      Uri.parse('https://bwatch.herokuapp.com/api/v1/users/watch-list/remove/' +
          id.toString()),
      headers: {"authorization": "Bearer $token"});
}

Future<List<Actor>> getActors() async {
  var response = await http
      .get(Uri.parse('https://bwatch.herokuapp.com/api/v1/actors/popular'));

  var jsonData = json.decode(response.body)['data']['results'];

  List<Actor> actors = [];

  for (var a in jsonData) {
    Actor actor = Actor(id: a['id'], name: a['name'], image: a['profile_path']);

    actors.add(actor);
  }

  return actors;
}
