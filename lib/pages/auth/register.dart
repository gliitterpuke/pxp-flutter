// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pxp_flutter/pages/auth/login.dart';
import 'package:pxp_flutter/pages/ig/app/app.dart';
import 'package:pxp_flutter/pages/root_app.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:stream_feed_flutter_core/stream_feed_flutter_core.dart';

import 'package:twitter_login/twitter_login.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormBuilderState>();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  GoogleSignInAccount? _currentUser;
  final String _contactText = '';
  final url = 'http://localhost:5000/api/v1/';

  Future<void> createUser(Map<String, dynamic> value) async {
    final jsonHeaders = {"Content-type": "application/json"};
    final newValue = {...value, 'is_creator': true};
    var jsonBody = jsonEncode(newValue);

    try {
      final box = GetStorage();
      final response = await http.post(Uri.parse(url + 'users/'),
          headers: jsonHeaders, body: jsonBody);
      if (kDebugMode) {
        print('Status code: ${response.statusCode}');
        print('Body: ${response.body}');
      }

      if (response.statusCode != 200) {
        var error = json.decode(response.body);
        context.removeAndShowSnackbar(error['detail']);
      } else {
        // add default pfp
        final profile = json.decode(response.body)['profile'];
        final profileURL =
            Uri.parse(url + 'profiles/${json.decode(response.body)['id']}');
        final profileBody = json.encode({
          "username": profile['username'],
          "display_name": "",
          "bio": "",
          "mature": profile['mature'],
          "notifications": true,
          "payout_acc_id": "",
          "pic_id": 2
        });

        final pfpResp =
            await http.put(profileURL, headers: jsonHeaders, body: profileBody);
        if (pfpResp.statusCode != 200) {
          var error = json.decode(pfpResp.body);
          print(error);
        } else {
          print('Successful PFP upload');
        }

        final headers = {
          "Content-type": "application/x-www-form-urlencoded; charset=UTF-8"
        };
        var formData =
            'username=${Uri.encodeQueryComponent(value['email'])}&password=${Uri.encodeQueryComponent(value['password'])}';
        try {
          final response = await http.post(Uri.parse(url + 'auth/token'),
              headers: headers, body: formData);
          if (response.statusCode != 200) {
            var error = json.decode(response.body);
            context.removeAndShowSnackbar(error['detail']);
          } else {
            print('Successful login');

            // save access token
            await box.write(
                'access_token', json.decode(response.body)['access_token']);
            await box.write('stream_feed_token',
                json.decode(response.body)['stream_feed_token']);

            // call user
            final authurl = Uri.parse('http://localhost:5000/api/v1/users/me/');
            final authHeader = {
              'Content-Type': 'application/json',
              'Authorization':
                  'Bearer ${json.decode(response.body)['access_token']}',
            };

            // save user to storage
            final secureUser = await http.get(authurl, headers: authHeader);
            await box.write('user', json.decode(secureUser.body));
            final user = await box.read('user');

            // save default profile pic
            final a = Uri.parse(user['profile']['pic']['url']);
            final pfpImg = await http.get(Uri.parse(
                'http://localhost:5000/api/v1/sign-s3-get?bucket=pxp-demo2&key=${a.pathSegments.last}'));

            await box.write('pfp', pfpImg.body);
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
        } finally {
          final user = await box.read('user');
          final token = await box.read('stream_feed_token');
          await context.appState.client.setUser(
            User(id: user['profile']['username']),
            Token(token),
          );

          if (context.appState.client.currentUser!.id.isNotEmpty) {
            await Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const RootApp(),
              ),
            );
          } else {
            context.removeAndShowSnackbar(response.body);
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                            "SIGN UP WITH",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 40),
                        FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RawMaterialButton(
                                onPressed: () async {
                                  final LoginResult result =
                                      await FacebookAuth.i.login();
                                  if (result.status == LoginStatus.success) {
                                    final AccessToken accessToken =
                                        result.accessToken!;
                                  } else {
                                    print(result.status);
                                    print(result.message);
                                  }
                                },
                                fillColor: Color(0xFF4267B2),
                                child: Icon(FontAwesome.facebook,
                                    size: 16.0, color: Colors.white),
                                padding: EdgeInsets.all(15.0),
                                shape: CircleBorder(),
                              ),
                              RawMaterialButton(
                                onPressed: () async {
                                  final twitterLogin = TwitterLogin(
                                    apiKey: FlutterConfig.get('TWITTER_API'),
                                    apiSecretKey:
                                        FlutterConfig.get('TWITTER_SECRET'),
                                    redirectURI: 'scheme://',
                                  );
                                  final authResult = await twitterLogin.login();
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
                                    if (kDebugMode) {
                                      print(error);
                                    }
                                  }
                                },
                                fillColor: Color(0xFFDB4437),
                                child: Icon(AntDesign.google,
                                    size: 16.0, color: Colors.white),
                                padding: EdgeInsets.all(15.0),
                                shape: CircleBorder(),
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

                                  if (kDebugMode) {
                                    print(credential);
                                  }
                                },
                                fillColor: Color(0xFF555555),
                                child: Icon(AntDesign.apple1,
                                    size: 16.0, color: Colors.white),
                                padding: EdgeInsets.all(15.0),
                                shape: CircleBorder(),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        Row(children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Divider(
                                color: Color(0xFFBFBFBF), thickness: 1.25),
                          )),
                          Center(
                            child: Text(
                              "OR",
                              style: TextStyle(
                                  color: Color(0xFFBFBFBF),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Divider(
                                color: Color(0xFFBFBFBF), thickness: 1.25),
                          )),
                        ]),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.only(
                              top: 4.0, bottom: 4.0, left: 15.0, right: 15.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF212124),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: FormBuilderTextField(
                              name: 'username',
                              initialValue: 'demo',
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Username",
                                  hintStyle: TextStyle(
                                      color: Colors.grey[400], fontSize: 14)),
                              validator: FormBuilderValidators.required()),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.only(
                              top: 4.0, bottom: 4.0, left: 15.0, right: 15.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF212124),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: FormBuilderTextField(
                            name: 'email',
                            initialValue: 'demo@demo.com',
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    color: Colors.grey[400], fontSize: 14)),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.email(),
                              FormBuilderValidators.required()
                            ]),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.only(
                              top: 4.0, bottom: 4.0, left: 15.0, right: 15.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF212124),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: FormBuilderTextField(
                            name: 'password',
                            initialValue: 'testing123',
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    color: Colors.grey[400], fontSize: 14)),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.match(
                                  r"(?=.*?[0-9]).{8,}$"),
                              FormBuilderValidators.required()
                            ]),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.only(
                              top: 4.0, bottom: 4.0, left: 15.0, right: 15.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF212124),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: FormBuilderTextField(
                            name: 'confirm',
                            initialValue: 'testing123',
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(
                                    color: Colors.grey[400], fontSize: 14)),
                            validator: (val) {
                              if (_formKey.currentState?.fields['password']
                                      ?.value !=
                                  val) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () async {
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {
                          createUser(_formKey.currentState!.value);
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(143, 148, 251, 1),
                              Color.fromRGBO(143, 148, 251, .6),
                            ])),
                        child: Center(
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text("Already have an account?",
                            style: TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1),
                            ))),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
