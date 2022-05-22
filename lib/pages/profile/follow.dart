import 'package:flutter/material.dart';
import 'package:pxp_flutter/json/follow_json.dart';
import 'package:pxp_flutter/pages/book_detail.dart';
import 'package:pxp_flutter/json/library.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pxp_flutter/constants/Theme.dart';
import 'package:pxp_flutter/pages/root_app.dart';

class FollowPage extends StatefulWidget {
  FollowPage({Key? key, required this.page}) : super(key: key);

  final int page;

  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage>
    with SingleTickerProviderStateMixin {
  final bodyGlobalKey = GlobalKey();

  final List<Widget> myTabs = [
    const Tab(text: 'FOLLOWERS'),
    const Tab(text: 'FOLLOWING'),
  ];
  late TabController _tabController;
  late ScrollController _scrollController;
  late bool fixedScroll;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: widget.page);
    _tabController.addListener(_smoothScrollToTop);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    if (fixedScroll) {
      _scrollController.jumpTo(0);
    }
  }

  _smoothScrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(microseconds: 300),
      curve: Curves.ease,
    );

    setState(() {
      fixedScroll = _tabController.index == 2;
    });
  }

// currently reading tab

  _usersFollowing() => ListView(
        children: [
          Column(
              children: List.generate(followersList.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const BookDetail()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 18, bottom: 10),
                child: Row(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(99),
                                image: DecorationImage(
                                    image:
                                        AssetImage(followersList[index]['img']),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 30) * 0.6,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    followersList[index]['display'],
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    followersList[index]['user'],
                                    style: const TextStyle(
                                        color: pxpColors.secondaryT,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      height: 30,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        onPressed: () {},
                        child: const Text("Remove",
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }))
        ],
      );

// reading list tab

  _usersFollowed() => ListView(
        children: [
          Column(
              children: List.generate(followingList.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const BookDetail()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 18, bottom: 10),
                child: Row(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(99),
                                image: DecorationImage(
                                    image:
                                        AssetImage(followingList[index]['img']),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 30) * 0.6,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    followingList[index]['display'],
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    followingList[index]['user'],
                                    style: const TextStyle(
                                        color: pxpColors.secondaryT,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    followingList[index]['followed'] == 0
                        ? Container(
                            width: 35,
                            height: 35,
                            child: const Icon(
                              Feather.user_check,
                              color: Colors.white,
                            ),
                          )
                        : Container(
                            width: 35,
                            height: 35,
                            child: const Icon(
                              Feather.user_plus,
                              color: pxpColors.secondaryT,
                            ),
                          ),
                    const SizedBox(width: 5),
                    Container(
                      width: 35,
                      height: 35,
                      child: const Icon(
                        Entypo.dots_three_horizontal,
                        color: pxpColors.secondaryT,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }))
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pxpColors.bgColorScreen,
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              backgroundColor: Colors.black,
              pinned: true,
              forceElevated: true,
              title: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                labelStyle: const TextStyle(
                    fontSize: 12.0, fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(
                    fontSize: 12.0, fontWeight: FontWeight.bold),
                indicatorColor: Colors.grey,
                isScrollable: true,
                tabs: myTabs,
              ),
            ),
          ];
        },
        body: Container(
          child: TabBarView(
            controller: _tabController,
            children: [
              _usersFollowing(),
              _usersFollowed(),
            ],
          ),
        ),
      ),
    );
  }
}
