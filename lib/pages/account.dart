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
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/loveiswar.jpg"),
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.2),
                                BlendMode.dstATop),
                            fit: BoxFit.cover)),
                    child: Stack(
                      children: <Widget>[
                        SafeArea(
                          bottom: false,
                          right: false,
                          left: false,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Column(
                              children: [
                                ProfileWidget(imagePath: user.imagePath),
                                buildName(user),
                                NumbersWidget()
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              buildAbout(
                user,
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      onPressed: () {},
                      child: const Text("Follow",
                          style: TextStyle(fontSize: 13.0)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {},
                      child: const Text("Subscribe",
                          style: TextStyle(fontSize: 13.0)),
                    ),
                  ),
                ],
              ),
            ),
          )
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

  Widget buildAbout(User user) => Flexible(
        flex: 1,
        child: Container(
            child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 24.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 24.0, right: 24, top: 30, bottom: 24),
              child: Text(
                user.about,
                style: const TextStyle(fontSize: 16, height: 1.4),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: TabBarDemo(),
              ),
            ),
          ]),
        )),
      );
}
