import 'dart:async';

import 'package:pxp_flutter/pages/chat/app_config.dart';
import 'package:pxp_flutter/pages/chat/localizations.dart';
import 'package:pxp_flutter/pages/chat/routes/app_routes.dart';

import 'package:pxp_flutter/pages/chat/choose_user_page.dart';
import 'package:pxp_flutter/pages/chat/home_page.dart';
import 'package:pxp_flutter/pages/chat/localizations.dart';
import 'package:pxp_flutter/pages/chat/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pxp_flutter/pages/onboarding.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_localizations/stream_chat_localizations.dart';
import 'package:stream_chat_persistence/stream_chat_persistence.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'package:pxp_flutter/pages/chat/routes/app_routes.dart';
import 'package:pxp_flutter/pages/chat/routes/routes.dart';

final chatPersistentClient = StreamChatPersistenceClient(
  logLevel: Level.SEVERE,
  connectionMode: ConnectionMode.regular,
);

void sampleAppLogHandler(LogRecord record) async {
  if (kDebugMode) StreamChatClient.defaultLogHandler(record);

  if (record.error != null || record.stackTrace != null) {
    await Sentry.captureException(
      record.error,
      stackTrace: record.stackTrace,
    );
  }
}

StreamChatClient buildStreamChatClient(
  String apiKey, {
  Level logLevel = Level.SEVERE,
}) {
  return StreamChatClient(
    apiKey,
    logLevel: logLevel,
    logHandlerFunction: sampleAppLogHandler,
  )..chatPersistenceClient = chatPersistentClient;
}

void main() async {
  const sentryDsn =
      'https://6381ef88de4140db8f5e25ab37e0f08c@o1213503.ingest.sentry.io/6352870';

  FlutterError.onError = (FlutterErrorDetails details) {
    if (kDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    }
  };

  Future<void> _reportError(dynamic error, StackTrace stackTrace) async {
    if (kDebugMode) {
      print(stackTrace);
      return;
    } else {
      await Sentry.captureException(error, stackTrace: stackTrace);
    }
  }

  runZonedGuarded(
    () async {
      await SentryFlutter.init(
        (options) => options.dsn = sentryDsn,
      );
      runApp(MyApp());
    },
    _reportError,
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with SplashScreenStateMixin, TickerProviderStateMixin {
  InitData? _initData;

  Future<InitData> _initConnection() async {
    String? apiKey, userId, token;

    if (!kIsWeb) {
      final secureStorage = FlutterSecureStorage();
      secureStorage.write(
        key: kStreamApiKey,
        value: kDefaultStreamApiKey,
      );
      secureStorage.write(
        key: kStreamUserId,
        value: defaultUsers.entries.toList()[0].value.id,
      );
      secureStorage.write(
        key: kStreamToken,
        value: defaultUsers.entries.toList()[0].key,
      );
    }
    print(kStreamUserId);

    final client = buildStreamChatClient(apiKey ?? kStreamApiKey);

    if (userId != null && token != null) {
      await client.connectUser(
        defaultUsers.entries.toList()[0].value,
        defaultUsers.entries.toList()[0].key,
      );
    }

    final prefs = await StreamingSharedPreferences.instance;

    return InitData(client, prefs);
  }

  @override
  void initState() {
    final timeOfStartMs = DateTime.now().millisecondsSinceEpoch;

    _initConnection().then(
      (initData) {
        setState(() {
          _initData = initData;
        });

        final now = DateTime.now().millisecondsSinceEpoch;

        if (now - timeOfStartMs > 1500) {
          SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
            forwardAnimations();
          });
        } else {
          Future.delayed(Duration(milliseconds: 1500)).then((value) {
            forwardAnimations();
          });
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (_initData != null)
          PreferenceBuilder<int>(
            preference: _initData!.preferences.getInt(
              'theme',
              defaultValue: 0,
            ),
            builder: (context, snapshot) => MaterialApp(
                debugShowCheckedModeBanner: false,
                builder: (context, child) => StreamChatTheme(
                      data: StreamChatThemeData(
                        brightness: Theme.of(context).brightness,
                      ),
                      child: child!,
                    ),
                theme: ThemeData.dark(),
                home: Onboarding()),
          ),
        if (!animationCompleted) buildAnimation(),
      ],
    );
  }
}

class InitData {
  final StreamChatClient client;
  final StreamingSharedPreferences preferences;

  InitData(this.client, this.preferences);
}
