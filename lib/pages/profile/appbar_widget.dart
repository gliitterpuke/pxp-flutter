import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:pxp_flutter/pages/profile/settings.dart';

import '../ig/components/app_widgets/tap_fade_icon.dart';
import '../ig/components/new_post/new_post_screen.dart';

import 'package:pxp_flutter/pages/ig/app/app.dart';
import 'package:pxp_flutter/pages/ig/components/app_widgets/app_widgets.dart';
import 'package:pxp_flutter/pages/ig/components/new_post/new_post_screen.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    // leading: const BackButton(),
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    title: Text(
      context.appState.streamagramUser!.firstName.toString(),
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8),
        child: TapFadeIcon(
          onTap: () => Navigator.of(context).push(NewPostScreen.route),
          icon: Icons.add_circle_outline,
          iconColor: Colors.white,
        ),
      ),
      IconButton(
        icon: const Icon(Feather.settings),
        iconSize: 20,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const Settings()),
          );
        },
      ),
    ],
  );
}
