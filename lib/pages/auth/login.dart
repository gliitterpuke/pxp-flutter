import 'dart:async';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pxp_flutter/pages/auth/forgot_password.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pxp_flutter/pages/chat/app_config.dart';
import 'package:pxp_flutter/pages/chat/choose_user_page.dart';
import 'package:pxp_flutter/pages/ig/app/app.dart';

import 'package:pxp_flutter/pages/auth/register.dart';
import 'package:pxp_flutter/pages/root_app.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_persistence/stream_chat_persistence.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:twitter_login/twitter_login.dart';

import 'new_password.dart';

final chatPersistentClient = StreamChatPersistenceClient(
  logLevel: Level.SEVERE,
  connectionMode: ConnectionMode.regular,
);

void sampleAppLogHandler(LogRecord record) async {
  if (kDebugMode) StreamChatClient.defaultLogHandler(record);

  // report errors to sentry
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

  /// Captures errors reported by the Flutter framework.
  FlutterError.onError = (FlutterErrorDetails details) {
    if (kDebugMode) {
      // In development mode, simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode, report to the application zone to report to sentry.
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    }
  };

  Future<void> _reportError(dynamic error, StackTrace stackTrace) async {
    // Print the exception to the console.
    if (kDebugMode) {
      // Print the full stacktrace in debug mode.
      print(stackTrace);
      return;
    } else {
      // Send the Exception and Stacktrace to sentry in Production mode.
      await Sentry.captureException(error, stackTrace: stackTrace);
    }
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormBuilderState>();
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  InitData? _initData;

  Future<InitData> _initConnection() async {
    String? apiKey, userId, token;

    if (!kIsWeb) {
      final secureStorage = FlutterSecureStorage();
      apiKey = await secureStorage.read(key: kStreamApiKey);
      userId = await secureStorage.read(key: kStreamUserId);
      token = await secureStorage.read(key: kStreamToken);
    }

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

  // @override
  // void initState() {
  //   final timeOfStartMs = DateTime.now().millisecondsSinceEpoch;

  //   _initConnection().then(
  //     (initData) {
  //       setState(() {
  //         _initData = initData;
  //       });

  //       final now = DateTime.now().millisecondsSinceEpoch;
  //     },
  //   );

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            const Center(
                              child: Text(
                                "LOG IN WITH",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 40),
                            FittedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RawMaterialButton(
                                    onPressed: () async {
                                      final LoginResult result =
                                          await FacebookAuth.i.login();
                                      if (result.status ==
                                          LoginStatus.success) {
                                        final AccessToken accessToken =
                                            result.accessToken!;
                                      } else {
                                        print(result.status);
                                        print(result.message);
                                      }
                                    },
                                    fillColor: const Color(0xFF4267B2),
                                    child: const Icon(FontAwesome.facebook,
                                        size: 16.0, color: Colors.white),
                                    padding: const EdgeInsets.all(15.0),
                                    shape: const CircleBorder(),
                                  ),
                                  RawMaterialButton(
                                    onPressed: () async {
                                      final twitterLogin = TwitterLogin(
                                        apiKey:
                                            FlutterConfig.get('TWITTER_API'),
                                        apiSecretKey:
                                            FlutterConfig.get('TWITTER_SECRET'),
                                        redirectURI: 'scheme://',
                                      );
                                      final authResult =
                                          await twitterLogin.login();
                                      switch (authResult.status) {
                                        case TwitterLoginStatus.loggedIn:
                                          break;
                                        case TwitterLoginStatus.cancelledByUser:
                                          break;
                                        case TwitterLoginStatus.error:
                                          break;
                                        case null:
                                          break;
                                      }
                                    },
                                    fillColor: const Color(0xFF1DA1F2),
                                    child: const Icon(Feather.twitter,
                                        size: 16.0, color: Colors.white),
                                    padding: const EdgeInsets.all(15.0),
                                    shape: const CircleBorder(),
                                  ),
                                  RawMaterialButton(
                                    onPressed: () async {
                                      try {
                                        await _googleSignIn.signIn();
                                      } catch (error) {
                                        print(error);
                                      }
                                    },
                                    fillColor: const Color(0xFFDB4437),
                                    child: const Icon(AntDesign.google,
                                        size: 16.0, color: Colors.white),
                                    padding: const EdgeInsets.all(15.0),
                                    shape: const CircleBorder(),
                                  ),
                                  RawMaterialButton(
                                    onPressed: () async {
                                      final credential = await SignInWithApple
                                          .getAppleIDCredential(
                                        scopes: [
                                          AppleIDAuthorizationScopes.email,
                                          AppleIDAuthorizationScopes.fullName,
                                        ],
                                      );

                                      print(credential);
                                    },
                                    fillColor: const Color(0xFF555555),
                                    child: const Icon(AntDesign.apple1,
                                        size: 16.0, color: Colors.white),
                                    padding: const EdgeInsets.all(15.0),
                                    shape: const CircleBorder(),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            Row(children: [
                              Expanded(
                                  child: const Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Divider(
                                    color: Color(0xFFBFBFBF), thickness: 1.25),
                              )),
                              const Center(
                                child: Text(
                                  "OR",
                                  style: TextStyle(
                                      color: Color(0xFFBFBFBF),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                  child: const Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Divider(
                                    color: Color(0xFFBFBFBF), thickness: 1.25),
                              )),
                            ]),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 4.0,
                                  bottom: 4.0,
                                  left: 15.0,
                                  right: 15.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFF212124),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: FormBuilderTextField(
                                name: 'email',
                                style: const TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[400], fontSize: 14)),
                                initialValue: 'demo@demo.com',
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.email(),
                                  FormBuilderValidators.required()
                                ]),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 4.0,
                                  bottom: 4.0,
                                  left: 15.0,
                                  right: 15.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFF212124),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: FormBuilderTextField(
                                name: 'password',
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                style: const TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[400], fontSize: 14)),
                                initialValue: "testing123",
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.match(
                                      r"(?=.*?[0-9]).{8,}$"),
                                  FormBuilderValidators.required()
                                ]),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () async {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                              print(_formKey.currentState!.value);

                              final success = await context.appState
                                  .connect(DemoAppUser.sacha);

                              if (success) {
                                _initConnection().then((value) async =>
                                    await Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                            builder: (context) => RootApp(),
                                            settings: RouteSettings(
                                              arguments: value!.client,
                                            ))));
                              } else {
                                context.removeAndShowSnackbar(
                                    'Could not connect user');
                              }
                            } else {
                              print("validation failed");
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(colors: [
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, .6),
                                ])),
                            child: const Center(
                              child: Text(
                                "LOG IN",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NewPassword()));
                            },
                            child: const Text("Forgot your password?",
                                style: TextStyle(
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                ))),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Register()));
                            },
                            child: const Text("Create an account",
                                style: TextStyle(
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                ))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class InitData {
  final StreamChatClient client;
  final StreamingSharedPreferences preferences;

  InitData(this.client, this.preferences);
}
