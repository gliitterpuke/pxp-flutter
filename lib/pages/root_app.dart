import 'package:flutter/material.dart';
import 'package:pxp_flutter/json/root_app_json.dart';
import 'package:pxp_flutter/pages/chat/main.dart';
import 'package:pxp_flutter/pages/home.dart';
import 'package:pxp_flutter/pages/ig/app/app.dart';
import 'package:pxp_flutter/pages/notifications.dart';
import 'package:pxp_flutter/pages/account.dart';
import 'package:pxp_flutter/pages/library.dart';
import 'package:pxp_flutter/constants/Theme.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final client =
        ModalRoute.of(context)!.settings.arguments as StreamChatClient;
    List<Widget> _homePages = <Widget>[
      const _KeepAlivePage(child: HomePage()),
      const _KeepAlivePage(child: LibraryPage()),
      _KeepAlivePage(child: MyApp(client: client)),
      _KeepAlivePage(child: NewProfilePage(userId: context.appState.user.id)),
      const _KeepAlivePage(child: NotificationPage()),
    ];

    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _homePages,
      ),
      bottomNavigationBar: _StreamagramBottomNavBar(
        pageController: pageController,
      ),
    );
  }
}

class _StreamagramBottomNavBar extends StatefulWidget {
  const _StreamagramBottomNavBar({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  State<_StreamagramBottomNavBar> createState() =>
      _StreamagramBottomNavBarState();
}

class _StreamagramBottomNavBarState extends State<_StreamagramBottomNavBar> {
  void _onNavigationItemTapped(int index) {
    widget.pageController.jumpToPage(index);
  }

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: pxpColors.menu),
      child: BottomNavigationBar(
        backgroundColor: Colors.black,
        onTap: _onNavigationItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        iconSize: 28,
        currentIndex: widget.pageController.page?.toInt() ?? 0,
        items: List.generate(items.length, (index) {
          return BottomNavigationBarItem(
            icon: Icon(items[index]['icon']),
            activeIcon: Icon(items[index]['icon']),
            label: items[index]['text'],
          );
        }),
      ),
    );
  }
}

class _KeepAlivePage extends StatefulWidget {
  const _KeepAlivePage({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<_KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
