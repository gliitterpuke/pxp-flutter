import 'package:flutter/material.dart';
import 'package:stream_feed/stream_feed.dart';
import 'package:pxp_flutter/pages/feed/app_user.dart';
import 'package:pxp_flutter/pages/feed/client_provider.dart';
import 'package:pxp_flutter/pages/feed/extension.dart';
import 'package:pxp_flutter/pages/feed/home.dart';

//ignore_for_file: public_member_api_docs

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final client = StreamFeedClient('rzxdu6bj5yaa');

  runApp(
    FeedApp(
      client: client,
    ),
  );
}

class FeedApp extends StatelessWidget {
  const FeedApp({
    required this.client,
    Key? key,
  }) : super(key: key);

  // ignore: diagnostic_describe_all_properties
  final StreamFeedClient client;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Feed Demo',
      home: const LoginScreen(),
      builder: (context, child) => ClientProvider(
        client: client,
        child: child!,
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  InitData? _initData;

  Future<InitData> _initConnection() async {
    final client = StreamFeedClient('rzxdu6bj5yaa');

    final streamUser = await client.setUser(
      User(
        id: 'yo',
        data: appUsers[0].data,
      ),
      Token(
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoieW8ifQ.hvUQ9d21EaGe8ONVsALu-aqLUWJBs9W7Owk8JTThp8Y'),
    );
    return InitData(client, streamUser);
  }

  @override
  void initState() {
    _initConnection().then(
      (initData) {
        setState(() {
          _initData = initData;
        });
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen(currentUser: _initData!.streamUser);
  }
}

class InitData {
  final StreamFeedClient client;
  final StreamUser streamUser;

  InitData(this.client, this.streamUser);
}
