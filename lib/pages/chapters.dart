// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pxp_flutter/json/book_detail_json.dart';
import 'package:pxp_flutter/pages/profile/appbar_widget.dart';
import 'package:pxp_flutter/pages/edit_profile_page.dart';

import 'package:pxp_flutter/widgets/table-cell.dart';

class Chapters extends StatefulWidget {
  @override
  _ChaptersState createState() => _ChaptersState();
}

class _ChaptersState extends State<Chapters> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
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
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 15, right: 15),
          child: ListView(
            children: List.generate(seasonsList.length, (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Chapters()));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width:
                              (MediaQuery.of(context).size.width - 30) * 0.85,
                          child: Row(
                            children: [
                              Container(
                                width:
                                    (MediaQuery.of(context).size.width) * 0.35,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Chapter " +
                                          seasonsList[index]['season']
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white.withOpacity(0.9)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width:
                              (MediaQuery.of(context).size.width - 30) * 0.15,
                          child: Center(
                            child: Icon(
                              Feather.chevron_right,
                              size: 20,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(children: <Widget>[
                      Expanded(
                        child: Divider(color: Colors.grey),
                      ),
                    ]),
                    SizedBox(height: 8),
                  ],
                ),
              );
            }),
          ),
        ));
  }
}
