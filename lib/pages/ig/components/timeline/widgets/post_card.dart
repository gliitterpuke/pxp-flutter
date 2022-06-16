import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:pxp_flutter/pages/book_detail.dart';
import 'package:stream_feed_flutter_core/stream_feed_flutter_core.dart';

import '../../../app/app.dart';
import '../../app_widgets/app_widgets.dart';
import '../../comments/comments_screen.dart';
import 'package:pxp_flutter/constants/Theme.dart';

typedef OnAddComment = void Function(
  EnrichedActivity activity, {
  String? message,
});

/// {@template post_card}
/// A card that displays a user post/activity.
/// {@endtemplate}
class PostCard extends StatelessWidget {
  /// {@macro post_card}
  const PostCard({
    Key? key,
    required this.enrichedActivity,
    required this.onAddComment,
  }) : super(key: key);

  /// Enriched activity (post) to display.
  final EnrichedActivity enrichedActivity;
  final OnAddComment onAddComment;

  @override
  Widget build(BuildContext context) {
    final actorData = enrichedActivity.actor!.data;
    final userData = StreamagramUser.fromMap(actorData as Map<String, dynamic>);

    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        decoration: BoxDecoration(
            color: pxpColors.darkCard,
            border: Border.all(),
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: pxpColors.darkCard,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  builder: (context) => FractionallySizedBox(
                        heightFactor: 0.9,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _ProfileSlab(
                                  enrichedActivity: enrichedActivity,
                                  userData: userData,
                                ),
                                const SizedBox(height: 10),
                                if (enrichedActivity.extraData!['image_url'] !=
                                    null)
                                  _PictureCarousal(
                                    enrichedActivity: enrichedActivity,
                                  ),
                                _Title(
                                  enrichedActivity: enrichedActivity,
                                ),
                                _FullDescription(
                                  enrichedActivity: enrichedActivity,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProfileSlab(
                  enrichedActivity: enrichedActivity,
                  userData: userData,
                ),
                const SizedBox(height: 10),
                if (enrichedActivity.extraData!['image_url'] != null)
                  _PictureCarousal(
                    enrichedActivity: enrichedActivity,
                  ),
                _Title(
                  enrichedActivity: enrichedActivity,
                ),
                _Description(
                  enrichedActivity: enrichedActivity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PictureCarousal extends StatefulWidget {
  const _PictureCarousal({
    Key? key,
    required this.enrichedActivity,
  }) : super(key: key);

  final EnrichedActivity enrichedActivity;

  @override
  __PictureCarousalState createState() => __PictureCarousalState();
}

class __PictureCarousalState extends State<_PictureCarousal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._pictureCarousel(context),
      ],
    );
  }

  /// Picture carousal and interaction buttons.
  List<Widget> _pictureCarousel(BuildContext context) {
    var imageUrl = widget.enrichedActivity.extraData!['image_url'] as String;
    double aspectRatio =
        widget.enrichedActivity.extraData!['aspect_ratio'] as double? ?? 1.0;
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 600),
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
              ),
            ),
          ),
        ),
      ),
    ];
  }
}

class _Description extends StatefulWidget {
  const _Description({
    Key? key,
    required this.enrichedActivity,
  }) : super(key: key);

  final EnrichedActivity enrichedActivity;

  @override
  __DescriptionState createState() => __DescriptionState();
}

class __DescriptionState extends State<_Description> {
  late var likeReactions = getLikeReactions() ?? [];
  late var likeCount = getLikeCount() ?? 0;
  late var commentCount = getCommentCount() ?? 0;

  Reaction? latestLikeReaction;

  List<Reaction>? getLikeReactions() {
    return widget.enrichedActivity.latestReactions?['like'] ?? [];
  }

  int? getLikeCount() {
    return widget.enrichedActivity.reactionCounts?['like'] ?? 0;
  }

  int? getCommentCount() {
    return widget.enrichedActivity.reactionCounts?['comment'] ?? 0;
  }

  Future<void> _addLikeReaction() async {
    latestLikeReaction = await context.appState.client.reactions.add(
      'like',
      widget.enrichedActivity.id!,
      userId: context.appState.user.id,
    );

    setState(() {
      likeReactions.add(latestLikeReaction!);
      likeCount++;
    });
  }

