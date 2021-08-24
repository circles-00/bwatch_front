import 'package:bwatch_front/database.dart';
import 'package:bwatch_front/providers/data_provider.dart';
import 'package:bwatch_front/screens/home_screen.dart';
import 'package:bwatch_front/screens/profile_screen.dart';
import 'package:bwatch_front/widgets/app_bars/home_screen_appbar.dart';
import 'package:bwatch_front/widgets/app_bars/profile_appbar.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'package:flutter/material.dart';

import 'search_screen.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  final firstName;
  final lastName;
  final token;
  final id;

  List<int> _favIds = [];
  List<int> _watchListIds = [];

  MainScreen({Key? key, this.firstName, this.lastName, this.token, this.id})
      : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Needed for BottomNavigation
  int _currentIndex = 0;
  List<Widget> _children = [];
  void notifyOnLogOut() {
    setState(() {
      widget._favIds = [];
      widget._watchListIds = [];
    });
  }

  @override
  void initState() {
    // Set initial state, favoritelist and watchlist
    super.initState();
    getFavoriteMoviesIds(widget.id).then((value) {
      setState(() {
        widget._favIds = value;
      });
    });
    getWatchListIds(widget.id).then((value) {
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
    _children = [
      HomeScreen(),
      SearchScreen(),
      Profile(
        id: widget.id,
        firstName: widget.firstName,
        lastName: widget.lastName,
        favoriteIDs: widget._favIds,
        watchListIDs: widget._watchListIds,
      )
    ];
    final globalData = Provider.of<DataProvider>(context);
    globalData.setFirstName(widget.firstName);
    globalData.setLastName(widget.lastName);
    globalData.setFavoriteIDs(widget._favIds);
    globalData.setWatchListIDs(widget._watchListIds);
    globalData.setToken(widget.token);
    globalData.setId(widget.id);

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
              activeIcon: Icon(Icons.search_sharp),
              icon: Icon(
                Icons.search,
              ),
              label: 'Search',
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
              ? HomeScreenAppBar(notifyOnLogOut: notifyOnLogOut)
              : _currentIndex == 2
                  ? ProfileAppBar(
                      notifyParent: notifyParent,
                    )
                  : Text(''),
        ),
        body: _children[_currentIndex],
      ),
    );
  }
}
