import 'home_page.dart';
import 'localizations.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_localizations/stream_chat_localizations.dart';

import 'routes/app_routes.dart';
import 'routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.client}) : super(key: key);
  final StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.dark,
          supportedLocales: const [
            Locale('en'),
          ],
          localizationsDelegates: const [
            AppLocalizationsDelegate(),
            GlobalStreamChatLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          builder: (context, child) => StreamChatTheme(
            data: StreamChatThemeData(
              brightness: Theme.of(context).brightness,
            ),
            child: child!,
          ),
          onGenerateRoute: AppRoutes.generateRoute,
          onGenerateInitialRoutes: (initialRouteName) {
            return [
              AppRoutes.generateRoute(
                RouteSettings(
                  name: Routes.HOME,
                  arguments: HomePageArgs(client),
                ),
              )!
            ];
          },
          initialRoute: Routes.HOME,
        ),
      ],
    );
  }
}
