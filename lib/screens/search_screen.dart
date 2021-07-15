import 'package:bwatch_front/constants.dart';
import 'package:bwatch_front/database.dart';
import 'package:bwatch_front/providers/favorites_provider.dart';
import 'package:bwatch_front/routes/single_movie_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchInputController = TextEditingController();

  FutureBuilder searchResults() {
    final favoritesData = Provider.of<FavoritesProvider>(context);
    return FutureBuilder(
        future: searchMovie(_searchInputController.text.toString().trim()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(
                child: Text(
              'Start typing...',
              style: TextStyle(color: Colors.white),
            ));
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  singleMovieRoute(context, snapshot, favoritesData, index);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(kAccentColor),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500' +
                                        snapshot.data[index].image),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                            ),
                            Text(
                              snapshot.data[index].rating,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          constraints: BoxConstraints(maxWidth: 150),
                          child: Text(
                            snapshot.data[index].title,
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  void dispose() {
    _searchInputController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _searchInputController.addListener(searchResults);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(kPrimaryColor),
        appBar: AppBar(
          backgroundColor: Color(kPrimaryColor),
          title: TextField(
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(kAccentColor))),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                hintText: 'Search movie...',
                hintStyle: TextStyle(color: Colors.white)),
            style: TextStyle(color: Colors.white),
            controller: _searchInputController,
            autofocus: true,
            expands: false,
            onChanged: (text) {
              setState(() {});
            },
          ),
        ),
        body: searchResults());
  }
}
