import 'package:flutter/material.dart';
import 'package:pxp_flutter/pages/book_detail.dart';
import 'package:pxp_flutter/json/library.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pxp_flutter/constants/Theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pxp_flutter/pages/root_app.dart';
import 'package:share_plus/share_plus.dart';

class ReadingListPage extends StatefulWidget {
  const ReadingListPage({Key? key}) : super(key: key);

  @override
  _ReadingListPageState createState() => _ReadingListPageState();
}

class _ReadingListPageState extends State<ReadingListPage>
    with SingleTickerProviderStateMixin {
  final bodyGlobalKey = GlobalKey();

  bool isSelectionMode = false;
  String readingList = '';

  bool isNotify = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _readingList(Map list) => ListView(
        children: [
          Column(
              children: List.generate(list['books'].length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookDetail(),
                        settings: RouteSettings(
                          arguments: readLater[index],
                        )));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 18, bottom: 10),
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: const [
                      SlidableAction(
                        onPressed: _onShare,
                        backgroundColor: Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.share,
                        label: 'Share',
                      ),
                      SlidableAction(
                        onPressed: doNothing,
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 110,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            list['books'][index]['img']),
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          ),
                          SizedBox(
                            width:
                                (MediaQuery.of(context).size.width - 30) * 0.8,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  new Text(
                                    list['books'][index]['chapters'] +
                                        " chapters",
                                    style: TextStyle(
                                      color: pxpColors.secondaryT,
                                      fontSize: 11,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: ((MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    30) *
                                                0.8) -
                                            50,
                                        child: Text(
                                          list['books'][index]['title'],
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isNotify = !isNotify;
                                          });
                                        },
                                        child: Container(
                                            width: 35,
                                            height: 35,
                                            child: isNotify == true
                                                ? Icon(
                                                    MaterialCommunityIcons
                                                        .bell_ring_outline,
                                                    color: Color(0xff8f94fb),
                                                    size: 20,
                                                  )
                                                : Icon(
                                                    MaterialCommunityIcons
                                                        .bell_outline,
                                                    color: pxpColors.secondaryT,
                                                    size: 20,
                                                  )),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(
                                          list['books'][index]['tags'].length,
                                          (idx) {
                                        return GestureDetector(
                                            onTap: () {},
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                    color: Colors.white
                                                        .withOpacity(0.2)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6,
                                                          right: 6,
                                                          top: 4,
                                                          bottom: 4),
                                                  child: Text(
                                                    list['books'][index]['tags']
                                                        [idx],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            ));
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          })),
        ],
      );

  _noReadingList() => Padding(
      padding: const EdgeInsets.only(left: 45, right: 45),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Choose from thousands of stories to add to your Reading List!",
              textAlign: TextAlign.center,
              style: TextStyle(color: pxpColors.secondaryT, fontSize: 16),
            ),
            SizedBox(height: 30),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                side: BorderSide(color: Color.fromARGB(255, 193, 193, 193)),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RootApp()));
              },
              child: const Text("Get started",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ]));

  @override
  Widget build(BuildContext context) {
    final list = ModalRoute.of(context)!.settings.arguments as Map;
    final book = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        list['name'] ?? book['title'],
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      )),
      backgroundColor: pxpColors.bgColorScreen,
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          child:
              list['books'].isNotEmpty ? _readingList(list) : _noReadingList(),
        ),
      ),
    );
  }

  Future<String?> openDialog() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            titlePadding: EdgeInsets.only(top: 40),
            contentPadding: EdgeInsets.all(20),
            backgroundColor: pxpColors.lighterCard,
            title: Column(
              children: [
                Text('Create a reading list'),
                SizedBox(height: 5),
                Text('Enter your reading list name',
                    style: TextStyle(fontSize: 14))
              ],
            ),
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(hintText: 'E.g. Best books!!'),
              // controller: controller,
              onSubmitted: (_) => submit(),
            ),
            actions: [
              TextButton(onPressed: cancel, child: Text('Cancel')),
              TextButton(
                  onPressed: submit,
                  child: Text('Create', style: TextStyle(color: Colors.white)))
            ],
          ));

  void submit() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReadingListPage(),
            settings: RouteSettings(
                // arguments: {'newList': controller.text},
                )));
    // controller.clear();
  }

  void cancel() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

void _onShare(BuildContext context) async {
  final box = context.findRenderObject() as RenderBox?;
  await Share.share('hey',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
}

void doNothing(BuildContext context) {}
