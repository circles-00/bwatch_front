import 'package:bwatch_front/constants.dart';
import 'package:bwatch_front/providers/movies_provider.dart';
import 'package:bwatch_front/widgets/recommended_movies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleMovie extends StatefulWidget {
  final int id;
  final String title;
  final String overview;
  final String image;

  SingleMovie(
      {required this.id,
      required this.title,
      required this.overview,
      required this.image});

  @override
  _SingleMovieState createState() => _SingleMovieState();
}

class _SingleMovieState extends State<SingleMovie> {
  List<int> _favIDs = [];
  List<int> _watchListIDs = [];
  bool _isFavorite = false;
  bool _isInWatchList = false;
  bool _favIsCalled = false;
  bool _watchListIsCalled = false;

  @override
  Widget build(BuildContext context) {
    final moviesData = Provider.of<MoviesProvider>(context);
    moviesData.favoriteIDs.then((value) {
      if (mounted && _favIsCalled == false) {
        setState(() {
          _favIDs = value;
          if (_favIDs.contains(widget.id)) {
            _isFavorite = true;
          }
        });
      }
    });
    moviesData.watchListIDs.then((value) {
      if (mounted && _watchListIsCalled == false) {
        setState(() {
          _watchListIDs = value;
          if (_watchListIDs.contains(widget.id)) {
            _isInWatchList = true;
          }
        });
      }
    });
    return Scaffold(
        backgroundColor: Color(kPrimaryColor),
        appBar: AppBar(
          title: Text(this.widget.title),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          backgroundColor: Color(kPrimaryColor),
          actions: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 20, right: 10, left: 15),
                    child: GestureDetector(
                      onTap: () {
                        if (_isInWatchList) {
                          moviesData.removeMovieFromWatchList(widget.id);
                          setState(() {
                            _isInWatchList = false;
                            _watchListIsCalled = true;
                          });
                        } else {
                          moviesData.addMovieToWatchList(widget.id);
                          setState(() {
                            _isInWatchList = true;
                            _watchListIsCalled = true;
                          });
                        }
                      },
                      child: Icon(
                        _isInWatchList
                            ? Icons.bookmark_add
                            : Icons.bookmark_add_outlined,
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 20, right: 15),
                    child: GestureDetector(
                        onTap: () {
                          if (_isFavorite) {
                            moviesData.removeFavorite(widget.id);
                            setState(() {
                              _isFavorite = false;
                              _favIsCalled = true;
                            });
                          } else {
                            moviesData.addFavorite(widget.id);
                            setState(() {
                              _isFavorite = true;
                              _favIsCalled = true;
                            });
                          }
                        },
                        child: _isFavorite
                            ? Icon(Icons.favorite, color: Colors.red)
                            : Icon(Icons.favorite_border_outlined,
                                color: Colors.red)))
              ],
            ),
          ],
        ),
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            Container(
              height: 20,
            ),
            Image(
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500' + this.widget.image),
            ),
            Container(
              height: 30,
            ),
            Text(
              "Movie description:\n",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: Text(
                this.widget.overview,
                style: TextStyle(
                  fontSize: 17,
                  wordSpacing: 3,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text('Related Movies',
                  style: TextStyle(fontSize: 25, color: Colors.white)),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              height: 300,
              child: RecommendedMovies(this.widget.id, () {}),
            ),
          ],
        ));
  }
}
