import 'package:bwatch_front/constants.dart';
import 'package:bwatch_front/database.dart';
import 'package:bwatch_front/providers/data_provider.dart';
import 'package:bwatch_front/routes/single_movie_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesWatchListHorizontal extends StatelessWidget {
  final token;
  final listType;
  FavoritesWatchListHorizontal(this.token, this.listType);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: this.listType == 'favorites'
            ? getFavoriteMovies(this.token)
            : getWatchList(this.token),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  singleRelatedMovieRoute(context, snapshot,
                      Provider.of<DataProvider>(context, listen: false), index);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 20),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(kAccentColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          width: 100,
                          height: 120,
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
                          margin: EdgeInsets.only(left: 15),
                          constraints: BoxConstraints(maxWidth: 100),
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
}