  Future<void> _removeLikeReaction() async {
    late String? reactionId;

    // A new reaction was added to this state.
    if (latestLikeReaction != null) {
      reactionId = latestLikeReaction?.id;
    } else {
      // An old reaction has been retrieved from Stream.
      final prevReaction = widget.enrichedActivity.ownReactions?['like'];
      if (prevReaction != null && prevReaction.isNotEmpty) {
        reactionId = prevReaction[0].id;
      }
    }

    try {
      if (reactionId != null) {
        await context.appState.client.reactions.delete(reactionId);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setState(() {
      likeReactions.removeWhere((element) => element.id == reactionId);
      likeCount--;
      latestLikeReaction = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._description(context),
      ],
    );
  }

  /// Like/comment bar
  List<Widget> _description(BuildContext context) {
    const iconPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);
    const iconColor = pxpColors.secondaryT;
    return [
      Padding(
        padding: const EdgeInsets.only(
            left: 5.0, right: 5.0, top: 5.0, bottom: 10.0),
        child: Text(
          widget.enrichedActivity.extraData?['description'] as String? ?? '',
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: const TextStyle(
              color: pxpColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.2),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
            left: 5.0, right: 5.0, top: 5.0, bottom: 20.0),
        child: Text(
          "Read More",
          style: TextStyle(
              color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
      Row(
        children: [
          Padding(
            padding: iconPadding,
            child: FavoriteIconButton(
              isLiked: widget.enrichedActivity.ownReactions?['like'] != null,
              onTap: (liked) {
                if (liked) {
                  _addLikeReaction();
                } else {
                  _removeLikeReaction();
                }
              },
            ),
          ),
          likeCount > 0
              ? Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Text(
                    likeCount.toString(),
                    style: const TextStyle(
                        color: pxpColors.secondaryT,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2),
                  ))
              : const SizedBox(width: 30),
          Padding(
            padding: iconPadding,
            child: TapFadeIcon(
              onTap: () {
                // ADD THIS
                final map = widget.enrichedActivity.actor!.data!;

                // AND THIS
                Navigator.of(context).push(
                  CommentsScreen.route(
                    enrichedActivity: widget.enrichedActivity,
                    activityOwnerData: StreamagramUser.fromMap(map),
                  ),
                );
              },
              icon: Icons.chat_bubble_outline,
              iconColor: iconColor,
            ),
          ),
          commentCount > 0
              ? Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Text(
                    commentCount.toString(),
                    style: const TextStyle(
                        color: pxpColors.secondaryT,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2),
                  ))
              : const SizedBox(width: 30),
          Padding(
            padding: iconPadding,
            child: TapFadeIcon(
              onTap: () =>
                  context.removeAndShowSnackbar('Message: Not yet implemented'),
              icon: Feather.share,
              iconColor: iconColor,
            ),
          ),
        ],
      ),
    ];
  }
}

class _FullDescription extends StatefulWidget {
  const _FullDescription({
    Key? key,
    required this.enrichedActivity,
  }) : super(key: key);

  final EnrichedActivity enrichedActivity;

  @override
  __FullDescriptionState createState() => __FullDescriptionState();
}

class __FullDescriptionState extends State<_FullDescription> {
  late var likeReactions = getLikeReactions() ?? [];
  late var likeCount = getLikeCount() ?? 0;
  late var commentCount = getCommentCount() ?? 0;

  Reaction? latestLikeReaction;

  List<Reaction>? getLikeReactions() {
    return widget.enrichedActivity.latestReactions?['like'] ?? [];
  }

  int? getLikeCount() {
    return widget.enrichedActivity.reactionCounts?['like'] ?? 0;
  }

  int? getCommentCount() {
    return widget.enrichedActivity.reactionCounts?['comment'] ?? 0;
  }

  Future<void> _addLikeReaction() async {
    latestLikeReaction = await context.appState.client.reactions.add(
      'like',
      widget.enrichedActivity.id!,
      userId: context.appState.user.id,
    );

    setState(() {
      likeReactions.add(latestLikeReaction!);
      likeCount++;
    });
  }

  Future<void> _removeLikeReaction() async {
    late String? reactionId;

    // A new reaction was added to this state.
    if (latestLikeReaction != null) {
      reactionId = latestLikeReaction?.id;
    } else {
      // An old reaction has been retrieved from Stream.
      final prevReaction = widget.enrichedActivity.ownReactions?['like'];
      if (prevReaction != null && prevReaction.isNotEmpty) {
        reactionId = prevReaction[0].id;
      }
    }

    try {
      if (reactionId != null) {
        await context.appState.client.reactions.delete(reactionId);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setState(() {
      likeReactions.removeWhere((element) => element.id == reactionId);
      likeCount--;
      latestLikeReaction = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._description(context),
      ],
    );
  }

  /// Like/comment bar
  List<Widget> _description(BuildContext context) {
    const iconPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);
    const iconColor = pxpColors.secondaryT;
    return [
      Padding(
        padding: const EdgeInsets.only(
            left: 5.0, right: 5.0, top: 5.0, bottom: 20.0),
        child: Text(
          widget.enrichedActivity.extraData?['description'] as String? ?? '',
          maxLines: null,
          style: const TextStyle(
              color: pxpColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.2),
        ),
      ),
      Row(
        children: [
          Padding(
            padding: iconPadding,
            child: FavoriteIconButton(
              isLiked: widget.enrichedActivity.ownReactions?['like'] != null,
              onTap: (liked) {
                if (liked) {
                  _addLikeReaction();
                } else {
                  _removeLikeReaction();
                }
              },
            ),
          ),
          likeCount > 0
              ? Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Text(
                    likeCount.toString(),
                    style: const TextStyle(
                        color: pxpColors.secondaryT,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2),
                  ))
              : const SizedBox(width: 30),
          Padding(
            padding: iconPadding,
            child: TapFadeIcon(
              onTap: () {
                // ADD THIS
                final map = widget.enrichedActivity.actor!.data!;

                // AND THIS
                Navigator.of(context).push(
                  CommentsScreen.route(
                    enrichedActivity: widget.enrichedActivity,
                    activityOwnerData: StreamagramUser.fromMap(map),
                  ),
                );
              },
              icon: Icons.chat_bubble_outline,
              iconColor: iconColor,
            ),
          ),
          commentCount > 0
              ? Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Text(
                    commentCount.toString(),
                    style: const TextStyle(
                        color: pxpColors.secondaryT,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2),
                  ))
              : const SizedBox(width: 30),
          Padding(
            padding: iconPadding,
            child: TapFadeIcon(
              onTap: () =>
                  context.removeAndShowSnackbar('Message: Not yet implemented'),
              icon: Feather.share,
              iconColor: iconColor,
            ),
          ),
        ],
      ),
    ];
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
    required this.enrichedActivity,
  }) : super(key: key);

