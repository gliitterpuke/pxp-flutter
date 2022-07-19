import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pxp_flutter/json/book_detail_json.dart';
import 'package:pxp_flutter/json/home_json.dart';
import 'package:pxp_flutter/json/library.dart';
import 'package:pxp_flutter/pages/book/all_user_review.dart';
import 'package:pxp_flutter/pages/book/review.dart';
import 'package:pxp_flutter/pages/book_detail.dart';
import 'package:pxp_flutter/pages/ig/app/app.dart';
import 'package:pxp_flutter/pages/ig/components/app_widgets/app_widgets.dart';
import 'package:pxp_flutter/pages/ig/components/new_post/new_post_screen.dart';
import 'package:pxp_flutter/pages/profile/settings.dart';
import 'package:pxp_flutter/constants/Theme.dart';
import 'package:pxp_flutter/pages/reading_list.dart';
import 'package:stream_feed_flutter_core/stream_feed_flutter_core.dart';

import 'ig/components/timeline/widgets/post_card.dart';
import 'package:http/http.dart' as http;

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final Map userId;

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late bool isFollowing;
  bool isHelpful = false;
  final box = GetStorage();
  static const url = 'http://localhost:5000/api/v1/';
  final jsonHeaders = {"Content-type": "application/json"};

  final ValueNotifier<bool> _showCommentBox = ValueNotifier(false);
  final TextEditingController _commentTextController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();
  EnrichedActivity? activeActivity;

  void openCommentBox(EnrichedActivity activity, {String? message}) {
    _commentTextController.text = message ?? '';
    _commentTextController.selection = TextSelection.fromPosition(
        TextPosition(offset: _commentTextController.text.length));
    activeActivity = activity;
    _showCommentBox.value = true;
    _commentFocusNode.requestFocus();
  }

  Future<void> addComment(String? message) async {
    if (activeActivity != null &&
        message != null &&
        message.isNotEmpty &&
        message != '') {
      await FeedProvider.of(context).bloc.onAddReaction(
        kind: 'comment',
        activity: activeActivity!,
        feedGroup: 'timeline',
        data: {'message': message},
      );
      _commentTextController.clear();
      FocusScope.of(context).unfocus();
      _showCommentBox.value = false;
    }
  }

  Future<String> getPfp() async {
    final box = GetStorage();
    final userResp =
        await http.get(Uri.parse(url + 'users/${widget.userId['id']}'));
    final Map dbUser = json.decode(userResp.body);

    final pic = dbUser['profile']['pic']['url'];
    final a = Uri.parse(pic);
    final pfpImg = await http.get(Uri.parse(
        'http://localhost:5000/api/v1/sign-s3-get?bucket=pxp-demo2&key=${a.pathSegments.last}'));
    await box.write('${widget.userId}_pfp', pfpImg.body);
    final pfp = await box.read('${widget.userId}_pfp');
    final decodePfp = json.decode(pfp);
    return decodePfp;
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  void dispose() {
    _commentTextController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int _page = 0;
    const int _perPage = 5;
    final dataToShow = userReviewList.sublist(
        (_page * _perPage), ((_page * _perPage) + _perPage));
    return FutureBuilder<String>(
        future: getPfp(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const SizedBox.shrink();
            default:
              if (snapshot.hasError) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Could not load userDataFuture'),
                );
              } else {
                return Scaffold(
                  floatingActionButton:
                      context.appState.client.currentUser!.id ==
                              widget.userId['profile']['username']
                          ? FloatingActionButton(
                              child: Icon(
                                AntDesign.addfile,
                                size: 20,
                              ),
                              backgroundColor: pxpColors.accent,
                              foregroundColor: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewPostScreen(),
                                    ));
                              })
                          : null,
                  backgroundColor: Colors.black,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: true,
                    title: Text(
                      widget.userId['profile']['username'],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TapFadeIcon(
                          onTap: () =>
                              Navigator.of(context).push(NewPostScreen.route),
                          icon: Icons.add_circle_outline,
                          iconColor: Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Feather.settings),
                        iconSize: 20,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const Settings()),
                          );
                        },
                      ),
                    ],
                  ),
                  body: NestedScrollView(
                    headerSliverBuilder: (context, value) {
                      return [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                _UserProfile(
                                    userId: widget.userId,
                                    pfpImg: snapshot.data.toString()),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ];
                    },
                    body: DefaultTabController(
                      length: 4,
                      child: Column(children: [
                        TabBar(
                            labelStyle: const TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.bold),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.grey.shade600,
                            indicatorColor: pxpColors.accent,
                            tabs: const [
                              Tab(text: "BOOKS"),
                              Tab(text: "WALL"),
                              Tab(text: "REVIEWS"),
                              Tab(text: "BADGES"),
                            ]),
                        Expanded(
                            child: TabBarView(children: [
                          // BOOKS
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ListView(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Text(
                                    "Authored",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      children:
                                          List.generate(mylist.length, (index) {
                                        return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          const BookDetail()));
                                            },
                                            child: Column(children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                width: 115,
                                                height: 160,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            mylist[index]
                                                                ['img']),
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
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: const TextStyle(
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
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                const SizedBox(
                                  height: 30,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Text(
                                    "Reading List",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      children: List.generate(readLater.length,
                                          (index) {
                                        return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ReadingListPage(),
                                                      settings: RouteSettings(
                                                        arguments:
                                                            readLater[index],
                                                      )));
                                            },
                                            child: Column(children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                width: 115,
                                                height: 160,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            readLater[index]
                                                                    ['books']
                                                                [index]['img']),
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
                                                      '${readLater[index]['books'].length ?? "Empty"}' +
                                                          ' titles',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: const TextStyle(
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
                                                      readLater[index]
                                                              ['name'] ??
                                                          'Empty',
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                const SizedBox(
                                  height: 30,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Text(
                                    "Followed authors",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: List.generate(authorList.length,
                                          (index) {
                                        return Column(children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(99),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        authorList[index]
                                                                ['profile']
                                                            ['pic']['url']),
                                                    fit: BoxFit.cover)),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: Center(
                                              child: Text(
                                                authorList[index]['profile']
                                                    ['username'],
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    color: pxpColors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                          ),

                          // WALL
                          GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              _showCommentBox.value = false;
                            },
                            child: Stack(
                              children: [
                                FlatFeedCore(
                                  userId: widget.userId['profile']['username'],
                                  feedGroup: 'user',
                                  errorBuilder: (context, error) =>
                                      const Text('Could not load profile'),
                                  loadingBuilder: (context) => const SizedBox(),
                                  emptyBuilder: (context) => Center(
                                    child: context.appState.client.currentUser!
                                                .id ==
                                            widget.userId['profile']['username']
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                                const Text('No posts yet',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                const SizedBox(height: 15),
                                                SizedBox(
                                                  height: 40,
                                                  child: TextButton(
                                                    style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          pxpColors.accent,
                                                    ),
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .push(NewPostScreen
                                                                .route),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.0),
                                                      child: Text("Add a post",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                  ),
                                                ),
                                              ])
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                                Text(
                                                    "${widget.userId['profile']['username']} has not posted anything yet!",
                                                    style: const TextStyle(
                                                        fontSize: 16)),
                                              ]),
                                  ),
                                  flags: EnrichmentFlags()
                                    ..withOwnReactions()
                                    ..withRecentReactions()
                                    ..withReactionCounts(),
                                  feedBuilder: (context, activities) {
                                    return RefreshIndicator(
                                      onRefresh: () {
                                        return FeedProvider.of(context)
                                            .bloc
                                            .refreshPaginatedEnrichedActivities(
                                              feedGroup: 'user',
                                              userId: widget.userId['profile']
                                                  ['username'],
                                              flags: EnrichmentFlags()
                                                ..withOwnReactions()
                                                ..withRecentReactions()
                                                ..withReactionCounts(),
                                            );
                                      },
                                      child: ListView.builder(
                                        itemCount: activities.length,
                                        itemBuilder: (context, index) {
                                          return PostCard(
                                              key: ValueKey(
                                                  'post-${activities[index].id}'),
                                              enrichedActivity:
                                                  activities[index],
                                              onAddComment: openCommentBox,
                                              user: widget.userId,
                                              pfpImg: snapshot.data.toString());
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          // REVIEWS
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, right: 10, left: 10),
                            child: ListView(
                              children: [
                                Column(
                                  children:
                                      List.generate(dataToShow.length, (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ReviewPage(
                                                reviewObj: dataToShow[index]),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              99),
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              dataToShow[index]
                                                                  ['img']),
                                                          fit: BoxFit.cover)),
                                                ),
                                                SizedBox(
                                                  width: (MediaQuery.of(context)
                                                              .size
                                                              .width -
                                                          30) *
                                                      0.8,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              constraints:
                                                                  const BoxConstraints(
                                                                      maxWidth:
                                                                          220),
                                                              child: Text(
                                                                dataToShow[
                                                                        index]
                                                                    ['title'],
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                            Text(
                                                              " by " +
                                                                  dataToShow[
                                                                          index]
                                                                      [
                                                                      'display'],
                                                              style: const TextStyle(
                                                                  color: pxpColors
                                                                      .secondaryT,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                            children: _ratingCount(
                                                                dataToShow[
                                                                        index][
                                                                    'overall'])),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          dataToShow[index]
                                                                  ['date'] +
                                                              " at Chapter " +
                                                              dataToShow[index][
                                                                      'location']
                                                                  .toString(),
                                                          style: const TextStyle(
                                                              color: pxpColors
                                                                  .secondaryT,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              dataToShow[index]['review'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(height: 5),
                                            const Text("Read more",
                                                style: TextStyle(
                                                    color: Colors.pink,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14)),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      isHelpful = !isHelpful;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Feather.thumbs_up,
                                                    size: 20,
                                                    color: pxpColors.secondaryT,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                isHelpful == true
                                                    ? Text(
                                                        dataToShow[index]
                                                                ['helpful']
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    : Text(
                                                        dataToShow[index]
                                                                ['helpful']
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: pxpColors
                                                                .secondaryT,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                if (dataToShow[index]
                                                        ['award'] ==
                                                    true)
                                                  const Spacer(),
                                                if (dataToShow[index]
                                                        ['award'] ==
                                                    true)
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10),
                                                    child: Icon(
                                                      FontAwesome.diamond,
                                                      size: 20,
                                                      color:
                                                          pxpColors.secondaryT,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            const SizedBox(height: 10)
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 40,
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          primary: Colors.white,
                                          side: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 193, 193, 193)),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AllUserReview(),
                                            ),
                                          );
                                        },
                                        child: const Text("Read more reviews",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                    ),
                                    const SizedBox(height: 60)
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // BADGES
                          GridView.builder(
                              itemCount: badgeList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
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
                                      backgroundColor: const Color(0xff161618),
                                      child: IconButton(
                                        icon: Icon(
                                          badgeList[index]['icon'],
                                          color: pxpColors.secondaryT,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const BookDetail()));
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: 80,
                                        child: Center(
                                          child: Text(
                                            badgeList[index]['badge'],
                                            textAlign: TextAlign.center,
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
                                  ]),
                                );
                              })
                        ]))
                      ]),
                    ),
                  ),
                );
              }
          }
        });
  }
}

