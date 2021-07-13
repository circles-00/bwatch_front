import 'package:bwatch_front/constants.dart';
import 'package:bwatch_front/widgets/movies_widget.dart';
import 'package:flutter/material.dart';

class SingleMovie extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(kPrimaryColor),
        appBar: AppBar(
          title: Text(this.title),
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
                    child: Icon(
                      Icons.bookmark_add_outlined,
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 20, right: 15),
                    child:
                        Icon(Icons.favorite_border_outlined, color: Colors.red))
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
              image:
                  NetworkImage('https://image.tmdb.org/t/p/w500' + this.image),
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
                this.overview,
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
              height: 300,
              child: MoviesWidget('upcoming', () {}),
            ),
          ],
        ));
  }
}
