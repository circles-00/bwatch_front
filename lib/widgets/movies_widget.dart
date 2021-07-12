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
                  margin: EdgeInsets.all(10),
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500' +
                                  snapshot.data[index].image),
                          fit: BoxFit.cover)),
                  // child: Padding(
                  //   padding: EdgeInsets.all(8),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         snapshot.data[index].title,
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 20,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ),
              );
            },
          );
        });
  }
}