class _UserProfile extends StatefulWidget {
  const _UserProfile({
    Key? key,
    required this.userId,
    required this.pfpImg,
  }) : super(key: key);

  final Map userId;
  final String pfpImg;

  @override
  __UserProfileState createState() => __UserProfileState();
}

class __UserProfileState extends State<_UserProfile> {
  late StreamUser streamUser;
  late bool isFollowing;
  late Future<Map> userDataFuture = getUser();
  // late String pfpImg;
  late Map followCount;
  static const url = 'http://localhost:5000/api/v1/';

  Future<Map> getUser() async {
    final userClient =
        context.appState.client.user(widget.userId['profile']['username']);
    final futures = await Future.wait([
      userClient.get(),
      _isFollowingUser(widget.userId),
      _followCount(widget.userId),
    ]);
    streamUser = futures[0] as StreamUser;
    isFollowing = futures[1] as bool;
    followCount = futures[2] as Map;

    return streamUser.data!;
  }

  /// Determine if the current authenticated user is following [user].
  Future<bool> _isFollowingUser(userId) async {
    return FeedProvider.of(context)
        .bloc
        .isFollowingFeed(followerId: userId['profile']['username']);
  }

  Future<Map> _followCount(userId) async {
    final resp = await http.get(Uri.parse(
        url + 'stream/feed/stats/user:${userId['profile']['username']}'));
    followCount = json.decode(resp.body)['results'];
    return followCount;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: userDataFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const SizedBox.shrink();
          default:
            if (snapshot.hasError) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Could not load userDataFuture'),
              );
            } else {
              final userData = snapshot.data;
              if (userData != null) {
                return _ProfileTile(
                  user: streamUser,
                  // userData: userData,
                  isFollowing: isFollowing,
                  pfpImg: widget.pfpImg,
                  userId: widget.userId,
                  followers: followCount,
                );
              }
              return const SizedBox.shrink();
            }
        }
      },
    );
  }
}

