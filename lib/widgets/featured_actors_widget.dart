import 'package:bwatch_front/database.dart';

import 'package:flutter/material.dart';

class FeaturedActorsWidget extends StatelessWidget {
  final Function() notifyParent;

  FeaturedActorsWidget({required this.notifyParent});

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
                'Featured actors',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 120,
            child: FutureBuilder(
              future: getActors(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return CircularProgressIndicator();
                }

                return ListView.builder(
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
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
                        ));
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
