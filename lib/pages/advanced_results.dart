import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:pxp_flutter/json/search_json.dart';
import 'package:pxp_flutter/pages/book_detail.dart';
import 'package:pxp_flutter/constants/Theme.dart';
import 'package:pxp_flutter/pages/genre.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:pxp_flutter/json/choices.dart' as choices;

class AdvancedResultsPage extends StatefulWidget {
  const AdvancedResultsPage({Key? key}) : super(key: key);
  @override
  _AdvancedResultsPageState createState() => _AdvancedResultsPageState();
}

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });
}

class _AdvancedResultsPageState extends State<AdvancedResultsPage> {
  List<Map<String, dynamic>> _bookList = [];
  bool _emptyBooks = false;
  bool isOpen = true;

  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  initState() {
    _bookList = [];
    _emptyBooks = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black, appBar: getAppBar(), body: getBody());
  }

  PreferredSizeWidget getAppBar() {
    var size = MediaQuery.of(context).size;
    return AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Advanced Search",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ));
  }

  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
              flex: 4,
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(_bookList[index]['author'])),
                      ),
                    )
                  : Center(
                      child: const Padding(
                        padding: EdgeInsets.only(top: 10, left: 30, bottom: 20),
                        child: Text(
                          "No results found -- please try again!",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    )),
        ],
      ),
    );
  }
}
