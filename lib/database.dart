import './models/movie_model.dart';
import 'models/actor_model.dart';

List<Movie> mostPopular = [
  Movie(name: 'Hacker(2016)', image: 'assets/images/movie1.jpg', duration: 95),
  Movie(
      name: 'Léon: The Professional',
      image: 'assets/images/movie2.jpg',
      duration: 110),
  Movie(
    name: 'El Camino: A Breaking Bad Movie',
    image: 'assets/images/movie3.jpg',
    duration: 122,
  ),
  Movie(
    name: 'The Fast and the Furious: Tokyo Drift',
    image: 'assets/images/movie4.jpg',
    duration: 105,
  ),
];

List<Movie> latestReleases = [
  Movie(
      name: 'Léon: The Professional',
      image: 'assets/images/movie2.jpg',
      duration: 110),
  Movie(
    name: 'El Camino: A Breaking Bad Movie',
    image: 'assets/images/movie3.jpg',
    duration: 122,
  ),
  Movie(
    name: 'The Fast and the Furious: Tokyo Drift',
    image: 'assets/images/movie4.jpg',
    duration: 105,
  ),
];

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
