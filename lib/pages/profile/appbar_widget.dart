import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:pxp_flutter/pages/edit_profile_page.dart';
import 'package:pxp_flutter/pages/profile/settings.dart';

AppBar buildAppBar(BuildContext context) {
  final icon = Feather.settings;

  return AppBar(
    leading: BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        icon: Icon(icon),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Settings()),
          );
        },
      ),
    ],
  );
}
