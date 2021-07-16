import 'package:bwatch_front/constants.dart';
import 'package:bwatch_front/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleMovieAppBar extends StatefulWidget {
  final int movieId;
  final String movieTitle;

  const SingleMovieAppBar({
    Key? key,
    required this.movieId,
    required this.movieTitle,
  }) : super(key: key);
  @override
  _SingleMovieAppBarState createState() => _SingleMovieAppBarState();
}

class _SingleMovieAppBarState extends State<SingleMovieAppBar> {
  bool _isFavorite = false;
  bool _isInWatchList = false;

  // Snackbars
  final _addToFavSnackbar = SnackBar(
    content: Text(
      'Added to favorites',
      style: TextStyle(color: Color(kPrimaryColor)),
    ),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 1),
    backgroundColor: Colors.white,
    margin: EdgeInsets.all(15),
  );

  final _removeFromFavSnackbar = SnackBar(
    content: Text('Removed from favorites',
        style: TextStyle(color: Color(kPrimaryColor))),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 1),
    backgroundColor: Colors.white,
    margin: EdgeInsets.all(15),
  );

  final _addToWatchListSnackbar = SnackBar(
    content: Text('Added to watch list',
        style: TextStyle(color: Color(kPrimaryColor))),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 1),
    backgroundColor: Colors.white,
    margin: EdgeInsets.all(15),
  );

  final _removeFromWatchListSnackbar = SnackBar(
    content: Text('Removed from watch list',
        style: TextStyle(color: Color(kPrimaryColor))),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 1),
    backgroundColor: Colors.white,
    margin: EdgeInsets.all(15),
  );

  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<DataProvider>(context, listen: false);
    List<int> favIDs = globalData.favorites;
    List<int> watchListIDs = globalData.watchList;

    // Favorites/WatchList Add/Remove Buttons
    addToFav() {
      globalData.addFavorite(widget.movieId);
      setState(() {
        _isFavorite = true;
        favIDs.add(widget.movieId);
      });
    }

    removeFromFav() {
      globalData.removeFavorite(widget.movieId);
      setState(() {
        _isFavorite = false;
        favIDs.remove(widget.movieId);
      });
    }

    addToWatchList() {
      globalData.addMovieToWatchList(widget.movieId);
      setState(() {
        _isInWatchList = true;
        watchListIDs.add(widget.movieId);
      });
    }

    removeFromWatchList() {
      globalData.removeMovieFromWatchList(widget.movieId);
      setState(() {
        _isInWatchList = false;
        watchListIDs.remove(widget.movieId);
      });
    }

    if (favIDs.contains(widget.movieId)) {
      setState(() {
        _isFavorite = true;
      });
    }

    if (watchListIDs.contains(widget.movieId)) {
      setState(() {
        _isInWatchList = true;
      });
    }

    return AppBar(
      title: Text(widget.movieTitle),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
      ),
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
                      removeFromWatchList();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(_removeFromWatchListSnackbar);
                    } else {
                      addToWatchList();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(_addToWatchListSnackbar);
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
                        removeFromFav();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(_removeFromFavSnackbar);
                      } else {
                        addToFav();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(_addToFavSnackbar);
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
