import '../models/movie_model.dart';
import 'package:flutter/material.dart';

class MoviesWidget extends StatelessWidget {
  final List<Movie> listType;
  final Function() notifyParent;

  MoviesWidget(this.listType, this.notifyParent);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listType.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.all(10),
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: AssetImage(listType[index].image), fit: BoxFit.cover)),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  listType[index].name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
