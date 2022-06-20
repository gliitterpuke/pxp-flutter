import 'package:flutter/material.dart';
import 'package:pxp_flutter/json/search_json.dart';
import 'package:pxp_flutter/pages/book_detail.dart';
import 'package:pxp_flutter/constants/Theme.dart';
import 'package:pxp_flutter/pages/genre.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> _bookList = [];
  bool _emptyBooks = false;
  bool isOpen = true;
  @override
  initState() {
    _bookList = [];
    _emptyBooks = false;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    bool emptyResults = false;
    if (enteredKeyword.isEmpty) {
      results = [];
    } else {
      results = books
          .where((book) => (book["title"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              book["author"]
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              // book["genre"]
              //     .toLowerCase()
              //     .contains(enteredKeyword.toLowerCase()) ||
              book["tags"]
                  .toString()
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase())))
          .toList();
    }

    // Refresh the UI
    setState(() {
      if (enteredKeyword.isNotEmpty && results.isEmpty) {
        _emptyBooks = true;
        _bookList = results;
      } else {
        _bookList = results;
        _emptyBooks = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black, appBar: getAppBar(), body: getBody());
  }

  PreferredSizeWidget getAppBar() {
    var size = MediaQuery.of(context).size;
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
      elevation: 0,
      title: Row(
        children: [
          Container(
            width: size.width - 90,
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.withOpacity(0.25)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search title, creator or tag!",
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Text('Cancel',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey))),
        ],
      ),
    );
  }

  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
              child: _bookList.isNotEmpty
                  ? ListView.builder(
                      itemCount: _bookList.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_bookList[index]["id"]),
                        color: Colors.black,
                        elevation: 4,
                        child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const BookDetail(),
                                      settings: RouteSettings(
                                        arguments: _bookList[index],
                                      )));
                            },
                            leading: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, top: 8.0),
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image:
                                            AssetImage(_bookList[index]['img']),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            title: Text(
                              _bookList[index]['title'],
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(_bookList[index]['author'])),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          _emptyBooks == true
                              ? const Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 30, bottom: 20),
                                  child: Text(
                                    "No results found -- explore our genres!",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 30, bottom: 20),
                                  child: Text(
                                    "Explore our genres",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                          Expanded(
                            child: GridView.count(
                              childAspectRatio: 0.8,
                              crossAxisCount: 4,
                              children: List.generate(tags.length, (index) {
                                return Column(children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: const Color(0xff161618),
                                    child: IconButton(
                                      icon: Icon(
                                        tags[index]['icon'],
                                        color: pxpColors.secondaryT,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GenreDetail(),
                                                settings: RouteSettings(
                                                  arguments: {
                                                    'genre': tags[index]['tag'],
                                                    'index': tags[index]['id']
                                                  },
                                                )));
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: 80,
                                      child: Center(
                                        child: Text(
                                          tags[index]['tag'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              color: pxpColors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]);
                              }),
                            ),
                          )
                        ])),
        ],
      ),
    );
  }
}
