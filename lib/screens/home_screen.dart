import 'package:bwatch_front/widgets/featured_actors_widget.dart';
import 'package:bwatch_front/widgets/main_screen_body_widget.dart';
import 'package:bwatch_front/widgets/movies_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MSBodyText('most'),
              MSBodyText('popular movies'),
              Container(
                constraints: BoxConstraints(maxWidth: 350),
                child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 20),
                    child: Text(
                      'Browse the most popular movies and save your favorites to a list',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                height: 300,
                child: MoviesWidget('popular'),
              ),
              SizedBox(
                height: 25,
              ),
              MSBodyText('upcoming'),
              MSBodyText('movies'),
              Container(
                constraints: BoxConstraints(maxWidth: 350),
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 10, bottom: 20),
                  child: Text(
                    'Browse the upcoming movies and save your favorites to a list',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                height: 300,
                child: MoviesWidget('upcoming'),
              ),
              FeaturedActorsWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
