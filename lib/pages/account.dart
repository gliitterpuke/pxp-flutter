import 'package:flutter/material.dart';
import 'package:pxp_flutter/json/home_json.dart';
import 'package:pxp_flutter/json/posts_json.dart';
import 'package:pxp_flutter/pages/book_detail.dart';
import 'package:pxp_flutter/pages/profile/user.dart';
import 'package:pxp_flutter/pages/edit_profile_page.dart';
import 'package:pxp_flutter/pages/profile/user_preferences.dart';
import 'package:pxp_flutter/pages/profile/appbar_widget.dart';
import 'package:pxp_flutter/pages/profile/button_widget.dart';
import 'package:pxp_flutter/pages/profile/numbers_widget.dart';
import 'package:pxp_flutter/pages/profile/profile_widget.dart';
import 'package:pxp_flutter/pages/profile/profile_tabbed.dart';
import 'package:pxp_flutter/constants/Theme.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    const user = UserPreferences.myUser;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: buildAppBar(context),
      body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    ProfileWidget(imagePath: user.imagePath),
                    SizedBox(height: 5),
                    buildName(user),
                    SizedBox(height: 20),
                    NumbersWidget(),
                    Container(
                        child: Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 24.0, right: 24, top: 30, bottom: 24),
                                child: Text(
                                  user.about,
                                  style: const TextStyle(
                                      fontSize: 16, height: 1.4),
                                ),
                              ),
                            ]))),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  primary: Colors.white,
                                  side: BorderSide(
                                      color: Colors.grey, width: .75)),
                              onPressed: () {},
                              child: const Text("Follow",
                                  style: TextStyle(fontSize: 13.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: () {},
                              child: const Text("Subscribe",
                                  style: TextStyle(fontSize: 13.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            )
          ];
        },
        body: DefaultTabController(
          length: 4,
          child: Column(children: [
            Container(
                child: TabBar(
                    labelStyle:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey.shade600,
                    indicatorColor: Colors.grey,
                    tabs: [
                  Tab(text: "BOOKS"),
                  Tab(text: "WALL"),
                  Tab(text: "REVIEWS"),
                  Tab(text: "BADGES"),
                ])),
            Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TabBarView(children: [
                      ListView(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Text(
                              "Authored",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
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
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                    fontWeight:
                                                        FontWeight.w600),
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
                              "Reading List",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
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
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                    fontWeight:
                                                        FontWeight.w600),
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
                              "Followed authors",
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
                                    List.generate(authorList.length, (index) {
                                  return Column(children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(99),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  authorList[index]['img']),
                                              fit: BoxFit.cover)),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Center(
                                        child: Text(
                                          authorList[index]['author'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: pxpColors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ]);
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListView(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    List.generate(postList.length, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => BookDetail()));
                                    },
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Card(
                                          elevation: 4.0,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                leading: Icon(
                                                    Icons.favorite_outline),
                                                title: Text(
                                                    postList[index]['display']),
                                                subtitle: Text(
                                                    postList[index]['date']),
                                                // trailing: Icon(
                                                //     Icons.favorite_outline),
                                              ),
                                              Container(
                                                height: 200.0,
                                                child: Ink.image(
                                                  image: AssetImage(
                                                      mylist[index]['img']),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(16.0),
                                                alignment: Alignment.centerLeft,
                                                child: Text('test'),
                                              ),
                                              ButtonBar(
                                                children: [
                                                  TextButton(
                                                    child: const Text(
                                                        'CONTACT AGENT'),
                                                    onPressed: () {
                                                      /* ... */
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text(
                                                        'LEARN MORE'),
                                                    onPressed: () {
                                                      /* ... */
                                                    },
                                                  )
                                                ],
                                              )
                                            ],
                                          )),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListView(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
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
                                        Row(
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
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
                                          ],
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
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                    fontWeight:
                                                        FontWeight.w600),
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
                              padding: const EdgeInsets.only(top: 10.0),
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
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                    fontWeight:
                                                        FontWeight.w600),
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
                              padding: const EdgeInsets.only(top: 10.0),
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
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                    fontWeight:
                                                        FontWeight.w600),
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
                              padding: const EdgeInsets.only(top: 10.0),
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
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                    fontWeight:
                                                        FontWeight.w600),
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
                      GridView.builder(
                          itemCount: genreList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 0,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 1),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xff161618),
                                  child: IconButton(
                                    icon: Icon(
                                      genreList[index]['icon'],
                                      color: pxpColors.secondaryT,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => BookDetail()));
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
                              ]),
                            );
                            ;
                          })
                    ])))
          ]),
        ),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 4),
          Text(
            user.handle,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  post(delay, image, type) {
    return Container(
      margin: type == 'grid' ? EdgeInsets.all(0) : EdgeInsets.only(top: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(image),
      ),
    );
  }
}
