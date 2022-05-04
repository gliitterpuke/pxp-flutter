// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
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
              height: size.height, //height of TabBarView
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.grey, width: 0.5))),
              child: TabBarView(children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Text(
                        "Authored",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => BookDetail()));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: List.generate(mylist.length, (index) {
                              return Container(
                                margin: EdgeInsets.only(right: 8),
                                width: 110,
                                height: 160,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                        image: AssetImage(mylist[index]['img']),
                                        fit: BoxFit.cover)),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Text(
                        "Reading List",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => BookDetail()));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: List.generate(mylist.length, (index) {
                              return Container(
                                margin: EdgeInsets.only(right: 8),
                                width: 110,
                                height: 160,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                        image: AssetImage(mylist[index]['img']),
                                        fit: BoxFit.cover)),
                              );
                            }),
                          ),
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