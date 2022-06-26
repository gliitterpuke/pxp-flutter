import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:pxp_flutter/json/search_json.dart';
import 'package:pxp_flutter/pages/advanced_results.dart';
import 'package:pxp_flutter/pages/book_detail.dart';
import 'package:pxp_flutter/constants/Theme.dart';
import 'package:pxp_flutter/pages/genre.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:pxp_flutter/json/choices.dart' as choices;

class AdvancedSearchPage extends StatefulWidget {
  const AdvancedSearchPage({Key? key}) : super(key: key);
  @override
  _AdvancedSearchPageState createState() => _AdvancedSearchPageState();
}

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });
}

class _AdvancedSearchPageState extends State<AdvancedSearchPage> {
  List<Map<String, dynamic>> _bookList = [];
  bool _emptyBooks = false;
  bool isOpen = true;

  static final List<Category> _genre = [
    Category(id: 1, name: "PxP Picks"),
    Category(id: 2, name: "Action"),
    Category(id: 3, name: "Adventure"),
    Category(id: 4, name: "Fantasy"),
    Category(id: 5, name: "Romance"),
    Category(id: 6, name: "Science Fiction"),
  ];
  final _genreItems =
      _genre.map((g) => MultiSelectItem<Category>(g, g.name)).toList();
  List<Category> _selectedGenre = [];

  static final List<Category> _tags = [
    Category(id: 1, name: "Women's"),
    Category(id: 2, name: "Young Adult"),
    Category(id: 3, name: "Tag 3"),
    Category(id: 4, name: "Japan"),
    Category(id: 5, name: "Tag 5"),
  ];
  final _tagItems =
      _tags.map((t) => MultiSelectItem<Category>(t, t.name)).toList();
  List<Category> _selectedTag = [];

  static final List<Category> _author = [
    Category(id: 1, name: "Author 1"),
    Category(id: 2, name: "Author 2"),
    Category(id: 3, name: "Author 3"),
    Category(id: 4, name: "Author 4"),
    Category(id: 5, name: "Author 5"),
  ];
  final _authorItems =
      _author.map((a) => MultiSelectItem<Category>(a, a.name)).toList();
  List<Category> _selectedAuthor = [];

  static final List<Category> _status = [
    Category(id: 1, name: "Completed"),
    Category(id: 2, name: "Ongoing"),
  ];
  final _statusItems =
      _status.map((s) => MultiSelectItem<Category>(s, s.name)).toList();
  List<Category> _selectedStatus = [];

  static final List<Category> _content = [
    Category(id: 1, name: "Profanity"),
    Category(id: 2, name: "Sexual Content"),
  ];
  final _contentItems =
      _content.map((t) => MultiSelectItem<Category>(t, t.name)).toList();
  List<Category> _selectedContent = [];

