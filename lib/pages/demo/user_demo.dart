import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pxp_flutter/pages/ig/app/app.dart';

import '../../constants/Theme.dart';
import 'package:http/http.dart' as http;

class UserDemo extends StatefulWidget {
  const UserDemo({Key? key}) : super(key: key);

  @override
  _UserDemoState createState() => _UserDemoState();
}

final url = 'http://localhost:5000/api/v1/';
final jsonHeaders = {"Content-type": "application/json"};
final mimeHeaders = {"Content-type": "image/jpeg"};

class _UserDemoState extends State<UserDemo> {
  Future<void> createUser() async {
    void user() async {
      List<String> emails = [
        "demo@demo.com",
        "kat@pxp.fan",
        "leon@pxp.fan",
        "contact@pxp.fan",
        "keigo@higashino.com",
        "lee@minjin.com",
        "colleen@hoover.com",
        "agatha@christie.com",
        "cs@lewis.com",
      ];

      List<String> usernames = [
        "demo",
        "glitterpuke",
        "llyx",
        "teampxp",
        "higashino",
        "lminjin",
        "choover",
        "achristie",
        "cslewis"
      ];

      for (int i = 0; i < emails.length; i++) {
        final userURL = Uri.parse(url + 'users/');
        final userBody = json.encode({
          "email": emails[i],
          "password": "testing123",
          "is_creator": true,
          "username": usernames[i],
        });
        final resp =
            await http.post(userURL, headers: jsonHeaders, body: userBody);
        print(resp.body);
        if (resp.statusCode != 200) {
          var error = json.decode(resp.body);
          context.removeAndShowSnackbar(error['detail']);
        }
      }
    }

    try {
      user();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      context.removeAndShowSnackbar('Success!');
    }
  }

  @override
  Widget build(BuildContext context) => RawMaterialButton(
        onPressed: () async {
          createUser();
        },
        fillColor: pxpColors.accent,
        child: const Text('1', style: TextStyle(fontWeight: FontWeight.bold)),
        padding: const EdgeInsets.all(15.0),
        shape: const CircleBorder(),
      );
}
