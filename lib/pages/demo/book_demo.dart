import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/Theme.dart';
import 'package:http/http.dart' as http;

class BookDemo extends StatefulWidget {
  const BookDemo({Key? key}) : super(key: key);

  @override
  _BookDemoState createState() => _BookDemoState();
}

final url = 'http://localhost:5000/api/v1/';
final jsonHeaders = {"Content-type": "application/json"};
final mimeHeaders = {"Content-type": "image/jpeg"};

class _BookDemoState extends State<BookDemo> {
  Future<void> createBook() async {
    final langURL = Uri.parse(url + 'languages/');
    final tagURL = Uri.parse(url + 'tags/');
    final blobURL = Uri.parse(url + 'blobs/');
    final bookURL = Uri.parse(url + 'books/');

    final _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 70,
    );
    final s3get =
        Uri.parse(url + 'sign-s3-get?bucket=pxp-demo2&key=username.jpeg');
    final s3post = Uri.parse(
        url + 'sign-s3-post?key=username.jpeg&mime_type=image%2Fjpeg');
    final langBody = json.encode({
      "code": "eng",
      "name": "English",
    });
    final tagBody = json.encode(
        {"category": "genre", "name": "Sci-fi", "description": "string"});
    final tagBody2 = json.encode(
        {"category": "plot", "name": "Thriller", "description": "string"});
    final tagBody3 = json.encode({
      "category": "character",
      "name": "Something",
      "description": "string"
    });

    final bookBody = json.encode({
      "title": "Under the Midnight Sun",
      "series": "Under the Midnight Sun",
      "number": "1",
      "summary":
          "When a man is found murdered in an abandoned building in Osaka in 1973, unflappable detective Sasagaki is assigned to the case. He begins to piece together the connection of two young people who are inextricably linked to the crime; the dark, taciturn son of the victim and the unexpectedly captivating daughter of the main suspect. Over the next twenty years we follow their lives as Sasagaki pursues the case - which remains unsolved - to the point of obsession.",
      "completed": true,
      "mature": true,
      "author_id": 1,
      "cover_id": 1,
      "language_id": 1,
      "tag_ids": [1],
    });

    try {
      // create language, tags
      await http.post(langURL, headers: jsonHeaders, body: langBody);
      await http.post(tagURL, headers: jsonHeaders, body: tagBody);
      await http.post(tagURL, headers: jsonHeaders, body: tagBody2);
      await http.post(tagURL, headers: jsonHeaders, body: tagBody3);

      // upload book cover
      final s3 = await http.get(s3post, headers: jsonHeaders);

      final blobBody = json.encode({
        "filename": pickedFile!.name,
        "mime_type": "image/jpeg",
        "bucket": "pxp-demo2",
        "tag": "string",
        "url": "${json.decode(s3.body)['data']['url']}"
      });

      Map<String, String> requestBody = <String, String>{
        'key': "${json.decode(s3.body)['data']['fields']['key']}",
        'policy': "${json.decode(s3.body)['data']['fields']['policy']}",
        'Content-Type':
            "${json.decode(s3.body)['data']['fields']['Content-Type']}",
        'x-amz-signature':
            "${json.decode(s3.body)['data']['fields']['x-amz-signature']}",
        'x-amz-algorithm':
            "${json.decode(s3.body)['data']['fields']['x-amz-algorithm']}",
        'x-amz-credential':
            "${json.decode(s3.body)['data']['fields']['x-amz-credential']}",
        'x-amz-date': "${json.decode(s3.body)['data']['fields']['x-amz-date']}",
      };
      var stream = http.ByteStream(pickedFile.openRead());
      stream.cast();
      var length = await pickedFile.length();
      var request = http.MultipartRequest(
          "POST", Uri.parse("${json.decode(s3.body)['data']['url']}"));
      var multipartFile =
          http.MultipartFile('file', stream, length, filename: pickedFile.path);
      request.fields.addAll(requestBody);
      request.files.add(multipartFile);
      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {});

      await http.post(blobURL, headers: jsonHeaders, body: blobBody);

      //create book
      await http.post(bookURL, headers: jsonHeaders, body: bookBody);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {}
  }

  @override
  Widget build(BuildContext context) => RawMaterialButton(
        onPressed: () async {
          createBook();
        },
        fillColor: pxpColors.accent,
        child: const Text('2', style: TextStyle(fontWeight: FontWeight.bold)),
        padding: const EdgeInsets.all(15.0),
        shape: const CircleBorder(),
      );
}
