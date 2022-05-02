import 'package:flutter/material.dart';
import 'package:pxp_flutter/pages/profile/user.dart';
import 'package:pxp_flutter/pages/edit_profile_page.dart';
import 'package:pxp_flutter/pages/profile/user_preferences.dart';
import 'package:pxp_flutter/pages/profile/appbar_widget.dart';
import 'package:pxp_flutter/pages/profile/button_widget.dart';
import 'package:pxp_flutter/pages/profile/numbers_widget.dart';
import 'package:pxp_flutter/pages/profile/profile_widget.dart';
import 'package:pxp_flutter/pages/profile/profile_tabbed.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    const user = UserPreferences.myUser;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: buildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 6),
          Center(child: followButton()),
          const SizedBox(height: 12),
          NumbersWidget(),
          const SizedBox(height: 12),
          buildAbout(user),
          const SizedBox(height: 12),
          const TabBarDemo()
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.handle,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget followButton() => ButtonWidget(
        text: 'Follow',
        onClicked: () {},
      );

  Widget buildAbout(User user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                user.about,
                style: const TextStyle(fontSize: 16, height: 1.4),
              ),
            ),
          ],
        ),
      );
}
