import 'dart:convert';

import './models/movie_model.dart';
import 'package:http/http.dart' as http;

import 'models/actor_model.dart';

//Singleton
Future<Singleton<Movie>> getMovies(String collectionType) async {
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
        image: m['poster_path']);

    movies.add(movie);
  }

  // print(movies.length);

  return movies;
}

// List<Movie> mostPopular = [
//   Movie(
//       id: 1,
//       title: 'Léon: The Professional',
//       image: 'assets/images/movie2.jpg',
//       overview: 'overview'),
//   Movie(
//       id: 2,
//       title: 'El Camino: A Breaking Bad Movie',
//       image: 'assets/images/movie3.jpg',
//       overview: 'overview'),
//   Movie(
//       id: 3,
//       title: 'The Fast and the Furious: Tokyo Drift',
//       image: 'assets/images/movie4.jpg',
//       overview: 'overview'),
// ];
//
// List<Movie> latestReleases = [
//   Movie(
//       id: 1,
//       title: 'Léon: The Professional',
//       image: 'assets/images/movie2.jpg',
//       overview: 'overview'),
//   Movie(
//       id: 2,
//       title: 'El Camino: A Breaking Bad Movie',
//       image: 'assets/images/movie3.jpg',
//       overview: 'overview'),
//   Movie(
//       id: 3,
//       title: 'The Fast and the Furious: Tokyo Drift',
//       image: 'assets/images/movie4.jpg',
//       overview: 'overview'),
// ];
//
List<Actor> featuredActors = [
  Actor(
      firstName: 'Jason',
      lastName: 'Statham',
      image: 'assets/images/actor1.jpg'),
  Actor(
      firstName: 'Aaron', lastName: 'Paul', image: 'assets/images/actor2.jpg'),
  Actor(firstName: 'Tom', lastName: 'Hardy', image: 'assets/images/actor3.jpg'),
  Actor(
      firstName: 'Cillian',
      lastName: 'Murphy',
      image: 'assets/images/actor4.jpg')
];

List<Actor> featuredActresses = [
  Actor(
      firstName: 'Chloë Grace',
      lastName: 'Moretz',
      image: 'assets/images/actress1.jpg'),
  Actor(
      firstName: 'Jennifer',
      lastName: 'Aniston',
      image: 'assets/images/actress2.png'),
  Actor(
      firstName: 'Angelina',
      lastName: 'Jolie',
      image: 'assets/images/actress3.jpg'),
  Actor(
      firstName: 'Emma',
      lastName: 'Watson',
      image: 'assets/images/actress4.jpg')
];
