import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pxp_flutter/pages/home.dart';
import 'package:pxp_flutter/pages/register.dart';

class Onboarding extends StatelessWidget {
  final icon = Feather.settings;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            SafeArea(
              child: Container(
                padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: MediaQuery.of(context).size.height * 0.4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Container(
                        child: Center(
                            child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: const FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                    "You want it. We got it." +
                                        '\n' +
                                        "Stories of tomorrow, today.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24)))),
                      ],
                    ))),
                    Column(
                      children: [
                        // SizedBox(height: 100),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 45.0, bottom: 10.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Register()));
                              },
                              child: const Text("SIGN UP FREE",
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              primary: Colors.white,
                              side: BorderSide(
                                  color: Color.fromARGB(255, 193, 193, 193)),
                            ),
                            onPressed: () {},
                            child: const Text("LOG IN",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1)),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: SafeArea(
                child: Image.asset("assets/images/pxplogo.png", height: 100),
              ),
            ),
          ],
        ));
  }
}
