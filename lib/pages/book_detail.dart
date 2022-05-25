// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:pxp_flutter/json/book_detail_json.dart';
import 'package:pxp_flutter/json/home_json.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:pxp_flutter/pages/book/add_review.dart';
import 'package:pxp_flutter/pages/book/all_review.dart';
import 'package:pxp_flutter/pages/book/chapters.dart';
import 'package:pxp_flutter/constants/Theme.dart';
import 'package:pxp_flutter/pages/book/review.dart';
import 'package:pxp_flutter/pages/book/summary.dart';

class BookDetail extends StatefulWidget {
  const BookDetail({Key? key}) : super(key: key);
  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < 0
        ? 0
        : _scrollPosition < screenSize.height * 0.40
            ? _scrollPosition / (screenSize.height * 0.4)
            : 1;
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      appBar: getAppBar(),
      body: getBody(_opacity),
    );
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
      actions: [
        IconButton(
            icon: Icon(
              Feather.bookmark,
              size: 28,
            ),
            onPressed: () {}),
      ],
    );
  }

  Widget getBody(opacity) {
    var value = "Pachinko";
    var size = MediaQuery.of(context).size;
    int _page = 0;
    final int _perPage = 5;
    final dataToShow =
        reviewList.sublist((_page * _perPage), ((_page * _perPage) + _perPage));
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth,
                image: AssetImage("assets/images/pachinko.jpg"),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black,
                    Colors.black
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, 0, 0.7, 1],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                color: Colors.black.withOpacity(this._opacity),
                height: size.height - 243,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 300,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.white.withOpacity(0.2)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 6, right: 6, top: 4, bottom: 4),
                            child: Text(
                              "Completed",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Kill the Villainess",
                          style: TextStyle(
                              height: 1.4,
                              fontSize: 28,
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Haegi, Your April >",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "134.5k views",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "•",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Romantic Fantasy",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Erin Miserian just wants to die. Being overworked and underappreciated in the real world wasn't great, but living as a villainess in a romance novel is even worse. If Eris can die in the novel, she might be able to return to reality, but the novel won't let her. Desperate to escape a life as the protagonist's tormentor, she sets off on a journey with the help of a witch, a knight, and a high priest. Can she find her way back to her friends and family, or is Eris doomed to a fictional future?",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(_summaryRoute());
                              },
                              child: Text(
                                "Read More",
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => BookDetail()));
                            },
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.white.withOpacity(0.2)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6, right: 6, top: 4, bottom: 4),
                                    child: Text(
                                      "Billionaire",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.white.withOpacity(0.2)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6, right: 6, top: 4, bottom: 4),
                                    child: Text(
                                      "Depression & Anxiety",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.white.withOpacity(0.2)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6, right: 6, top: 4, bottom: 4),
                                    child: Text(
                                      "Dark",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.white.withOpacity(0.2)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6, right: 6, top: 4, bottom: 4),
                                    child: Text(
                                      "Love Triangle",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.white.withOpacity(0.2)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6, right: 6, top: 4, bottom: 4),
                                    child: Text(
                                      "Reverse Harem",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "More Like This",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => BookDetail()));
                            },
                            child: Row(
                              children: List.generate(mylist.length, (index) {
                                return Container(
                                  margin: EdgeInsets.only(right: 16),
                                  width: 110,
                                  height: 160,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      image: DecorationImage(
                                          image:
                                              AssetImage(mylist[index]['img']),
                                          fit: BoxFit.cover)),
                                );
                              }),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        Container(
                          height: 450,
                          child: DefaultTabController(
                              length: 2,
                              initialIndex: 0,
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    TabBar(
                                      labelColor: Colors.white,
                                      labelStyle: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
                                      unselectedLabelStyle: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
                                      unselectedLabelColor: Colors.grey,
                                      tabs: [
                                        Tab(text: 'CHAPTERS'),
                                        Tab(text: 'REVIEWS'),
                                      ],
                                    ),
                                    Container(
                                        height: 402,
                                        //height of TabBarView
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.5))),
                                        child: TabBarView(
                                            physics: ScrollPhysics(
                                                parent:
                                                    NeverScrollableScrollPhysics()),
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 30.0),
                                                child: ListView(
                                                  children: List.generate(
                                                      seasonsList.length,
                                                      (index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (_) =>
                                                                    Chapters()));
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 20),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width: (size.width -
                                                                          30) *
                                                                      0.85,
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        width: (size.width) *
                                                                            0.35,
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              "Season " + seasonsList[index]['season'].toString(),
                                                                              style: TextStyle(fontSize: 16, height: 1.3, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.9)),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: (size.width -
                                                                          30) *
                                                                      0.15,
                                                                  child: Center(
                                                                    child: Icon(
                                                                      Feather
                                                                          .chevron_right,
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.7),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 2,
                                                            ),
                                                            Text(
                                                              "Last updated " +
                                                                  seasonsList[
                                                                          index]
                                                                      [
                                                                      'lastupdated'] +
                                                                  " ago",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.5)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 20),
                                                child: ListView(
                                                  children: [
                                                    Column(
                                                      children: List.generate(
                                                          dataToShow.length,
                                                          (index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ReviewPage(
                                                                        reviewObj:
                                                                            dataToShow[index]),
                                                              ),
                                                            );
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 10),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          60,
                                                                      width: 60,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              99),
                                                                          image: DecorationImage(
                                                                              image: AssetImage(dataToShow[index]['img']),
                                                                              fit: BoxFit.cover)),
                                                                    ),
                                                                    Container(
                                                                      width: (MediaQuery.of(context).size.width -
                                                                              30) *
                                                                          0.6,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 15.0),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Text(
                                                                                  dataToShow[index]['title'],
                                                                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                                                ),
                                                                                Text(
                                                                                  " by " + dataToShow[index]['display'],
                                                                                  style: const TextStyle(color: pxpColors.secondaryT, fontSize: 12, fontWeight: FontWeight.w500),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            Row(children: _ratingCount(dataToShow[index]['overall'])),
                                                                            const SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            Text(
                                                                              dataToShow[index]['date'] + " at Chapter " + dataToShow[index]['location'].toString(),
                                                                              style: const TextStyle(color: pxpColors.secondaryT, fontSize: 12, fontWeight: FontWeight.w500),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                  dataToShow[
                                                                          index]
                                                                      [
                                                                      'review'],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 3,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                SizedBox(
                                                                    height: 5),
                                                                Text(
                                                                    "Read more",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .pink,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            14)),
                                                                SizedBox(
                                                                    height: 5),
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Feather
                                                                          .thumbs_up,
                                                                      size: 20,
                                                                      color: pxpColors
                                                                          .secondaryT,
                                                                    ),
                                                                    SizedBox(
                                                                        width:
                                                                            5),
                                                                    Text(
                                                                      dataToShow[index]
                                                                              [
                                                                              'helpful']
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          color: pxpColors
                                                                              .secondaryT,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    if (dataToShow[index]
                                                                            [
                                                                            'award'] ==
                                                                        true)
                                                                      Spacer(),
                                                                    if (dataToShow[index]
                                                                            [
                                                                            'award'] ==
                                                                        true)
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(right: 10),
                                                                        child:
                                                                            Icon(
                                                                          FontAwesome
                                                                              .diamond,
                                                                          size:
                                                                              20,
                                                                          color:
                                                                              pxpColors.secondaryT,
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    height: 10)
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height: 40,
                                                          child: OutlinedButton(
                                                            style:
                                                                OutlinedButton
                                                                    .styleFrom(
                                                              primary:
                                                                  Colors.white,
                                                              side: BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          193,
                                                                          193,
                                                                          193)),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      AddReview(
                                                                          value:
                                                                              value),
                                                                ),
                                                              );
                                                            },
                                                            child: const Text(
                                                                "Add a review",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white)),
                                                          ),
                                                        ),
                                                        SizedBox(height: 15),
                                                        SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height: 40,
                                                          child: OutlinedButton(
                                                            style:
                                                                OutlinedButton
                                                                    .styleFrom(
                                                              primary:
                                                                  Colors.white,
                                                              side: BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          193,
                                                                          193,
                                                                          193)),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          AllReview(),
                                                                ),
                                                              );
                                                            },
                                                            child: const Text(
                                                                "Read more reviews",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white)),
                                                          ),
                                                        ),
                                                        SizedBox(height: 60)
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ]))
                                  ])),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 140,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0))),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: Container(
                        width: 300,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white),
                        child: GestureDetector(
                          onTap: () async {
                            EpubViewer.setConfig(
                              identifier: 'iosBook',
                              themeColor: Theme.of(context).primaryColor,
                              scrollDirection: EpubScrollDirection.VERTICAL,
                              enableTts: true,
                              allowSharing: true,
                            );
                            await EpubViewer.openAsset(
                              "assets/epub/3.epub",
                              lastLocation: EpubLocator.fromJson({
                                "bookId": "2239",
                                "href": "/OEBPS/ch06.xhtml",
                                "created": 1539934158390,
                                "locations": {
                                  "cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"
                                }
                              }),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.play_arrow,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Start Reading",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Route _summaryRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SummaryPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

List<Icon> _ratingCount(int count) {
  return List.generate(
          count, (i) => Icon(AntDesign.star, size: 10, color: tierColor.bronze))
      .toList(); // replace * with your rupee or use Icon instead
}
