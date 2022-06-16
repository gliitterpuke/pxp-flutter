import 'package:flutter/material.dart';
import 'package:pxp_flutter/pages/profile/appbar_widget.dart';
import 'package:pxp_flutter/pages/edit_profile_page.dart';

import 'package:pxp_flutter/widgets/table-cell.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // late bool switchValueOne;
  // late bool switchValueTwo;

  void initState() {
    // setState(() {
    //   switchValueOne = true;
    //   switchValueTwo = false;
    // });
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: buildAppBar(context),
        body: Container(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 32.0, left: 16, right: 16),
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text("Use FaceID to signin",
                //         style: TextStyle(color: Colors.white)),
                //     Switch.adaptive(
                //       value: switchValueOne,
                //       onChanged: (bool newValue) =>
                //           setState(() => switchValueOne = newValue),
                //       activeColor: Colors.white,
                //     )
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text("Auto-Lock security",
                //         style: TextStyle(color: Colors.white)),
                //     Switch.adaptive(
                //       value: switchValueTwo,
                //       onChanged: (bool newValue) =>
                //           setState(() => switchValueTwo = newValue),
                //       activeColor: Colors.white,
                //     )
                //   ],
                // ),
                // SizedBox(height: 36.0),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text("ACCOUNT",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12)),
                  ),
                ),
                TableCellSettings(
                  title: "Edit Profile",
                  onTap: () =>
                      Navigator.of(context).push(EditProfilePage.route),
                ),
                TableCellSettings(title: "Account Settings"),
                TableCellSettings(title: "Push Notifications"),
                SizedBox(
                  height: 36.0,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text("PRIVACY AND SAFETY",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12)),
                  ),
                ),
                TableCellSettings(
                    title: "Blocked Accounts",
                    onTap: () {
                      Navigator.pushNamed(context, '/pro');
                    }),
                TableCellSettings(
                    title: "Do not sell my info",
                    onTap: () {
                      Navigator.pushNamed(context, '/pro');
                    }),
                SizedBox(
                  height: 36.0,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text("PREMIUM",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12)),
                  ),
                ),
                TableCellSettings(
                    title: "Subscriptions",
                    onTap: () {
                      Navigator.pushNamed(context, '/pro');
                    }),
                SizedBox(
                  height: 36.0,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text("SOCIALS",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12)),
                  ),
                ),
                TableCellSettings(
                    title: "Linked Accounts",
                    onTap: () {
                      Navigator.pushNamed(context, '/pro');
                    }),
                TableCellSettings(
                    title: "Invite Friends",
                    onTap: () {
                      Navigator.pushNamed(context, '/pro');
                    }),
                SizedBox(
                  height: 36.0,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text("PxP",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12)),
                  ),
                ),
                TableCellSettings(
                    title: "About",
                    onTap: () {
                      Navigator.pushNamed(context, '/pro');
                    }),
                TableCellSettings(
                    title: "Help & Support",
                    onTap: () {
                      Navigator.pushNamed(context, '/pro');
                    }),
              ],
            ),
          ),
        )));
  }
}
