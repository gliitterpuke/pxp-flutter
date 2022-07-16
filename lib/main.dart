import 'dart:async';

import 'package:flutter_config/flutter_config.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get_storage/get_storage.dart';

import 'package:pxp_flutter/pages/chat/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pxp_flutter/pages/ig/app/app.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stream_chat_localizations/stream_chat_localizations.dart';

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
      WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
      await FlutterConfig.loadEnvVariables();
      await GetStorage.init();
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
  final theme = AppTheme();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      supportedLocales: [
        Locale('en'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
      home: StreamagramApp(appTheme: theme),
    );
  }
}
