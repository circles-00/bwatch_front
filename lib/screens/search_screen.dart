import 'package:bwatch_front/constants.dart';
import 'package:bwatch_front/database.dart';
import 'package:bwatch_front/providers/data_provider.dart';
import 'package:bwatch_front/routes/profile_route.dart';
import 'package:bwatch_front/routes/single_movie_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchInputController = TextEditingController();

  FutureBuilder searchResults() {
    final globalData = Provider.of<DataProvider>(context, listen: false);
    return FutureBuilder(
        future: _currentIndex == 0
            ? searchMovie(_searchInputController.text.toString().trim())
            : searchUser(_searchInputController.text.toString().trim()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(
                child: Text(
              'Start typing...',
              style: TextStyle(color: Colors.white),
            ));
          }

          if (_currentIndex == 0) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    singleMovieRoute(context, snapshot, globalData, index);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(kAccentColor),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          snapshot.data[index].image),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                              ),
                              Text(
                                snapshot.data[index].rating,
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            constraints: BoxConstraints(maxWidth: 150),
                            child: Text(
                              snapshot.data[index].title,
                              style: TextStyle(color: Colors.white),
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    profileRoute(context, snapshot, globalData, index);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(kAccentColor),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: snapshot.data[index].avatar !=
                                              'init' ||
                                          snapshot.data[index].avatar == null
                                      ? NetworkImage(
                                          'https://bwatch.herokuapp.com/' +
                                              snapshot.data[index].avatar)
                                      : AssetImage(
                                              'assets/images/empty_avatar.png')
                                          as ImageProvider,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            constraints: BoxConstraints(maxWidth: 150),
                            child: Text(
                              snapshot.data[index].firstName +
                                  " " +
                                  snapshot.data[index].lastName,
                              style: TextStyle(color: Colors.white),
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        });
  }

  int _currentIndex = 0;

  @override
  void dispose() {
    _searchInputController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _searchInputController.addListener(searchResults);
    super.initState();
  }

  void onTabTapped(int index) {
    setState(() {
      _searchInputController.clear();
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(kPrimaryColor),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: AppBar(
            backgroundColor: Color(kPrimaryColor),
            title: Container(
              margin: EdgeInsets.only(top: 30),
              child: TextField(
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(kAccentColor))),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintText: _currentIndex == 0
                        ? 'Search movie...'
                        : 'Search user...',
                    hintStyle: TextStyle(color: Colors.white)),
                style: TextStyle(color: Colors.white),
                controller: _searchInputController,
                autofocus: true,
                expands: false,
                onChanged: (text) {
                  setState(() {});
                },
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            BottomNavigationBar(
              onTap: onTabTapped,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.white,
              backgroundColor: Color(kAccentColor),
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.movie),
                  icon: Icon(
                    Icons.movie_outlined,
                  ),
                  label: 'Movies',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.person),
                  icon: Icon(
                    Icons.person,
                  ),
                  label: 'Users',
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: SizedBox(
              child: searchResults(),
              height: 500,
            )),
          ],
        ));
  }
}
