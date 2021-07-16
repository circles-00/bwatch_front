import 'package:bwatch_front/constants.dart';
import 'package:bwatch_front/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleMovieAppBar extends StatefulWidget {
  final int movieId;
  final String movieTitle;
  final List<int> favIDs;
  final List<int> watchListIDs;

  const SingleMovieAppBar(
      {Key? key,
      required this.movieId,
      required this.movieTitle,
      required this.favIDs,
      required this.watchListIDs})
      : super(key: key);
  @override
  _SingleMovieAppBarState createState() => _SingleMovieAppBarState();
}

class _SingleMovieAppBarState extends State<SingleMovieAppBar> {
  bool _isFavorite = false;
  bool _isInWatchList = false;

  @override
  void initState() {
    super.initState();

    if (widget.favIDs.contains(widget.movieId)) {
      _isFavorite = true;
    }
    if (widget.watchListIDs.contains(widget.movieId)) {
      _isInWatchList = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final moviesData = Provider.of<MoviesProvider>(context, listen: false);

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
                        widget.watchListIDs.remove(widget.movieId);
                      });
                    } else {
                      moviesData.addMovieToWatchList(widget.movieId);
                      setState(() {
                        _isInWatchList = true;
                        widget.watchListIDs.add(widget.movieId);
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
                          widget.favIDs.remove(widget.movieId);
                        });
                      } else {
                        moviesData.addFavorite(widget.movieId);
                        setState(() {
                          _isFavorite = true;
                          widget.favIDs.add(widget.movieId);
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
