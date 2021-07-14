import 'dart:convert';

import './models/movie_model.dart';
import 'package:http/http.dart' as http;

import 'models/actor_model.dart';

//Singleton
Future<List<Movie>> getMovies(String collectionType) async {
  var response = await http.get(Uri.parse(
      'https://bwatch.herokuapp.com/api/v1/movies/' + collectionType));

  var jsonData = json.decode(response.body)['data']['results'];
  // print(jsonData);
  List<Movie> movies = [];

  for (var m in jsonData) {
    Movie movie = Movie(
        id: m['id'],
        title: m['title'],
        overview: m['overview'],
        image: m['poster_path'],
        rating: m['vote_average'].toString());

    movies.add(movie);
  }

  // print(movies.length);

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
  // print(jsonData);
  List<Movie> movies = [];

  for (var m in jsonData) {
    Movie movie = Movie(
        id: m['id'],
        title: m['title'],
        overview: m['overview'],
        image: m['poster_path'] == null ? "" : m['poster_path'],
        rating: m['vote_average'].toString());
    movies.add(movie);
  }

  // print(movies);

  return movies;
}

Future<List<Movie>> getRecommended(id) async {
  // print(id);
  var response = await http.get(Uri.parse(
      'https://bwatch.herokuapp.com/api/v1/movies/recommended/' +
          id.toString()));

  var jsonData = json.decode(response.body)['data']['results'];
  // print(jsonData);
  List<Movie> movies = [];

  for (var m in jsonData) {
    Movie movie = Movie(
        id: m['id'],
        title: m['title'],
        overview: m['overview'],
        image: m['poster_path'] == null ? "" : m['poster_path'],
        rating: m['vote_average'].toStringAsFixed(1));
    movies.add(movie);
  }

  // print(movies);

  return movies;
}

// Get favorite movies of user
Future<List<int>> getFavoriteMovies(String token) async {
  // print(token);
  var response = await http.get(
      Uri.parse('https://bwatch.herokuapp.com/api/v1/users/favorites/'),
      headers: {"authorization": "Bearer $token"});

  var jsonData = json.decode(response.body)['data'];
  // print(jsonData);
  List<int> movies = [];

  for (var m in jsonData) {
    movies.add(m);
  }

  // print(movies.length);

  return movies;
}

Future<void> addFavoriteMovie(String token, int id) async {
  // print(token);
  var response = await http.get(
      Uri.parse('https://bwatch.herokuapp.com/api/v1/users/favorites/add/' +
          id.toString()),
      headers: {"authorization": "Bearer $token"});

  var jsonData = json.decode(response.body);
  print(jsonData);

  // print(movies.length);
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
