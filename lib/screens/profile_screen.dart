import 'package:bwatch_front/constants.dart';
import 'package:bwatch_front/providers/data_provider.dart';
import 'package:bwatch_front/widgets/image_picker.dart';
import 'package:bwatch_front/widgets/favorites_watchlist_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? _imgUrl;
  bool _isEdit = false;

  void notifyParent() {
    setState(() {
      _getProfileImg();
      _isEdit = false;
    });
  }

  void _getProfileImg() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('profileImgUrl')) {
      _imgUrl = prefs.getString('profileImgUrl');
    }
  }

  @override
  void initState() {
    super.initState();
    _getProfileImg();
  }

  @override
  Widget build(BuildContext context) {
    // print(_imgUrl);
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
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        width: 175,
                        height: 175,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image(
                              fit: BoxFit.cover,
                              image: _imgUrl != null
                                  ? NetworkImage(_imgUrl!)
                                  : AssetImage('assets/images/empty_avatar.png')
                                      as ImageProvider),
                        ),
                      ),
                    ),
                    _isEdit
                        ? Center(
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: ((ctx) => ImagePick(
                                        notifyParent: notifyParent,
                                      )),
                                );
                              },
                              child: Container(
                                  width: 100,
                                  margin: EdgeInsets.only(top: 235),
                                  child: Center(
                                    child: Text(
                                      'Upload Image',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  )),
                            ),
                          )
                        : Text(''),
                  ],
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
              !_isEdit
                  ? Center(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(7),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isEdit = true;
                            });
                          },
                          child: Text('Edit Profile',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ),
                      ),
                    )
                  : Center(),
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
