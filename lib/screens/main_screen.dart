import 'package:bwatch_front/database.dart';
import 'package:bwatch_front/providers/movies_provider.dart';
import 'package:bwatch_front/screens/login_screen.dart';
import 'package:bwatch_front/screens/search_screen.dart';
import 'package:bwatch_front/services/auth_service.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../widgets/featured_actors_widget.dart';
import '../widgets/main_screen_body_widget.dart';
import '../widgets/movies_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  final firstName;
  final email;
  final token;

  List<int> _favIds = [];
  List<int> _watchListIds = [];

  MainScreen({Key? key, this.firstName, this.email, this.token})
      : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    getFavoriteMovies(widget.token).then((value) {
      setState(() {
        widget._favIds = value;
      });
    });
    getWatchList(widget.token).then((value) {
      setState(() {
        widget._watchListIds = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final moviesData = Provider.of<MoviesProvider>(context, listen: false);

    moviesData.setFavoriteIDs(widget._favIds);
    moviesData.setWatchListIDs(widget._watchListIds);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Color(kPrimaryColor),
          appBar: AppBar(
            brightness: Brightness.dark,
            backgroundColor: Color(kPrimaryColor),
            elevation: 0,
            leading: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChangeNotifierProvider<MoviesProvider>.value(
                                  value: MoviesProvider(token: widget.token),
                                  child: SearchScreen())));
                },
                child: Icon(Icons.search)),
            actions: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, ' + widget.firstName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // Text('Macedonia', style: TextStyle(fontSize: 10)),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(right: 8, left: 15),
                  child: GestureDetector(
                    onTap: () async {
                      APIService auth = APIService();
                      await auth.logout();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Icon(
                      Icons.logout,
                      size: 30,
                    ),
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
                    Container(
                      constraints: BoxConstraints(maxWidth: 350),
                      child: Padding(
                          padding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 20),
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
          )),
    );
  }
}
