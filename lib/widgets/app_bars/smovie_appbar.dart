import 'package:bwatch_front/constants.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.movieTitle),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
      ),
      backgroundColor: Color(kPrimaryColor),
    );
  }
}
