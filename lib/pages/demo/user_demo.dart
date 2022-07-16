import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pxp_flutter/pages/ig/app/app.dart';

import '../../constants/Theme.dart';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class UserDemo extends StatefulWidget {
  const UserDemo({Key? key}) : super(key: key);

  @override
  _UserDemoState createState() => _UserDemoState();
}

const url = 'http://localhost:5000/api/v1/';
final jsonHeaders = {"Content-type": "application/json"};
final mimeHeaders = {"Content-type": "image/jpeg"};

class _UserDemoState extends State<UserDemo> {
  Future<File> getImageFileFromAssets(String path) async {
    var bytes = await rootBundle.load(path);
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/pfp.jpg');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

    return file;
  }

  Future<void> user() async {
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

      if (resp.statusCode != 200) {
        var error = json.decode(resp.body);
        print(error);
      } else {
        // add default pfp
        final profile = json.decode(resp.body)['profile'];
        final profileURL =
            Uri.parse(url + 'profiles/${json.decode(resp.body)['id']}');
        final profileBody = json.encode({
          "username": profile['username'],
          "display_name": "",
          "bio": "",
          "mature": profile['mature'],
          "notifications": true,
          "payout_acc_id": "",
          "pic_id": 2
        });

        await http.put(profileURL, headers: jsonHeaders, body: profileBody);
        if (resp.statusCode != 200) {
          var error = json.decode(resp.body);
          print(error);
        } else {
          print('Success');
        }
      }
    }
  }

  Future<void> demo() async {
    List<String> emails = [
      "anya@forger.com",
      "loid@forger.com",
      "yor@forger.com",
      "reina@san.com",
      "yuri@briar.com",
      "franky@franklin.com",
    ];

    List<String> usernames = [
      "anya",
      "loid",
      "yor",
      "reina",
      "yuri",
      "franky",
    ];

    List<int> pic = [3, 4, 5, 6, 7, 8];

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

      if (resp.statusCode != 200) {
        var error = json.decode(resp.body);
        print(error);
      } else {
        // add default pfp
        final profile = json.decode(resp.body)['profile'];
        final profileURL =
            Uri.parse(url + 'profiles/${json.decode(resp.body)['id']}');
        print(pic[i]);
        final profileBody = json.encode({
          "username": profile['username'],
          "display_name": profile['username'],
          "bio": "",
          "mature": profile['mature'],
          "notifications": true,
          "payout_acc_id": "",
          "pic_id": pic[i]
        });

        await http.put(profileURL, headers: jsonHeaders, body: profileBody);
        if (resp.statusCode != 200) {
          var error = json.decode(resp.body);
          print(error);
        } else {
          print('Success');
        }
      }
    }
  }

  Future<void> createUser() async {
    try {
      await user();
      await demo();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {}
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
