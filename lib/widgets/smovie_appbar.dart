import 'package:bwatch_front/constants.dart';
import 'package:bwatch_front/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleMovieAppBar extends StatefulWidget {
  final int movieId;
  final String movieTitle;

  const SingleMovieAppBar(
      {Key? key, required this.movieId, required this.movieTitle})
      : super(key: key);
  @override
  _SingleMovieAppBarState createState() => _SingleMovieAppBarState();
}

class _SingleMovieAppBarState extends State<SingleMovieAppBar> {
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
          if (_favIDs.contains(widget.movieId)) {
            _isFavorite = true;
          }
        });
      }
    });
    moviesData.watchListIDs.then((value) {
      if (mounted && _watchListIsCalled == false) {
        setState(() {
          _watchListIDs = value;
          if (_watchListIDs.contains(widget.movieId)) {
            _isInWatchList = true;
          }
        });
      }
    });

    return AppBar(
      title: Text(widget.movieTitle),
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
                      moviesData.removeMovieFromWatchList(widget.movieId);
                      setState(() {
                        _isInWatchList = false;
                        _watchListIsCalled = true;
                      });
                    } else {
                      moviesData.addMovieToWatchList(widget.movieId);
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
                        moviesData.removeFavorite(widget.movieId);
                        setState(() {
                          _isFavorite = false;
                          _favIsCalled = true;
                        });
                      } else {
                        moviesData.addFavorite(widget.movieId);
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
    );
  }
}
