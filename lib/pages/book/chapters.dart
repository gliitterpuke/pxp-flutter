// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pxp_flutter/json/book_detail_json.dart';

class Chapters extends StatefulWidget {
  const Chapters({Key? key}) : super(key: key);

  @override
  _ChaptersState createState() => _ChaptersState();
}

class _ChaptersState extends State<Chapters> {
  bool isBookmarked = true;

  @override
  Widget build(BuildContext context) {
    final book = ModalRoute.of(context)!.settings.arguments as Map;

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
                icon: isBookmarked == true
                    ? Icon(MaterialIcons.bookmark)
                    : Icon(
                        MaterialIcons.bookmark_border,
                      ),
                onPressed: () {
                  setState(() {
                    isBookmarked = !isBookmarked;
                  });
                }),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 15, right: 15),
          child: ListView(
            children: List.generate(chapterList.length, (index) {
              return GestureDetector(
                onTap: () async {
                  EpubViewer.setConfig(
                    identifier: 'iosBook',
                    themeColor: Theme.of(context).primaryColor,
                    scrollDirection: EpubScrollDirection.VERTICAL,
                    enableTts: true,
                    allowSharing: true,
                  );
                  await EpubViewer.openAsset(
                    book['epub'],
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Chapter " +
                                    chapterList[index]['chapter'].toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.9)),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              chapterList[index]['lastupdated'].length > 6
                                  ? Text(
                                      "Last updated " +
                                          chapterList[index]['lastupdated'],
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white.withOpacity(0.5)),
                                    )
                                  : Text(
                                      "Last updated " +
                                          chapterList[index]['lastupdated'] +
                                          " ago",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white.withOpacity(0.5)),
                                    ),
                            ],
                          ),
                        ),
                        if (chapterList[index]['coins'] > 0)
                          Row(
                            children: [
                              Icon(
                                MaterialCommunityIcons.cash,
                                color: Colors.pink,
                              ),
                              SizedBox(width: 5),
                              Text(chapterList[index]['coins'].toString(),
                                  style: TextStyle(
                                    color: Colors.pink,
                                  ))
                            ],
                          ),
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
