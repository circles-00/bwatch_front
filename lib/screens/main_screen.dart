import 'package:bwatch_front/database.dart';
import 'package:bwatch_front/providers/data_provider.dart';
import 'package:bwatch_front/screens/home_screen.dart';
import 'package:bwatch_front/screens/profile_screen.dart';
import 'package:bwatch_front/widgets/app_bars/home_screen_appbar.dart';
import 'package:bwatch_front/widgets/app_bars/profile_appbar.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  final firstName;
  final lastName;
  final email;
  final token;

  List<int> _favIds = [];
  List<int> _watchListIds = [];

  MainScreen({Key? key, this.firstName, this.lastName, this.email, this.token})
      : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Needed for BottomNavigation
  int _currentIndex = 0;
  final List<Widget> _children = [HomeScreen(), Profile()];
  @override
  void initState() {
    // Set initial state, favoritelist and watchlist
    super.initState();
    getFavoriteMoviesIds(widget.token).then((value) {
      setState(() {
        widget._favIds = value;
      });
    });
    getWatchListIds(widget.token).then((value) {
      setState(() {
        widget._watchListIds = value;
      });
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void notifyParent() {
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<DataProvider>(context, listen: false);
    globalData.setFirstName(widget.firstName);
    globalData.setLastName(widget.lastName);
    globalData.setFavoriteIDs(widget._favIds);
    globalData.setWatchListIDs(widget._watchListIds);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(kPrimaryColor),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.white,
          backgroundColor: Color(kAccentColor),
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.home_filled),
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.person),
              icon: Icon(
                Icons.person,
              ),
              label: 'Your Profile',
            )
          ],
        ),
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: _currentIndex == 0
                ? HomeScreenAppBar()
                : ProfileAppBar(
                    notifyParent: notifyParent,
                  )),
        body: _children[_currentIndex],
      ),
    );
  }
}
