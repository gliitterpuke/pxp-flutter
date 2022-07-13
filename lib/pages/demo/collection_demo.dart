import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/Theme.dart';
import 'package:http/http.dart' as http;

class CollectionDemo extends StatefulWidget {
  const CollectionDemo({Key? key}) : super(key: key);

  @override
  _CollectionDemoState createState() => _CollectionDemoState();
}

final url = 'http://localhost:5000/api/v1/';
final jsonHeaders = {"Content-type": "application/json"};

class _CollectionDemoState extends State<CollectionDemo> {
  Future<void> createCollection() async {
    final collectURL = Uri.parse(url + 'book_collections/');

    final collectBody = json.encode({
      "name": "PxP Picks",
      "description": "Editor curated picks",
      "is_private": true,
      "curator_id": 2
    });

    try {
      // create book collection
      final collect1 =
          await http.post(collectURL, headers: jsonHeaders, body: collectBody);

      final collectBody2 = json.encode({
        "name": "${json.decode(collect1.body)['name']}",
        "description": "${json.decode(collect1.body)['description']}",
        "is_private": "${json.decode(collect1.body)['is_private']}",
        "book_ids": [1]
      });

      final upCollectURL = Uri.parse(
          url + 'book_collections/${json.decode(collect1.body)['id']}');
      await http.put(upCollectURL, headers: jsonHeaders, body: collectBody2);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {}
  }

  @override
  Widget build(BuildContext context) => RawMaterialButton(
        onPressed: () async {
          createCollection();
        },
        fillColor: pxpColors.accent,
        child: const Text('3', style: TextStyle(fontWeight: FontWeight.bold)),
        padding: const EdgeInsets.all(15.0),
        shape: const CircleBorder(),
      );
}