class _ProfileTile extends StatefulWidget {
  const _ProfileTile({
    Key? key,
    required this.user,
    // required this.userData,
    required this.isFollowing,
    required this.pfpImg,
    required this.userId,
    required this.followers,
  }) : super(key: key);

  final StreamUser user;
  // final Map userData;
  final bool isFollowing;
  final String pfpImg;
  final Map userId;
  final Map followers;

  @override
  __ProfileTileState createState() => __ProfileTileState();
}

class __ProfileTileState extends State<_ProfileTile> {
  bool _isLoading = false;
  late bool _isFollowing = widget.isFollowing;

  static const _statitisticsPadding =
      EdgeInsets.symmetric(horizontal: 12, vertical: 8.0);

  Future<void> followOrUnfollowUser(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    if (_isFollowing) {
      final bloc = FeedProvider.of(context).bloc;
      await bloc.unfollowFeed(
          unfolloweeId: widget.userId['profile']['username']);
      _isFollowing = false;
    } else {
      await FeedProvider.of(context)
          .bloc
          .followFeed(followeeId: widget.userId['profile']['username']);
      _isFollowing = true;
    }
    FeedProvider.of(context).bloc.refreshPaginatedEnrichedActivities(
          feedGroup: 'timeline',
          flags: EnrichmentFlags()
            ..withOwnReactions()
            ..withRecentReactions()
            ..withReactionCounts(),
        );

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CachedNetworkImage(
              imageUrl: widget.pfpImg,
              imageBuilder: (context, imageProvider) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      CircleAvatar(radius: 30, backgroundImage: imageProvider)),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: _statitisticsPadding,
                  child: Column(
                    children: [
                      Text(
                        widget.followers['followers']['count'].toString(),
                        style: AppTextStyle.textStyleBold,
                      ),
                      const Text(
                        'Followers',
                        style: AppTextStyle.textStyleLight,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: _statitisticsPadding,
                  child: Column(
                    children: [
                      Text(
                        widget.followers['following']['count'].toString(),
                        style: AppTextStyle.textStyleBold,
                      ),
                      const Text(
                        'Following',
                        style: AppTextStyle.textStyleLight,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 8.0, right: 8, left: 8, bottom: 4),
            child: Text(widget.userId['profile']['username'],
                style: AppTextStyle.textStyleBoldMedium),
          ),
        ),
        if (widget.userId['profile']['bio'] != "")
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Text(
                widget.userId['profile']['bio'],
              ),
            ),
          ),

        //change for live
        if (context.appState.user.id == context.appState.client.currentUser!.id)
          Row(
            children: <Widget>[
              Expanded(
                  child: _isLoading
                      ? const CircularProgressIndicator(strokeWidth: 3)
                      : TextButton(
                          child: _isFollowing
                              ? const Text('Unfollow')
                              : const Text('Follow'),
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                            primary: Colors.white,
                            backgroundColor: _isFollowing
                                ? pxpColors.darkElevatedSecondary
                                : pxpColors.accent,
                            onSurface: Colors.grey,
                          ),
                          onPressed: () {
                            followOrUnfollowUser(context);
                          },
                        )),
              const SizedBox(width: 10),
              Expanded(
                child: TextButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: pxpColors.darkElevatedSecondary,
                    onSurface: Colors.grey,
                  ),
                  onPressed: () {},
                  child: const Text("Subscribe",
                      style: TextStyle(
                          fontSize: 13.0, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

List<Icon> _ratingCount(int count) {
  return List.generate(count,
          (i) => const Icon(AntDesign.star, size: 10, color: tierColor.bronze))
      .toList(); // replace * with your rupee or use Icon instead
}
