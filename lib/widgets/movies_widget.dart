import 'package:bwatch_front/screens/single_movie.dart';

import '../database.dart';
import 'package:flutter/material.dart';

class MoviesWidget extends StatelessWidget {
  final String listType;
  final Function() notifyParent;

  MoviesWidget(this.listType, this.notifyParent);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMovies(this.listType),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SingleMovie(
                              id: snapshot.data[index].id,
                              title: snapshot.data[index].title,
                              overview: snapshot.data[index].overview,
                              image: snapshot.data[index].image)));
                },
                child: Container(
                  margin: EdgeInsets.only(right: 15, left: 5),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(0xFF3b3d57),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          width: 150,
                          height: 225,
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
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
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
}
