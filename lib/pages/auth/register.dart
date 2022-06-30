// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:pxp_flutter/pages/auth/login.dart';
import 'package:pxp_flutter/pages/root_app.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                      // Expanded(
                      //     child: Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Divider(color: Colors.white, thickness: 2),
                      // )),
                      // ]),
                      SizedBox(height: 40),
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RawMaterialButton(
                              onPressed: () {},
                              fillColor: Color(0xFF4267B2),
                              child: Icon(FontAwesome.facebook,
                                  size: 16.0, color: Colors.white),
                              padding: EdgeInsets.all(15.0),
                              shape: CircleBorder(),
                            ),
                            RawMaterialButton(
                              onPressed: () {},
                              fillColor: Color(0xFF1DA1F2),
                              child: Icon(Feather.twitter,
                                  size: 16.0, color: Colors.white),
                              padding: EdgeInsets.all(15.0),
                              shape: CircleBorder(),
                            ),
                            RawMaterialButton(
                              onPressed: () {},
                              fillColor: Color(0xFFDB4437),
                              child: Icon(AntDesign.google,
                                  size: 16.0, color: Colors.white),
                              padding: EdgeInsets.all(15.0),
                              shape: CircleBorder(),
                            ),
                            RawMaterialButton(
                              onPressed: () {},
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
                        child: TextField(
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Username",
                              hintStyle: TextStyle(
                                  color: Colors.grey[400], fontSize: 14)),
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
                        child: TextField(
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              hintStyle: TextStyle(
                                  color: Colors.grey[400], fontSize: 14)),
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
                        child: TextField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  color: Colors.grey[400], fontSize: 14)),
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
                        child: TextField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(
                                  color: Colors.grey[400], fontSize: 14)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => RootApp()));
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
                              color: Colors.white, fontWeight: FontWeight.bold),
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
        ));
  }
}