  static final List<Category> _contentOut = [
    Category(id: 1, name: "Profanity"),
    Category(id: 2, name: "Sexual Content"),
  ];
  final _contentOutItems =
      _contentOut.map((t) => MultiSelectItem<Category>(t, t.name)).toList();
  List<Category> _selectedContentOut = [];

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
                  : SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // _emptyBooks == true
                            //     ? const Padding(
                            //         padding: EdgeInsets.only(
                            //             top: 10, left: 30, bottom: 20),
                            //         child: Text(
                            //           "No results found -- explore our genres!",
                            //           style: TextStyle(
                            //               fontSize: 16,
                            //               fontWeight: FontWeight.w600),
                            //         ),
                            //       )
                            //     : const Padding(
                            //         padding: EdgeInsets.only(
                            //             top: 10, left: 30, bottom: 20),
                            //         child: Text(
                            //           "Explore our genres",
                            //           style: TextStyle(
                            //               fontSize: 18,
                            //               fontWeight: FontWeight.w600),
                            //         ),
                            //       ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: const Text('Keywords',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Search for title or description',
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: <Widget>[
                                MultiSelectDialogField(
                                  items: _authorItems,
                                  title: const Text("Authors"),
                                  searchable: true,
                                  buttonIcon: const Icon(
                                    Feather.user,
                                  ),
                                  buttonText: const Text("Authors",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  itemsTextStyle:
                                      const TextStyle(color: Colors.white),
                                  selectedItemsTextStyle:
                                      const TextStyle(color: Colors.white),
                                  unselectedColor: Colors.white,
                                  backgroundColor: pxpColors.darkCard,
                                  separateSelectedItems: true,
                                  onConfirm: (values) {
                                    _selectedAuthor = values.cast();
                                  },
                                  chipDisplay: MultiSelectChipDisplay(
                                      onTap: (value) {
                                        setState(() {
                                          _selectedAuthor.remove(value);
                                        });
                                      },
                                      chipColor: Theme.of(context).primaryColor,
                                      textStyle:
                                          const TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                            // genres
                            Column(
                              children: <Widget>[
                                MultiSelectDialogField(
                                  items: _genreItems,
                                  title: const Text("Genres"),
                                  listType: MultiSelectListType.CHIP,
                                  searchable: true,
                                  buttonIcon: const Icon(
                                    MaterialCommunityIcons.sword,
                                  ),
                                  buttonText: const Text(
                                    "Genres",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  selectedColor: Colors.grey,
                                  selectedItemsTextStyle:
                                      const TextStyle(color: Colors.white),
                                  unselectedColor: pxpColors.lighterCard,
                                  backgroundColor: pxpColors.darkCard,
                                  separateSelectedItems: true,
                                  onConfirm: (values) {
                                    _selectedGenre = values.cast();
                                  },
                                  chipDisplay: MultiSelectChipDisplay(
                                      onTap: (value) {
                                        setState(() {
                                          _selectedGenre.remove(value);
                                        });
                                      },
                                      chipColor: Theme.of(context).primaryColor,
                                      textStyle:
                                          const TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                            // tags
                            Column(
                              children: <Widget>[
                                MultiSelectDialogField(
                                  items: _tagItems,
                                  title: const Text("Tags"),
                                  listType: MultiSelectListType.CHIP,
                                  searchable: true,
                                  buttonIcon: const Icon(
                                    FontAwesome.magic,
                                  ),
                                  buttonText: const Text(
                                    "Tags",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  selectedColor: Colors.grey,
                                  selectedItemsTextStyle:
                                      const TextStyle(color: Colors.white),
                                  unselectedColor: pxpColors.lighterCard,
                                  backgroundColor: pxpColors.darkCard,
                                  separateSelectedItems: true,
                                  onConfirm: (values) {
                                    _selectedTag = values.cast();
                                  },
                                  chipDisplay: MultiSelectChipDisplay(
                                      onTap: (value) {
                                        setState(() {
                                          _selectedTag.remove(value);
                                        });
                                      },
                                      chipColor: Theme.of(context).primaryColor,
                                      textStyle:
                                          const TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),

                            // status
                            Column(
                              children: <Widget>[
                                MultiSelectDialogField(
                                  items: _statusItems,
                                  title: const Text("Status"),
                                  listType: MultiSelectListType.CHIP,
                                  buttonIcon: const Icon(
                                    Entypo.progress_two,
                                  ),
                                  buttonText: const Text(
                                    "Status",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  selectedColor: Colors.grey,
                                  selectedItemsTextStyle:
                                      const TextStyle(color: Colors.white),
                                  unselectedColor: pxpColors.lighterCard,
                                  backgroundColor: pxpColors.darkCard,
                                  separateSelectedItems: true,
                                  onConfirm: (values) {
                                    _selectedStatus = values.cast();
                                  },
                                  chipDisplay: MultiSelectChipDisplay(
                                      onTap: (value) {
                                        setState(() {
                                          _selectedStatus.remove(value);
                                        });
                                      },
                                      chipColor: Theme.of(context).primaryColor,
                                      textStyle:
                                          const TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),

                            // content warnings
                            Column(
                              children: <Widget>[
                                MultiSelectDialogField(
                                  items: _contentItems,
                                  title: const Text("Content Warnings"),
                                  listType: MultiSelectListType.CHIP,
                                  buttonIcon: const Icon(
                                    Ionicons.ios_warning,
                                  ),
                                  buttonText: const Text(
                                    "Content Warnings",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  selectedColor: Colors.grey,
                                  selectedItemsTextStyle:
                                      const TextStyle(color: Colors.white),
                                  unselectedColor: pxpColors.lighterCard,
                                  backgroundColor: pxpColors.darkCard,
                                  separateSelectedItems: true,
                                  onConfirm: (values) {
                                    _selectedContent = values.cast();
                                  },
                                  chipDisplay: MultiSelectChipDisplay(
                                      onTap: (value) {
                                        setState(() {
                                          _selectedContent.remove(value);
                                        });
                                      },
                                      chipColor: Theme.of(context).primaryColor,
                                      textStyle:
                                          const TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),

                            // content warnings filter out
                            Column(
                              children: <Widget>[
                                MultiSelectDialogField(
                                  items: _contentOutItems,
                                  title: const Text(
                                      "Filter Out: Content Warnings"),
                                  listType: MultiSelectListType.CHIP,
                                  buttonIcon: const Icon(
                                    AntDesign.warning,
                                  ),
                                  buttonText: const Text(
                                    "Filter Out: Content Warnings",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  selectedColor: Colors.grey,
                                  selectedItemsTextStyle:
                                      const TextStyle(color: Colors.white),
                                  unselectedColor: pxpColors.lighterCard,
                                  backgroundColor: pxpColors.darkCard,
                                  separateSelectedItems: true,
                                  onConfirm: (values) {
                                    _selectedContentOut = values.cast();
                                  },
                                  chipDisplay: MultiSelectChipDisplay(
                                      onTap: (value) {
                                        setState(() {
                                          _selectedContentOut.remove(value);
                                        });
                                      },
                                      chipColor: Theme.of(context).primaryColor,
                                      textStyle:
                                          const TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                            SizedBox(height: 40),
                            Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 40,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      primary: Colors.white,
                                      side: BorderSide(
                                          color: Color.fromARGB(
                                              255, 193, 193, 193)),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                AdvancedResultsPage(),
                                            // settings:
                                            //     RouteSettings(
                                            //   arguments:
                                            //       book,
                                            // )
                                          ));
                                    },
                                    child: const Text("Search",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    )),
        ],
      ),
    );
  }
}
