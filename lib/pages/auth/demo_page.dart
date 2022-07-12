import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pxp_flutter/pages/demo/book_demo.dart';
import 'package:pxp_flutter/pages/demo/user_demo.dart';
import 'package:pxp_flutter/pages/ig/app/app.dart';

import '../../constants/Theme.dart';
import 'package:http/http.dart' as http;

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

final url = 'http://localhost:5000/api/v1/';
final jsonHeaders = {"Content-type": "application/json"};
final mimeHeaders = {"Content-type": "image/jpeg"};

class _DemoState extends State<Demo> {
  Future<void> createCollection() async {
    final collectionURL = Uri.parse(url + 'book_collections/');
    final updateURL = Uri.parse(url + 'book_collections/1');
    final jsonBody = json.encode({
      "name": "Favourite Collection",
      "description": "description",
      "is_private": true,
      "curator_id": 1
    });

    final updateBody = json.encode({
      "name": "string",
      "description": "string",
      "is_private": true,
      "book_ids": [1]
    });

    try {
      final response =
          await http.post(collectionURL, headers: jsonHeaders, body: jsonBody);
      final updateResp =
          await http.put(updateURL, headers: jsonHeaders, body: updateBody);
      if (kDebugMode) {
        print('Status code: ${updateResp.statusCode}');
        print('Body: ${updateResp.body}');
      }

      if (response.statusCode != 200) {
        var error = json.decode(response.body);
        context.removeAndShowSnackbar(error['detail']);
      } else {
        context.removeAndShowSnackbar('Success!');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {}
  }

  Future<void> createChapter() async {
    final collectionURL = Uri.parse(url + 'book_chapters/');
    final updateURL = Uri.parse(url + 'book_collections/1');
    final jsonBody = json.encode({
      "title": "string",
      "part": 1,
      "number": 1,
      "release_date": "2022-07-11T06:48:16.909Z",
      "book_id": 1,
      "content_id": 0
    });

    try {
      final response =
          await http.post(collectionURL, headers: jsonHeaders, body: jsonBody);
      if (kDebugMode) {
        print('Status code: ${response.statusCode}');
        print('Body: ${response.body}');
      }

      if (response.statusCode != 200) {
        var error = json.decode(response.body);
        context.removeAndShowSnackbar(error['detail']);
      } else {
        context.removeAndShowSnackbar('Success!');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {}
  }

  Future<void> createReview() async {
    final reviewURL = Uri.parse(url + 'book_reviews/');
    final jsonBody = json.encode({
      "style": 0,
      "plot": 0,
      "grammar": 0,
      "character": 0,
      "chapter": 0,
      "title": "Truly amazing",
      "text": "phenomenal tell me more"
    });

    try {
      final response =
          await http.post(reviewURL, headers: jsonHeaders, body: jsonBody);
      if (kDebugMode) {
        print('Status code: ${response.statusCode}');
        print('Body: ${response.body}');
      }

      if (response.statusCode != 200) {
        var error = json.decode(response.body);
        context.removeAndShowSnackbar(error['detail']);
      } else {
        context.removeAndShowSnackbar('Success!');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pxpColors.darkBasePrimary,
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
                            "STEPS",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                UserDemo(),
                                SizedBox(height: 10),
                                Text('Create user',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              children: [
                                BookDemo(),
                                SizedBox(height: 10),
                                Text('Create book',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              children: [
                                RawMaterialButton(
                                  onPressed: () async {
                                    createCollection();
                                  },
                                  fillColor: pxpColors.accent,
                                  child: const Text('3',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  padding: const EdgeInsets.all(15.0),
                                  shape: const CircleBorder(),
                                ),
                                SizedBox(height: 10),
                                Text('Create collection',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                RawMaterialButton(
                                  onPressed: () async {
                                    createChapter();
                                  },
                                  fillColor: pxpColors.accent,
                                  child: const Text('1',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  padding: const EdgeInsets.all(15.0),
                                  shape: const CircleBorder(),
                                ),
                                SizedBox(height: 10),
                                Text('Create chapter',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              children: [
                                RawMaterialButton(
                                  onPressed: () async {},
                                  fillColor: pxpColors.accent,
                                  child: const Text('1',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  padding: const EdgeInsets.all(15.0),
                                  shape: const CircleBorder(),
                                ),
                                SizedBox(height: 10),
                                Text('Create review',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              children: [
                                RawMaterialButton(
                                  onPressed: () async {
                                    createCollection();
                                  },
                                  fillColor: pxpColors.accent,
                                  child: const Text('3',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  padding: const EdgeInsets.all(15.0),
                                  shape: const CircleBorder(),
                                ),
                                SizedBox(height: 10),
                                Text('Create collection',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
