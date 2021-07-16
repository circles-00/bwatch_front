import 'package:bwatch_front/constants.dart';
import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget {
  final notifyParent;

  const ProfileAppBar({Key? key, this.notifyParent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          this.notifyParent();
        },
        icon: Icon(Icons.arrow_back),
      ),
      backgroundColor: Color(kPrimaryColor),
    );
  }
}
