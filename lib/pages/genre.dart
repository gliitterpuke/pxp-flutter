import 'package:flutter/material.dart';
import 'package:pxp_flutter/json/genre_list.dart';
import 'package:pxp_flutter/pages/book_detail.dart';
import 'package:pxp_flutter/constants/Theme.dart';

class GenreDetail extends StatefulWidget {
  const GenreDetail({Key? key}) : super(key: key);

  @override
  _GenreDetailState createState() => _GenreDetailState();
}

class _GenreDetailState extends State<GenreDetail>
    with SingleTickerProviderStateMixin {
  final bodyGlobalKey = GlobalKey();
  final List<Widget> myTabs = List.generate(genreList.length, (index) {
    return Tab(text: genreList[index]['genre'].toString().toUpperCase());
  });

  final List myTabsName = List.generate(genreList.length, (index) {
    return genreList[index]['genre'];
  });

  late TabController _tabController;
  late ScrollController _scrollController;
  late bool fixedScroll;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _tabController = TabController(
      length: 16,
      vsync: this,
    );
    _tabController.addListener(_smoothScrollToTop);

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final genreDetails = ModalRoute.of(context)?.settings.arguments as Map;
      var genreIndex = genreDetails['index'] ?? 0;
      _tabController.animateTo(
        genreIndex,
        duration: Duration(microseconds: 0),
      );
    });
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

  // genres tab

  _genre(i) => ListView(
        children: [
          Column(
              children: List.generate(i.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookDetail(),
                        settings: RouteSettings(
                          arguments: i[index],
                        )));
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
                                        image: AssetImage(i[index]['img']),
                                        fit: BoxFit.cover)),
                              ),
                              // Container(
                              //     height: 70,
                              //     width: 70,
                              //     decoration: BoxDecoration(
                              //         color: Colors.black.withOpacity(0.2)))
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
                                    i[index]['title'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    child: Center(
                                      child: Text(
                                        i[index]['description'],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: pxpColors.secondaryT,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
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

  @override
  Widget build(BuildContext context) {
    var genreFilter = bookList
        .where((f) => f['genre'].contains(myTabsName[_tabController.index]))
        .toList(); //
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
              _genre(genreFilter),
              _genre(genreFilter),
              _genre(genreFilter),
              _genre(genreFilter),
              _genre(genreFilter),
              _genre(genreFilter),
              _genre(genreFilter),
              _genre(genreFilter),
              _genre(genreFilter),
              _genre(genreFilter),
              _genre(genreFilter),
              _genre(genreFilter),
              _genre(genreFilter),
              _genre(genreFilter),
              _genre(genreFilter),
              _genre(genreFilter),
            ],
          ),
        ),
      ),
    );
  }
}
