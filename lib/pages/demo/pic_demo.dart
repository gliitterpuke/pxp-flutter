import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pxp_flutter/pages/demo/book_demo.dart';

import '../../constants/Theme.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:pxp_flutter/pages/ig/app/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pxp_flutter/pages/auth/demo_page.dart';
import 'package:pxp_flutter/pages/auth/forgot_password.dart';
import 'package:pxp_flutter/pages/chat/app_config.dart';
import 'package:pxp_flutter/pages/chat/choose_user_page.dart';
import 'package:pxp_flutter/pages/ig/app/app.dart';

import 'package:pxp_flutter/pages/auth/register.dart';
import 'package:pxp_flutter/pages/root_app.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as sc;
import 'package:stream_chat_persistence/stream_chat_persistence.dart';
import 'package:stream_feed_flutter_core/stream_feed_flutter_core.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:twitter_login/twitter_login.dart';

class PicDemo extends StatefulWidget {
  const PicDemo({Key? key}) : super(key: key);

  @override
  _PicDemoState createState() => _PicDemoState();
}

const url = 'http://localhost:5000/api/v1/';
final jsonHeaders = {"Content-type": "application/json"};
final mimeHeaders = {"Content-type": "image/jpeg"};

Future<void> create() async {
  List<String> defaultPfp = [
    'assets/images/pusheen.jpg',
    'assets/images/pusheen2.jpg',
  ];

  for (int i = 0; i < defaultPfp.length; i++) {
    final blobURL = Uri.parse(url + 'blobs/');
    final s3post = Uri.parse(url +
        'sign-s3-post?bucket=pxp-demo2&key=pfp$i.jpeg&mime_type=image%2Fjpeg');
    final s3 = await http.get(s3post, headers: jsonHeaders);

    Map<String, String> reqBody = <String, String>{
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
    var coverImg = await getImageFileFromAssets(defaultPfp[i]);

    var coverReq = http.MultipartRequest(
        "POST", Uri.parse("${json.decode(s3.body)['data']['url']}"));
    coverReq.fields.addAll(reqBody);
    coverReq.files.add(http.MultipartFile.fromBytes(
        'file', await File.fromUri(Uri.parse(coverImg.path)).readAsBytes()));
    await coverReq.send();

    final pfpBlob = json.encode({
      "filename": basename(defaultPfp[i]),
      "mime_type": "image/jpeg",
      "bucket": "pxp-demo2",
      "tag": "string",
      "url": "${json.decode(s3.body)['data']['url']}pfp$i.jpeg"
    });

    await http.post(blobURL, headers: jsonHeaders, body: pfpBlob);
  }
}

Future<void> demoPfp() async {
  List<String> pfp = [
    'assets/images/anya.jpg',
    'assets/images/loid.jpg',
    'assets/images/drunkyor.jpg',
    'assets/images/san.jpg',
    'assets/images/yuri.jpg',
    'assets/images/franky.jpg'
  ];

  for (int i = 0; i < pfp.length; i++) {
    final blobURL = Uri.parse(url + 'blobs/');
    final s3post = Uri.parse(url +
        'sign-s3-post?bucket=pxp-demo2&key=demopfp$i.jpeg&mime_type=image%2Fjpeg');
    final s3 = await http.get(s3post, headers: jsonHeaders);

    Map<String, String> reqBody = <String, String>{
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
    var pfpImg = await getImageFileFromAssets(pfp[i]);

    var pfpReq = http.MultipartRequest(
        "POST", Uri.parse("${json.decode(s3.body)['data']['url']}"));
    pfpReq.fields.addAll(reqBody);
    pfpReq.files.add(http.MultipartFile.fromBytes(
        'file', await File.fromUri(Uri.parse(pfpImg.path)).readAsBytes()));
    await pfpReq.send();

    final pfpBlob = json.encode({
      "filename": basename(pfp[i]),
      "mime_type": "image/jpeg",
      "bucket": "pxp-demo2",
      "tag": "string",
      "url": "${json.decode(s3.body)['data']['url']}demopfp$i.jpeg"
    });
    await http.post(blobURL, headers: jsonHeaders, body: pfpBlob);
  }
}

class _PicDemoState extends State<PicDemo> {
  Future<void> createPic() async {
    try {
      await create();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {}
  }

  @override
  Widget build(BuildContext context) => RawMaterialButton(
        onPressed: () async {
          await createPic();
          await demoPfp();
        },
        fillColor: pxpColors.accent,
        child: const Text('2', style: TextStyle(fontWeight: FontWeight.bold)),
        padding: const EdgeInsets.all(15.0),
        shape: const CircleBorder(),
      );
}
