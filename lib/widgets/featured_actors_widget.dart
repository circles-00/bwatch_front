import 'package:bmusic_front/models/actor_model.dart';
import 'package:flutter/material.dart';

class FeaturedActorsWidget extends StatelessWidget {
  final String title;
  final List<Actor> actors;
  final Function() notifyParent;

  FeaturedActorsWidget(
      {required this.title, required this.actors, required this.notifyParent});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 120,
            child: ListView.builder(
              itemCount: actors.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(actors[index].image),
                          radius: 40,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          actors[index].firstName +
                              ' ' +
                              actors[index].lastName,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ));
              },
            ),
          )
        ],
      ),
    );
  }
}
