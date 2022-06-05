import 'dart:async';

import 'localizations.dart';
import 'routes/routes.dart';
import 'user_mentions_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'channel_list.dart';

class ChannelListPage extends StatefulWidget {
  const ChannelListPage({
    Key? key,
  }) : super(key: key);

  @override
  _ChannelListPageState createState() => _ChannelListPageState();
}

class _ChannelListPageState extends State<ChannelListPage> {
  int _currentIndex = 0;

  bool _isSelected(int index) => _currentIndex == index;

  @override
  Widget build(BuildContext context) {
    final user = StreamChat.of(context).currentUser;
    if (user == null) {
      return Offstage();
    }
    return Scaffold(
      backgroundColor: StreamChatTheme.of(context).colorTheme.appBg,
      appBar: StreamChannelListHeader(
        onNewChatButtonTap: () {
          Navigator.pushNamed(context, Routes.NEW_CHAT);
        },
        preNavigationCallback: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
      drawer: LeftDrawer(
        user: user,
      ),
      drawerEdgeDragWidth: 50,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          ChannelList(),
          UserMentionsPage(),
        ],
      ),
    );
  }

  StreamSubscription<int>? badgeListener;

  @override
  void initState() {
    if (!kIsWeb) {
      badgeListener = StreamChat.of(context)
          .client
          .state
          .totalUnreadCountStream
          .listen((count) {
        if (count > 0) {
          FlutterAppBadger.updateBadgeCount(count);
        } else {
          FlutterAppBadger.removeBadge();
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    badgeListener?.cancel();
    super.dispose();
  }
}

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: StreamChatTheme.of(context).colorTheme.barsBg,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top + 8,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20.0,
                    left: 8,
                  ),
                  child: Row(
                    children: [
                      StreamUserAvatar(
                        user: user,
                        showOnlineStatus: false,
                        constraints: BoxConstraints.tight(Size.fromRadius(20)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          user.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: StreamSvgIcon.penWrite(
                    color: StreamChatTheme.of(context)
                        .colorTheme
                        .textHighEmphasis
                        .withOpacity(.5),
                  ),
                  onTap: () {
                    Navigator.popAndPushNamed(
                      context,
                      Routes.NEW_CHAT,
                    );
                  },
                  title: Text(
                    AppLocalizations.of(context).newDirectMessage,
                    style: TextStyle(
                      fontSize: 14.5,
                    ),
                  ),
                ),
                ListTile(
                  leading: StreamSvgIcon.contacts(
                    color: StreamChatTheme.of(context)
                        .colorTheme
                        .textHighEmphasis
                        .withOpacity(.5),
                  ),
                  onTap: () {
                    Navigator.popAndPushNamed(
                      context,
                      Routes.NEW_GROUP_CHAT,
                    );
                  },
                  title: Text(
                    AppLocalizations.of(context).newGroup,
                    style: TextStyle(
                      fontSize: 14.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
