import 'dart:convert';

import 'package:bwatch_front/models/review_model.dart';
import 'package:bwatch_front/models/user_model.dart';

import './models/movie_model.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';
import 'models/actor_model.dart';

//Singleton

Future<Movie> getSingleMovie(int id) async {
  var response =
      await http.get(Uri.parse('$api_base_url/api/v1/movies/' + id.toString()));

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
  var response = await http
      .get(Uri.parse('$api_base_url/api/v1/movies/' + collectionType));

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
  var response =
      await http.post(Uri.parse('$api_base_url/api/v1/movies/search/'),
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
  var response = await http.get(
      Uri.parse('$api_base_url/api/v1/movies/recommended/' + id.toString()));

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
Future<List<int>> getFavoriteMoviesIds(String id) async {
  var response = await http.get(
      Uri.parse('$api_base_url/api/v1/users/favorites/'),
      headers: {"id": id});

  var jsonData = json.decode(response.body)['data'];
  List<int> movies = [];

  for (var m in jsonData) {
    movies.add(m);
  }

  return movies;
}

Future<List<Movie>> getFavoriteMovies(List<int> favoriteIds) async {
  var ids = favoriteIds;
  List<Movie> movies = [];

  for (var id in ids) {
    Movie movie = await getSingleMovie(id);
    movies.add(movie);
  }

  return movies;
}

Future<void> addFavoriteMovie(String token, int id) async {
  await http.get(
      Uri.parse('$api_base_url/api/v1/users/favorites/add/' + id.toString()),
      headers: {"authorization": "Bearer $token"});
}

Future<void> removeFavoriteMovie(String token, int id) async {
  await http.get(
      Uri.parse('$api_base_url/api/v1/users/favorites/remove/' + id.toString()),
      headers: {"authorization": "Bearer $token"});
}

// WATCH-LIST
Future<List<int>> getWatchListIds(String id) async {
  var response = await http.get(
      Uri.parse('$api_base_url/api/v1/users/watch-list/'),
      headers: {"id": id});

  var jsonData = json.decode(response.body)['data'];
  List<int> movies = [];

  for (var m in jsonData) {
    movies.add(m);
  }

  return movies;
}

Future<List<Movie>> getWatchList(List<int> watchListIds) async {
  var ids = watchListIds;

  List<Movie> movies = [];

  for (var id in ids) {
    Movie movie = await getSingleMovie(id);
    movies.add(movie);
  }

  return movies;
}

Future<void> addToWatchList(String token, int id) async {
  await http.get(
      Uri.parse('$api_base_url/api/v1/users/watch-list/add/' + id.toString()),
      headers: {"authorization": "Bearer $token"});
}

Future<void> removeFromWatchList(String token, int id) async {
  await http.get(
      Uri.parse(
          '$api_base_url/api/v1/users/watch-list/remove/' + id.toString()),
      headers: {"authorization": "Bearer $token"});
}

Future<List<Actor>> getActors() async {
  var response =
      await http.get(Uri.parse('$api_base_url/api/v1/actors/popular'));

  var jsonData = json.decode(response.body)['data']['results'];

  List<Actor> actors = [];

  for (var a in jsonData) {
    Actor actor = Actor(id: a['id'], name: a['name'], image: a['profile_path']);

    actors.add(actor);
  }

  return actors;
}

Future<List<Actor>> getCast(movieId) async {
  var response = await http.get(
      Uri.parse('https://bwatch.herokuapp.com/api/v1/movies/cast/$movieId'));

  var jsonData = json.decode(response.body)['data']['cast'];

  List<Actor> actors = [];

  for (var a in jsonData) {
    if (a['profile_path'] != null) {
      Actor actor =
          Actor(id: a['id'], name: a['name'], image: a['profile_path']);
      actors.add(actor);
    }
  }

  return actors;
}

// Reviews

Future<List<Review>> getReviews(int id) async {
  var response =
      await http.get(Uri.parse('$api_base_url/api/v1/movies/reviews/$id'));

  var jsonData = json.decode(response.body)['data'];
  List<Review> reviews = [];

  for (var r in jsonData) {
    Review review = Review(
      author: r['author_details']['username'],
      content: r['content'],
      image: r['author_details']['avatar_path'],
      rating: r['author_details']['rating'] == null
          ? "1"
          : r['author_details']['rating'].toString(),
    );

    reviews.add(review);
  }
  return reviews;
}

// Users
Future<List<User>> searchUser(query) async {
  var response = await http.post(
      Uri.parse('https://bwatch.herokuapp.com/api/v1/users/search'),
      body: jsonEncode(<String, String>{'user': query.toString()}));

  var jsonData = json.decode(response.body)['data'];

  List<User> users = [];

  for (var u in jsonData) {
    User user = User(
        id: u['_id'],
        firstName: u['firstName'],
        lastName: u['lastName'],
        avatar: u['avatar'] == null ? 'init' : u['avatar'],
        favoriteIDs: u['favMovies'].cast<int>(),
        watchListIDs: u['watchList'].cast<int>());
    users.add(user);
  }

  return users;
}
