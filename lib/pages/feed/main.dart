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
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _client = context.client;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login with a User',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 42),
              for (final user in appUsers)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Loading User'),
                        ),
                      );
                      final streamUser = await _client.setUser(
                        User(
                          id: 'yo',
                          data: appUsers[0].data,
                        ),
                        Token(
                            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoieW8ifQ.hvUQ9d21EaGe8ONVsALu-aqLUWJBs9W7Owk8JTThp8Y'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('User Loaded'),
                        ),
                      );
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => HomeScreen(
                            currentUser: streamUser,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 36, horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.blue,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).colorScheme.onSurface,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
