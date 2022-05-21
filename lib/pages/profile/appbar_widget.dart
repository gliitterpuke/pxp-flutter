import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:pxp_flutter/pages/edit_profile_page.dart';
import 'package:pxp_flutter/pages/profile/settings.dart';
import 'package:pxp_flutter/pages/profile/user.dart';
import 'package:pxp_flutter/pages/profile/user_preferences.dart';

AppBar buildAppBar(BuildContext context) {
  User user = UserPreferences.myUser;

  return AppBar(
    leading: BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
      user.name,
      style: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    ),
    actions: [
      IconButton(
        icon: Icon(Feather.settings),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Settings()),
          );
        },
      ),
    ],
  );
}
