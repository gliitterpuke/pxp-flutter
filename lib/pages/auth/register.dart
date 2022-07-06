// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pxp_flutter/pages/auth/login.dart';
import 'package:pxp_flutter/pages/ig/app/app.dart';
import 'package:pxp_flutter/pages/root_app.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/twitter_login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormBuilderState>();

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  GoogleSignInAccount? _currentUser;
  String _contactText = '';

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
                                    print(error);
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

                                  print(credential);
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
                            name: 'pw',
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
                              if (_formKey.currentState?.fields['pw']?.value !=
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
                          print(_formKey.currentState!.value);

                          final success =
                              await context.appState.connect(DemoAppUser.sacha);

                          if (success) {
                            await Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const RootApp(),
                              ),
                            );
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
