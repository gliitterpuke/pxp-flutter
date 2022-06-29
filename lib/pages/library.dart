import 'package:flutter/material.dart';
import 'package:pxp_flutter/pages/book_detail.dart';
import 'package:pxp_flutter/json/library.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pxp_flutter/constants/Theme.dart';
import 'package:pxp_flutter/pages/reading_list.dart';
import 'package:pxp_flutter/pages/root_app.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

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

  late TextEditingController controller;
  String readingList = '';

  bool isNotify = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(_smoothScrollToTop);

    super.initState();
    controller = TextEditingController();
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
                child: Slidable(
                  groupTag: '0',
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: _onShare,
                        backgroundColor: Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.share,
                        label: 'Share',
                      ),
                      SlidableAction(
                        onPressed: (BuildContext context) async {
                          setState(() {
                            currentReads.remove(index);
                          });
                        },
                        // onPressed: (context) {
                        //   setState() =>
                        //       currentReads.remove(currentReads[index]);
                        // },
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Row(
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
                            ],
                          ),
                          SizedBox(
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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isNotify = !isNotify;
                          });
                        },
                        child: Container(
                            width: 35,
                            height: 35,
                            child: isNotify == true
                                ? Icon(
                                    MaterialCommunityIcons.bell_ring_outline,
                                    color: Color(0xff8f94fb),
                                    size: 20,
                                  )
                                : Icon(
                                    MaterialCommunityIcons.bell_outline,
                                    color: pxpColors.secondaryT,
                                    size: 20,
                                  )),
                      ),
                    ],
                  ),
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
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReadingListPage(),
                        settings: RouteSettings(
                          arguments: readLater[index],
                        )));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 18, bottom: 10),
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: const [
                      SlidableAction(
                        onPressed: doNothing,
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
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
                                        image: AssetImage(readLater[index]
                                            ['books'][index]['img']),
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          ),
                          SizedBox(
                            width:
                                (MediaQuery.of(context).size.width - 30) * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${readLater[index]['books'].length ?? "Empty"}' +
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
                                    readLater[index]['name'] ?? 'Empty',
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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isNotify = !isNotify;
                          });
                        },
                        child: Container(
                            width: 35,
                            height: 35,
                            child: isNotify == true
                                ? Icon(
                                    MaterialCommunityIcons.bell_ring_outline,
                                    color: Color(0xff8f94fb),
                                    size: 20,
                                  )
                                : Icon(
                                    MaterialCommunityIcons.bell_outline,
                                    color: pxpColors.secondaryT,
                                    size: 20,
                                  )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          })),
          Column(children: [
            GestureDetector(
              onTap: () async {
                final readingList = await openDialog();
                if (readingList == null || readingList.isEmpty) return;

                setState(() => this.readingList = readingList);
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
                                  color: Colors.white,
                                ),
                                child: Icon(Entypo.plus, color: Colors.grey)),
                          ],
                        ),
                        SizedBox(
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
                        ),
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
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: const [
                      SlidableAction(
                        onPressed: _onShare,
                        backgroundColor: Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.share,
                        label: 'Share',
                      ),
                      SlidableAction(
                        onPressed: doNothing,
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
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
                                              archived[index]['img']),
                                          fit: BoxFit.cover)),
                                ),
                                // Container(
                                //     height: 70,
                                //     width: 70,
                                //     decoration: BoxDecoration(
                                //         color: Colors.black.withOpacity(0.2)))
                              ],
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width - 30) *
                                  0.7,
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
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isNotify = !isNotify;
                        });
                      },
                      child: Container(
                          width: 35,
                          height: 35,
                          child: isNotify == true
                              ? Icon(
                                  MaterialCommunityIcons.bell_ring_outline,
                                  color: Color(0xff8f94fb),
                                  size: 20,
                                )
                              : Icon(
                                  MaterialCommunityIcons.bell_outline,
                                  color: pxpColors.secondaryT,
                                  size: 20,
                                )),
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
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isNotify = !isNotify;
                        });
                      },
                      child: Container(
                          width: 35,
                          height: 35,
                          child: isNotify == true
                              ? Icon(
                                  MaterialCommunityIcons.bell_ring_outline,
                                  color: Color(0xff8f94fb),
                                  size: 20,
                                )
                              : Icon(
                                  MaterialCommunityIcons.bell_outline,
                                  color: pxpColors.secondaryT,
                                  size: 20,
                                )),
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

  Future<String?> openDialog() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            titlePadding: EdgeInsets.only(top: 40),
            contentPadding: EdgeInsets.all(20),
            backgroundColor: pxpColors.lighterCard,
            title: Column(
              children: [
                Text('Create a reading list'),
                SizedBox(height: 5),
                Text('Enter your reading list name',
                    style: TextStyle(fontSize: 14))
              ],
            ),
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(hintText: 'E.g. Best books!!'),
              controller: controller,
              onSubmitted: (_) => submit(),
            ),
            actions: [
              TextButton(onPressed: cancel, child: Text('Cancel')),
              TextButton(
                  onPressed: submit,
                  child: Text('Create', style: TextStyle(color: Colors.white)))
            ],
          ));

  void submit() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReadingListPage(),
            settings: RouteSettings(
              arguments: {'newList': controller.text},
            )));
    controller.clear();
  }

  void cancel() {
    Navigator.of(context, rootNavigator: true).pop(controller.text);
    controller.clear();
  }

  deleteItem(current) async {
    setState(() {
      current.removeAt(currentReads);
    });
  }
}

void _onShare(BuildContext context) async {
  final box = context.findRenderObject() as RenderBox?;
  await Share.share('hey',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
}

void doNothing(BuildContext context) {}
