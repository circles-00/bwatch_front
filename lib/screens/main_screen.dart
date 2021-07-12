import 'package:bwatch_front/screens/login_screen.dart';
import 'package:bwatch_front/services/auth_service.dart';

import '../constants.dart';
import '../widgets/featured_actors_widget.dart';
import '../widgets/main_screen_body_widget.dart';
import '../widgets/movies_widget.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final firstName;
  final token;

  const MainScreen({Key? key, this.firstName, this.token}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => LoginScreen()));
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
                    Padding(
                        padding: EdgeInsets.only(left: 20, top: 10, bottom: 20),
                        child: Text(
                          'Browse the most popular movies and save your favorites to a list',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        )),
                    Container(
                      height: 300,
                      child: MoviesWidget('popular', refresh),
                    ),
                    MSBodyText('upcoming'),
                    MSBodyText('movies'),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10, bottom: 20),
                      child: Text(
                        'Browse the upcoming movies and save your favorites to a list',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Container(
                      height: 300,
                      child: MoviesWidget('upcoming', refresh),
                    ),
                    FeaturedActorsWidget(notifyParent: refresh),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  refresh() {
    setState(() {});
  }
}
