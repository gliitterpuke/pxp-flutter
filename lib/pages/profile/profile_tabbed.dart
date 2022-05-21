// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pxp_flutter/json/book_detail_json.dart';
import 'package:pxp_flutter/json/home_json.dart';
import 'package:pxp_flutter/pages/book_detail.dart';

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
        length: 4,
        initialIndex: 0,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                Widget>[
          TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Books'),
              Tab(text: 'Wall'),
              Tab(text: 'Reviews'),
              Tab(text: 'Badges'),
            ],
          ),
          Container(
              height: 500, //height of TabBarView
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.grey, width: 0.5))),
              child: TabBarView(
                  physics:
                      ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                  children: <Widget>[
                    ListView(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Row(
                              children: List.generate(mylist.length, (index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => BookDetail()));
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
                                                  color: Colors.grey,
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
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Row(
                              children: List.generate(mylist.length, (index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => BookDetail()));
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
                                                  color: Colors.grey,
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
                      ],
                    ),
                    Container(
                      child: Center(
                        child: Text('Display Tab 2',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text('Display Tab 3',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text('Display Tab 4',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ]))
        ]));
  }
}
