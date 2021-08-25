import 'package:bwatch_front/constants.dart';
import 'package:bwatch_front/providers/data_provider.dart';
import 'package:bwatch_front/screens/single_actor.dart';
import 'package:bwatch_front/widgets/recommended_movies.dart';
import 'package:bwatch_front/widgets/app_bars/smovie_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database.dart';

class SingleMovie extends StatefulWidget {
  final int id;
  final String title;
  final String overview;
  final String image;
  final List genres;
  final String rating;

  SingleMovie(
      {required this.id,
      required this.title,
      required this.overview,
      required this.image,
      required this.genres,
      required this.rating});

  @override
  _SingleMovieState createState() => _SingleMovieState();
}

class _SingleMovieState extends State<SingleMovie> {
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

    // Check if movie is fav/watchlist

    if (favIDs.contains(widget.id) && _isFavorite == false) {
      setState(() {
        _isFavorite = true;
      });
    }

    if (watchListIDs.contains(widget.id) && _isInWatchList == false) {
      setState(() {
        _isInWatchList = true;
      });
    }
    // Favorites/WatchList Add/Remove Buttons
    addToFav() {
      globalData.addFavorite(widget.id);
      setState(() {
        _isFavorite = true;
        favIDs.add(widget.id);
      });
    }

    removeFromFav() {
      globalData.removeFavorite(widget.id);
      setState(() {
        _isFavorite = false;
        favIDs.remove(widget.id);
      });
    }

    addToWatchList() {
      globalData.addMovieToWatchList(widget.id);
      setState(() {
        _isInWatchList = true;
        watchListIDs.add(widget.id);
      });
    }

    removeFromWatchList() {
      globalData.removeMovieFromWatchList(widget.id);
      setState(() {
        _isInWatchList = false;
        watchListIDs.remove(widget.id);
      });
    }

    return Scaffold(
        backgroundColor: Color(kPrimaryColor),
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: SingleMovieAppBar(
              movieId: this.widget.id,
              movieTitle: this.widget.title,
            )),
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            Container(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Container(
                  height: 200,
                  width: 100,
                  child: Image(
                    image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500' + this.widget.image),
                  ),
                ),
                Column(children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 45),
                    constraints: BoxConstraints(maxWidth: 150, maxHeight: 150),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        this.widget.overview,
                        style: TextStyle(
                          fontSize: 12,
                          wordSpacing: 3,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 85,
              color: Color(kAccentColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 45, right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(
                          this.widget.rating + '/10',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 45, right: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
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
                                    color: Colors.red)),
                        Center(
                          child: Text(
                            'Favorite',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
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
                          child: _isInWatchList
                              ? Icon(Icons.bookmark_add, color: Colors.white)
                              : Icon(Icons.bookmark_add_outlined,
                                  color: Colors.white),
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: 60),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              'Watch Later',
                              style: TextStyle(color: Colors.white),
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5, top: 20),
              child: Text('Cast',
                  style: TextStyle(fontSize: 25, color: Colors.white)),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 120,
              child: FutureBuilder(
                future: getCast(widget.id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SingleActor(
                                      id: snapshot.data[index].id,
                                      name: snapshot.data[index].name,
                                      image: snapshot.data[index].image)));
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          snapshot.data[index].image),
                                  radius: 40,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  snapshot.data[index].name,
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text('Reviews',
                  style: TextStyle(fontSize: 25, color: Colors.white)),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 450,
              child: FutureBuilder(
                future: getReviews(widget.id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Icon(Icons.star, color: Colors.yellow),
                              Text(snapshot.data[index].rating,
                                  style: TextStyle(color: Colors.white)),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: 150,
                                child: Center(
                                  child: Text(
                                    'Author: ' + snapshot.data[index].author,
                                    style: TextStyle(color: Colors.white),
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CircleAvatar(
                                backgroundImage: NetworkImage(snapshot
                                        .data[index].image
                                        .toString()
                                        .contains('gravatar')
                                    ? 'https://secure.gravatar.com/avatar/' +
                                        snapshot.data[index].image
                                            .toString()
                                            .split('/https://secure.gravatar.com/avatar/')[
                                                1]
                                            .toString()
                                    : snapshot.data[index].image
                                            .toString()
                                            .contains('https')
                                        ? snapshot.data[index].image.toString()
                                        : 'https://image.tmdb.org/t/p/w500' +
                                            snapshot.data[index].image
                                                .toString()),
                                radius: 40,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth: 150, maxHeight: 250),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Text(
                                    snapshot.data[index].content,
                                    style: TextStyle(
                                      fontSize: 12,
                                      wordSpacing: 3,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ));
                    },
                  );
                },
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
              child: RecommendedMovies(this.widget.id),
            ),
          ],
        ));
  }
}
