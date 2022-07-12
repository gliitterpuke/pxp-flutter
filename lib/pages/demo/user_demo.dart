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
    final userURL = Uri.parse(url + 'users/');
    final jsonBody = json.encode({
      "email": "demo@demo.com",
      "password": "testing123",
      "is_creator": true,
      "username": "demo"
    });

    try {
      final response =
          await http.post(userURL, headers: jsonHeaders, body: jsonBody);
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
