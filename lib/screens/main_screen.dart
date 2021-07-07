import '../constants.dart';
import '../database.dart';
import '../widgets/featured_actors_widget.dart';
import '../widgets/main_screen_body_widget.dart';
import '../widgets/movies_widget.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(kPrimaryColor),
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Color(kPrimaryColor),
          elevation: 0,
          leading: Icon(Icons.search),
          actions: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, Nikola',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Macedonia', style: TextStyle(fontSize: 10)),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(right: 8, left: 15),
                child: Icon(
                  Icons.notifications_active_outlined,
                  size: 30,
                ))
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MSBodyText('most'),
                  MSBodyText('popular movies'),
                  Padding(
                      padding: EdgeInsets.only(left: 20, top: 10, bottom: 20),
                      child: Text(
                        'todo pop movies length',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      )),
                  Container(
                    height: 300,
                    child: MoviesWidget('popular', refresh),
                  ),
                  FeaturedActorsWidget(
                    actors: featuredActors,
                    title: 'featured actors',
                    notifyParent: refresh,
                  ),
                  MSBodyText('upcoming'),
                  MSBodyText('movies'),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 20),
                  ),
                  Container(
                    height: 300,
                    child: MoviesWidget('upcoming', refresh),
                  ),
                  FeaturedActorsWidget(
                    actors: featuredActresses,
                    title: 'featured actresses',
                    notifyParent: refresh,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  refresh() {
    setState(() {});
  }
}