  final EnrichedActivity enrichedActivity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
      child: Text(
        // enrichedActivity.extraData?['title'] as String? ?? '',
        "Temporary Title",
        style: const TextStyle(
          color: pxpColors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ProfilePicture extends StatelessWidget {
  const _ProfilePicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final streamagramUser = context.watch<AppState>().streamagramUser;
    if (streamagramUser == null) {
      return const Icon(Icons.error);
    }
    return Avatar.small(
      streamagramUser: streamagramUser,
    );
  }
}

class _ProfileSlab extends StatefulWidget {
  const _ProfileSlab({
    Key? key,
    required this.userData,
    required this.enrichedActivity,
  }) : super(key: key);

  final EnrichedActivity enrichedActivity;
  final StreamagramUser userData;
  @override
  _ProfileSlabState createState() => _ProfileSlabState();
}

class _ProfileSlabState extends State<_ProfileSlab> {
  EnrichedActivity get enrichedActivity => widget.enrichedActivity;

  late final String _timeSinceMessage =
      Jiffy(widget.enrichedActivity.time).fromNow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
      child: Row(
        children: [
          Avatar.medium(streamagramUser: widget.userData),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userData.fullName,
                  style: TextStyle(
                      color: pxpColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2),
                ),
                SizedBox(height: 2),
                Text(
                  _timeSinceMessage,
                  style: const TextStyle(
                    color: AppColors.faded,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // const Spacer(),
          // TapFadeIcon(
          //   onTap: () => context.removeAndShowSnackbar('Not part of the demo'),
          //   icon: Icons.more_horiz,
          //   iconColor: Theme.of(context).iconTheme.color!,
          // ),
        ],
      ),
    );
  }
}
