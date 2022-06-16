import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:pxp_flutter/json/book_detail_json.dart';
import 'package:pxp_flutter/json/home_json.dart';
import 'package:pxp_flutter/json/library.dart';
import 'package:pxp_flutter/pages/book/all_review.dart';
import 'package:pxp_flutter/pages/book/all_user_review.dart';
import 'package:pxp_flutter/pages/book/review.dart';
import 'package:pxp_flutter/pages/book_detail.dart';
import 'package:pxp_flutter/pages/ig/app/app.dart';
import 'package:pxp_flutter/pages/ig/components/app_widgets/app_widgets.dart';
import 'package:pxp_flutter/pages/ig/components/new_post/new_post_screen.dart';
import 'package:pxp_flutter/pages/profile/user_preferences.dart';
import 'package:pxp_flutter/pages/profile/appbar_widget.dart';
import 'package:pxp_flutter/constants/Theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:stream_feed_flutter_core/stream_feed_flutter_core.dart';

import 'ig/components/timeline/widgets/post_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    const user = UserPreferences.myUser;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: buildAppBar(context),
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
                    const _ProfileHeader(numberOfPosts: 0),
                    // SizedBox(height: 20),
                    Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24.0, right: 24, top: 30, bottom: 24),
                            child: Text(
                              user.about,
                              style: const TextStyle(fontSize: 16, height: 1.4),
                            ),
                          ),
                        ])),
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
                                  side: const BorderSide(
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
                    const SizedBox(height: 10),
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
                    labelStyle: const TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.bold),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey.shade600,
                    indicatorColor: Colors.grey,
                    tabs: const [
                  Tab(text: "BOOKS"),
                  Tab(text: "WALL"),
                  Tab(text: "REVIEWS"),
                  Tab(text: "BADGES"),
                ])),
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
                                          builder: (_) => const BookDetail()));
                                },
                                child: Column(children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    width: 115,
                                    height: 160,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
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
                                          style: const TextStyle(
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
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
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
                          children: List.generate(readLater.length, (index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const BookDetail()));
                                },
                                child: Column(children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    width: 115,
                                    height: 160,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        image: DecorationImage(
                                            image: AssetImage(readLater[index]
                                                ['books']['img'][0]),
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
                                          '${readLater[index]['books']['title'].length ?? "Empty"}' +
                                              ' titles',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(
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
                                          '${readLater[index]['name'] ?? "Empty"}',
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
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Text(
                        "Followed authors",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                          children: List.generate(authorList.length, (index) {
                            return Column(children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(99),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            authorList[index]['img']),
                                        fit: BoxFit.cover)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 100,
                                child: Center(
                                  child: Text(
                                    authorList[index]['author'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
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
                      feedGroup: 'timeline',
                      errorBuilder: (context, error) =>
                          const Text('Could not load profile'),
                      loadingBuilder: (context) => const SizedBox(),
                      emptyBuilder: (context) => const Center(
                        child: Text('No Posts\nGo and post something'),
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
                                  feedGroup: 'timeline',
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
                                key: ValueKey('post-${activities[index].id}'),
                                enrichedActivity: activities[index],
                                onAddComment: openCommentBox,
                              );
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
                padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
                child: ListView(
                  children: [
                    Column(
                      children: List.generate(dataToShow.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ReviewPage(reviewObj: dataToShow[index]),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(99),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  dataToShow[index]['img']),
                                              fit: BoxFit.cover)),
                                    ),
                                    SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  30) *
                                              0.8,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxWidth: 220),
                                                  child: Text(
                                                    dataToShow[index]['title'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Text(
                                                  " by " +
                                                      dataToShow[index]
                                                          ['display'],
                                                  style: const TextStyle(
                                                      color:
                                                          pxpColors.secondaryT,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                                children: _ratingCount(
                                                    dataToShow[index]
                                                        ['overall'])),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              dataToShow[index]['date'] +
                                                  " at Chapter " +
                                                  dataToShow[index]['location']
                                                      .toString(),
                                              style: const TextStyle(
                                                  color: pxpColors.secondaryT,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
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
                                    const Icon(
                                      Feather.thumbs_up,
                                      size: 20,
                                      color: pxpColors.secondaryT,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      dataToShow[index]['helpful'].toString(),
                                      style: const TextStyle(
                                          color: pxpColors.secondaryT,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    if (dataToShow[index]['award'] == true)
                                      const Spacer(),
                                    if (dataToShow[index]['award'] == true)
                                      const Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: const Icon(
                                          FontAwesome.diamond,
                                          size: 20,
                                          color: pxpColors.secondaryT,
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
                                  color: Color.fromARGB(255, 193, 193, 193)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AllUserReview(),
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                      builder: (_) => const BookDetail()));
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

  post(delay, image, type) {
    return Container(
      margin: type == 'grid'
          ? const EdgeInsets.all(0)
          : const EdgeInsets.only(top: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(image),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    Key? key,
    required this.numberOfPosts,
  }) : super(key: key);

  final int numberOfPosts;

  static const _statitisticsPadding =
      EdgeInsets.symmetric(horizontal: 12, vertical: 8.0);

  @override
  Widget build(BuildContext context) {
    final feedState = context.watch<AppState>();
    final streamagramUser = feedState.streamagramUser;
    if (streamagramUser == null) return const SizedBox.shrink();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Avatar.big(
            streamagramUser: streamagramUser,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(streamagramUser.fullName,
              style: AppTextStyle.textStyleBoldMedium),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: _statitisticsPadding,
              child: Column(
                children: [
                  Text(
                    '$numberOfPosts',
                    style: AppTextStyle.textStyleBold,
                  ),
                  const Text(
                    'Posts',
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
                    '${FeedProvider.of(context).bloc.currentUser?.followersCount ?? 0}',
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
                    '${FeedProvider.of(context).bloc.currentUser?.followingCount ?? 0}',
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
    );
  }
}

class _NoPostsMessage extends StatelessWidget {
  const _NoPostsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('This is too empty'),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(NewPostScreen.route); // ADD THIS
          },
          child: const Text('Add a post'),
        )
      ],
    );
  }
}

class _PictureViewer extends StatelessWidget {
  const _PictureViewer({
    Key? key,
    required this.activity,
  }) : super(key: key);

  final EnrichedActivity activity;

  @override
  Widget build(BuildContext context) {
    final resizedUrl = activity.extraData!['resized_image_url'] as String?;
    final fullSizeUrl = activity.extraData!['image_url'] as String;
    final aspectRatio = activity.extraData!['aspect_ratio'] as double?;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: InteractiveViewer(
        child: Center(
          child: Hero(
            tag: 'hero-image-${activity.id}',
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin, end: end);
            },
            child: AspectRatio(
              aspectRatio: aspectRatio ?? 1,
              child: CachedNetworkImage(
                fadeInDuration: Duration.zero,
                placeholder: (resizedUrl != null)
                    ? (context, url) => CachedNetworkImage(
                          imageBuilder: (context, imageProvider) =>
                              DecoratedBox(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          imageUrl: resizedUrl,
                        )
                    : null,
                imageBuilder: (context, imageProvider) => DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                imageUrl: fullSizeUrl,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class FollowWidget extends StatelessWidget {
//   static const _statitisticsPadding =
//       EdgeInsets.symmetric(horizontal: 12, vertical: 8.0);
//   @override
//   Widget build(BuildContext context) => Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[],
//       );
// }

class _CommentBox extends StatefulWidget {
  const _CommentBox({
    Key? key,
    required this.commenter,
    required this.textEditingController,
    required this.focusNode,
    required this.addComment,
    required this.showCommentBox,
  }) : super(key: key);

  final StreamagramUser commenter;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final Function(String?) addComment;
  final ValueNotifier<bool> showCommentBox;

  @override
  __CommentBoxState createState() => __CommentBoxState();
}

class __CommentBoxState extends State<_CommentBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
    reverseCurve: Curves.easeIn,
  );

  bool visibility = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          visibility = false;
        });
      } else {
        setState(() {
          visibility = true;
        });
      }
    });
    widget.showCommentBox.addListener(_showHideCommentBox);
  }

  void _showHideCommentBox() {
    if (widget.showCommentBox.value) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: FadeTransition(
        opacity: _animation,
        child: Builder(builder: (context) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: CommentBox(
              commenter: widget.commenter,
              textEditingController: widget.textEditingController,
              focusNode: widget.focusNode,
              onSubmitted: widget.addComment,
            ),
          );
        }),
      ),
    );
  }
}

List<Icon> _ratingCount(int count) {
  return List.generate(count,
          (i) => const Icon(AntDesign.star, size: 10, color: tierColor.bronze))
      .toList(); // replace * with your rupee or use Icon instead
}
