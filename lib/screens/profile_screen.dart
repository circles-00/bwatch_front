import 'package:bwatch_front/constants.dart';
import 'package:bwatch_front/providers/data_provider.dart';
import 'package:bwatch_front/widgets/favorites_watchlist_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<DataProvider>(context);
    return Scaffold(
      backgroundColor: Color(kPrimaryColor),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  width: 125,
                  height: 125,
                  child: Image(
                      image: AssetImage('assets/images/empty_avatar.png')),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Text(
                  globalData.getFirstName() + ' ' + globalData.getLastName(),
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.all(7),
                  child: Text('Edit Profile',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
              SizedBox(
                height: 55,
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  'Your favorite movies',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: SizedBox(
                    height: 200,
                    child: FavoritesWatchListHorizontal(
                        globalData.token, 'favorites')),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  'Your watch list',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: SizedBox(
                    height: 200,
                    child: FavoritesWatchListHorizontal(
                        globalData.token, 'watch-list')),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
