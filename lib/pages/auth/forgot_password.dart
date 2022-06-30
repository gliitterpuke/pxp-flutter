import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:pxp_flutter/pages/auth/login.dart';
import 'package:pxp_flutter/pages/ig/app/app.dart';

import 'package:pxp_flutter/pages/auth/register.dart';
import 'package:pxp_flutter/pages/root_app.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
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
                              "FORGOT YOUR PASSWORD?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "We'll email you instructions on how to reset it",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFBFBFBF),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 4.0, bottom: 4.0, left: 15.0, right: 15.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF212124),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              style: const TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Your email address",
                                  hintStyle: TextStyle(
                                      color: Colors.grey[400], fontSize: 14)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () async {
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
                              "REQUEST RESET LINK",
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
                                builder: (context) => Login()));
                          },
                          child: const Text("Back to Login",
                              style: TextStyle(
                                color: Color.fromRGBO(143, 148, 251, 1),
                              ))),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
