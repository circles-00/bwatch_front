import 'package:bwatch_front/constants.dart';
import 'package:flutter/material.dart';

class SingleActor extends StatelessWidget {
  final int id;
  final String name;
  final String image;

  SingleActor({required this.id, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(kPrimaryColor),
        appBar: AppBar(
          title: Text(this.name),
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back));
          }),
          backgroundColor: Color(kPrimaryColor),
          actions: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(right: 8, left: 15),
                    child: Icon(Icons.favorite))
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
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500' + this.image),
              ),
              Container(
                height: 30,
              ),
              // Center(
              //   child: Text(
              //     "Movie description:\n",
              //     style: TextStyle(
              //       fontSize: 15,
              //       color: Colors.white,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
            ]));
  }
}
