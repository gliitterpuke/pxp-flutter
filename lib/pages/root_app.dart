// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:pxp_flutter/json/root_app_json.dart';
import 'package:pxp_flutter/pages/book_detail.dart';
import 'package:pxp_flutter/pages/chat/main.dart';
import 'package:pxp_flutter/pages/feed/main.dart';
import 'package:pxp_flutter/pages/home.dart';
import 'package:pxp_flutter/pages/onboarding.dart';
import 'package:pxp_flutter/pages/search.dart';
import 'package:pxp_flutter/pages/account.dart';
import 'package:pxp_flutter/pages/library.dart';
import 'package:pxp_flutter/pages/feed/main.dart';
import 'package:pxp_flutter/constants/Theme.dart';
import 'package:stream_feed/stream_feed.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pxpColors.menu,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }

  Widget getBody() {
    final client = StreamFeedClient('rzxdu6bj5yaa');
    return IndexedStack(
      index: activeTab,
      children: [
        HomePage(),
        SearchPage(),
        LibraryPage(),
        FeedApp(
          client: client,
        ),
        ProfilePage()
      ],
    );
  }

  Widget getFooter() {
    return Container(
      height: 80,
      decoration: BoxDecoration(color: pxpColors.menu),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  activeTab = index;
                });
              },
              child: Column(
                children: [
                  Icon(
                    items[index]['icon'],
                    color: activeTab == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    items[index]['text'],
                    style: TextStyle(
                        fontSize: 10,
                        color: activeTab == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.5)),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
