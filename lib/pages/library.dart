import 'package:flutter/material.dart';
import 'package:pxp_flutter/pages/book_detail.dart';
import 'package:pxp_flutter/json/library.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pxp_flutter/constants/Theme.dart';
import 'package:pxp_flutter/pages/home.dart';
import 'package:pxp_flutter/pages/root_app.dart';
// import 'package:pxp_flutter/pages/register.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  final bodyGlobalKey = GlobalKey();
  final List<Widget> myTabs = [
    Tab(text: 'CURRENT READS'),
    Tab(text: 'READ LATER'),
    Tab(text: 'ARCHIVED'),
    Tab(text: 'FOLLOWED'),
    Tab(text: 'SUBBED'),
  ];
  late TabController _tabController;
  late ScrollController _scrollController;
  late bool fixedScroll;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _tabController = TabController(length: 5, vsync: this);
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
      duration: Duration(microseconds: 300),
      curve: Curves.ease,
    );

    setState(() {
      fixedScroll = _tabController.index == 2;
    });
  }

// currently reading tab

  _currentlyReading() => ListView(
        children: [
          Column(
              children: List.generate(currentReads.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => BookDetail()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 18, bottom: 10),
                child: Row(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            currentReads[index]['img']),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.2)))
                            ],
                          ),
                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 30) * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Chapter " + currentReads[index]['chapter'],
                                    style: TextStyle(
                                      color: pxpColors.secondaryT,
                                      fontSize: 11,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    currentReads[index]['title'],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: LinearProgressIndicator(
                                        value: currentReads[index]['value']),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      child: Icon(
                        EvilIcons.bell,
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

  _noCurrentlyReading() => Padding(
      padding: const EdgeInsets.only(left: 45, right: 45),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Choose from thousands of stories to begin reading!",
              textAlign: TextAlign.center,
              style: TextStyle(color: pxpColors.secondaryT, fontSize: 14),
            ),
            SizedBox(height: 30),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                side: BorderSide(color: Color.fromARGB(255, 193, 193, 193)),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RootApp()));
              },
              child: const Text("Get started",
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1)),
            ),
          ]));

// reading list tab

  _readingList() => ListView(
        children: [
          Column(
              children: List.generate(readLater.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => BookDetail()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 18, bottom: 10),
                child: Row(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 110,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: AssetImage(readLater[index]
                                            ['books']['img'][0]),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                  height: 110,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.2)))
                            ],
                          ),
                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 30) * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  new Text(
                                    '${readLater[index]['books']['title'].length ?? "Empty"}' +
                                        ' titles',
                                    style: TextStyle(
                                      color: pxpColors.secondaryT,
                                      fontSize: 11,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${readLater[index]['name'] ?? "Empty"}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      child: Icon(
                        EvilIcons.bell,
                        color: pxpColors.secondaryT,
                      ),
                    ),
                  ],
                ),
              ),
            );
          })),
          Column(children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => BookDetail()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 18, bottom: 10),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 110,
                              width: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/kaguya.jpeg'),
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                                height: 110,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2)))
                          ],
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width - 30) * 0.7,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Create a new reading list',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ])
        ],
      );

  // archived tab

  _archived() => ListView(
        children: [
          Column(
              children: List.generate(archived.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => BookDetail()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 18, bottom: 10),
                child: Row(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image:
                                            AssetImage(archived[index]['img']),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.2)))
                            ],
                          ),
                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 30) * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    archived[index]['author'],
                                    style: TextStyle(
                                      color: pxpColors.secondaryT,
                                      fontSize: 11,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    archived[index]['title'],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }))
        ],
      );

  _noArchived() => Padding(
      padding: const EdgeInsets.only(left: 45, right: 45),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Archive your finished stroies and retrieve them whenever you want to.",
              textAlign: TextAlign.center,
              style: TextStyle(color: pxpColors.secondaryT, fontSize: 14),
            ),
          ]));

  // followed tab

  _followed() => ListView(
        children: [
          Column(
              children: List.generate(creatorsFollowed.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => BookDetail()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 18, bottom: 10),
                child: Row(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(99),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            creatorsFollowed[index]['img']),
                                        fit: BoxFit.cover)),
                              ),
                              // Container(
                              //     height: 60,
                              //     width: 60,
                              //     decoration: BoxDecoration(
                              //         color: Colors.black.withOpacity(0.2)))
                            ],
                          ),
                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 30) * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    creatorsFollowed[index]['author'],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(children: [
                                    Text(
                                      creatorsFollowed[index]['series'] +
                                          " series",
                                      style: TextStyle(
                                        color: pxpColors.secondaryT,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      creatorsFollowed[index]['followers'] +
                                          " followers",
                                      style: TextStyle(
                                        color: pxpColors.secondaryT,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ])
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      child: Icon(
                        EvilIcons.bell,
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

  _noFollowed() => Padding(
      padding: const EdgeInsets.only(left: 45, right: 45),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Find your new favourite author today!",
              textAlign: TextAlign.center,
              style: TextStyle(color: pxpColors.secondaryT, fontSize: 14),
            ),
            SizedBox(height: 30),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                side: BorderSide(color: Color.fromARGB(255, 193, 193, 193)),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RootApp()));
              },
              child: const Text("Discover",
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1)),
            ),
          ]));

  // subbed tab

  _subbed() => ListView(
        children: [
          Column(
              children: List.generate(creatorsSubbed.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => BookDetail()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 18, bottom: 10),
                child: Row(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(99),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            creatorsSubbed[index]['img']),
                                        fit: BoxFit.cover)),
                              ),
                              // Container(
                              //     height: 60,
                              //     width: 60,
                              //     decoration: BoxDecoration(
                              //         color: Colors.black.withOpacity(0.2)))
                            ],
                          ),
                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 30) * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    creatorsSubbed[index]['author'],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(children: [
                                    Text(
                                      creatorsSubbed[index]['series'] +
                                          " series",
                                      style: TextStyle(
                                        color: pxpColors.secondaryT,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      creatorsSubbed[index]['followers'] +
                                          " followers",
                                      style: TextStyle(
                                        color: pxpColors.secondaryT,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ])
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      child: Icon(
                        EvilIcons.bell,
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

  _noSubbed() => Padding(
      padding: const EdgeInsets.only(left: 45, right: 45),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Unlock stories beyond your imagination!",
              textAlign: TextAlign.center,
              style: TextStyle(color: pxpColors.secondaryT, fontSize: 14),
            ),
            SizedBox(height: 30),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                side: BorderSide(color: Color.fromARGB(255, 193, 193, 193)),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RootApp()));
              },
              child: const Text("Get started",
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1)),
            ),
          ]));

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
              automaticallyImplyLeading: false,
              pinned: true,
              forceElevated: true,
              bottom: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                labelStyle:
                    TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                unselectedLabelStyle:
                    TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
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
              currentReads.isEmpty
                  ? _noCurrentlyReading()
                  : _currentlyReading(),
              _readingList(),
              archived.isEmpty ? _noArchived() : _archived(),
              _followed(),
              _subbed()
            ],
          ),
        ),
      ),
    );
  }
}
