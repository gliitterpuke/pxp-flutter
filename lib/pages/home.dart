// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:pxp_flutter/json/home_json.dart';
import 'package:pxp_flutter/pages/account.dart';
import 'package:pxp_flutter/pages/book_detail.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pxp_flutter/constants/Theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pxp_flutter/pages/genre.dart';
import 'package:pxp_flutter/pages/search.dart';
import 'package:pxp_flutter/pages/user_profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(EvilIcons.search),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: pxpColors.darkCard,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  builder: (context) {
                    return FractionallySizedBox(
                        heightFactor: 0.95, child: SearchPage());
                  },
                );
              },
            ),
          ],
        ),
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: getBody());
  }

  Widget getBody() {
    final List<Widget> imageSliders = List.generate(pxppicks.length, (index) {
      return Container(
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                      image: AssetImage(pxppicks[index]['img']),
                      fit: BoxFit.cover)),
            ),
          ),
        ),
      );
    });
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: size.height - 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      "PxP Picks",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookDetail(),
                              settings: RouteSettings(
                                arguments: pxppicks[_current],
                              ))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 8, right: 8, bottom: 15),
                        child: Container(
                          child: CarouselSlider(
                            items: imageSliders,
                            carouselController: _controller,
                            options: CarouselOptions(
                                enlargeCenterPage: true,
                                aspectRatio: 1.75,
                                viewportFraction: 0.35,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.height,
                                initialPage: 0,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                }),
                          ),
                        ),
                      )),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BookDetail(),
                            settings: RouteSettings(
                              arguments: pxppicks[_current],
                            ))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                pxppicks[_current]['genre'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: pxpColors.darkTextSecondary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        backgroundColor:
                                            pxpColors.darkElevatedPrimary,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: <Widget>[
                                              SizedBox(height: 20),
                                              Center(
                                                child: Text(
                                                  'What are these icons?',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                "Each icon represents a different tier of book: whether it's free, paid, or another tier.",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                        FontAwesome.hourglass_o,
                                                        color: tierColor.paid),
                                                    Text(
                                                      ' Free: details here',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Icon(FontAwesome.dollar,
                                                        color: tierColor.paid),
                                                    Text(
                                                      ' Paid: details here',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Icon(AntDesign.star,
                                                        color:
                                                            tierColor.bronze),
                                                    Text(
                                                      ' Bronze subscription: details',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Icon(AntDesign.star,
                                                        color:
                                                            tierColor.silver),
                                                    Text(
                                                      ' Silver subscription: details',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Icon(AntDesign.star,
                                                        color: tierColor.gold),
                                                    Text(
                                                      ' Gold subscription: details',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 1),
                                      child: Icon(
                                        pxppicks[_current]['tierIcon'],
                                        color: pxppicks[_current]['tier'] == 0
                                            ? tierColor.gold
                                            : pxppicks[_current]['tier'] == 2
                                                ? tierColor.silver
                                                : pxppicks[_current]['tier'] ==
                                                        3
                                                    ? tierColor.gold
                                                    : pxppicks[_current]
                                                                ['tier'] ==
                                                            4
                                                        ? tierColor.paid
                                                        : tierColor.bronze,
                                        size: 15,
                                      ),
                                    ),
                                    Text(
                                      "??",
                                      style: TextStyle(
                                          color: pxpColors.darkTextSecondary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            pxppicks[_current]['title'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            pxppicks[_current]['description'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: pxpColors.darkTextSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "More details ??",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          "Recommended for you",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: List.generate(mylist.length, (index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookDetail(),
                                            settings: RouteSettings(
                                              arguments: mylist[index],
                                            )));
                                  },
                                  child: Column(children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      width: 115,
                                      height: 160,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  mylist[index]['img']),
                                              fit: BoxFit.cover)),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 115,
                                          child: Text(
                                            mylist[index]['genre'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                color:
                                                    pxpColors.darkTextSecondary,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 110,
                                          height: 40,
                                          child: Text(
                                            mylist[index]['title'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]));
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          "Trending",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children:
                                List.generate(trendingList.length, (index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookDetail(),
                                            settings: RouteSettings(
                                              arguments: trendingList[index],
                                            )));
                                  },
                                  child: Column(children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      width: 115,
                                      height: 160,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  trendingList[index]['img']),
                                              fit: BoxFit.cover)),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 110,
                                          child: Text(
                                            trendingList[index]['genre'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                color:
                                                    pxpColors.darkTextSecondary,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 110,
                                          height: 50,
                                          child: Text(
                                            trendingList[index]['title'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]));
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          "Trending authors",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: List.generate(authorList.length, (index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UserProfilePage(
                                              userId: authorList[index]),
                                          // settings: RouteSettings(
                                          //   arguments: mylist[index],
                                          // )
                                        ));
                                  },
                                  child: Column(children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(99),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  authorList[index]['profile']
                                                      ['pic']['url']),
                                              fit: BoxFit.cover)),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Center(
                                        child: Text(
                                          authorList[index]['profile']
                                              ['display_name'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: pxpColors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ]));
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          "New and hot",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: List.generate(newList.length, (index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookDetail(),
                                            settings: RouteSettings(
                                              arguments: newList[index],
                                            )));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 8),
                                    width: 110,
                                    height: 160,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                newList[index]['img']),
                                            fit: BoxFit.cover)),
                                  ));
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          "Completed",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children:
                                List.generate(completedList.length, (index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookDetail(),
                                            settings: RouteSettings(
                                              arguments: completedList[index],
                                            )));
                                  },
                                  child: Column(children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      width: 115,
                                      height: 160,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  completedList[index]['img']),
                                              fit: BoxFit.cover)),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 110,
                                          child: Text(
                                            completedList[index]['genre'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                color:
                                                    pxpColors.darkTextSecondary,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 110,
                                          height: 50,
                                          child: Text(
                                            completedList[index]['title'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]));
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          "Favourite genres",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: List.generate(genreList.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GenreDetail(),
                                          settings: RouteSettings(
                                            arguments: {
                                              'genre': genreList[index]
                                                  ['genre'],
                                              'index': genreList[index]['id']
                                            },
                                          )));
                                },
                                child: Column(children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xff161618),
                                    child: IconButton(
                                      icon: Icon(
                                        genreList[index]['icon'],
                                        color: pxpColors.darkTextSecondary,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GenreDetail(),
                                                settings: RouteSettings(
                                                  arguments: {
                                                    'genre': genreList[index]
                                                        ['genre'],
                                                    'index': genreList[index]
                                                        ['id']
                                                  },
                                                )));
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 80,
                                    child: Center(
                                      child: Text(
                                        genreList[index]['genre'],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: pxpColors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ]),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // Container(
            //   child: SafeArea(
            //       child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Text(
            //         "Books",
            //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            //       ),
            //       Text(
            //         "Audiobooks",
            //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            //       ),
            //       Row(
            //         children: [
            //           Text(
            //             "Categories",
            //             style: TextStyle(
            //                 fontSize: 15, fontWeight: FontWeight.w500),
            //           ),
            //           SizedBox(
            //             width: 3,
            //           ),
            //           Icon(Icons.keyboard_arrow_down)
            //         ],
            //       ),
            //       Icon(Ionicons.ios_notifications_outline)
            //     ],
            //   )),
            // ),
          ],
        ),
      ),
    );
  }
}
