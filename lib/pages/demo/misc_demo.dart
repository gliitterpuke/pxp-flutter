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

class MiscDemo extends StatefulWidget {
  const MiscDemo({Key? key}) : super(key: key);

  @override
  _MiscDemoState createState() => _MiscDemoState();
}

const url = 'http://localhost:5000/api/v1/';
final jsonHeaders = {"Content-type": "application/json"};
final mimeHeaders = {"Content-type": "image/jpeg"};

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
      "url": "${json.decode(s3.body)['data']['url']}demopfp$i.jpg"
    });
    await http.post(blobURL, headers: jsonHeaders, body: pfpBlob);
  }
}

Future<void> delete() async {
  final client = StreamFeedClient(
    FlutterConfig.get('STREAM_FEED_API_KEY'),
  );

  // final deleteRes =
  //     await http.delete(Uri.parse(url + 'users/1'), headers: jsonHeaders);
  // // print(deleteRes.body);

  List<String> usernames = [
    "demo"
        "glitterpuke",
    "llyx",
    "teampxp",
    "higashino",
    "lminjin",
    "choover",
    "achristie",
    "cslewis"
  ];

  List<String> tokens = [
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZGVtbyJ9.ZAAu9b8QbSFKuIBGyi5lVWWhQOHnHIsxV1_quE0c318",
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZ2xpdHRlcnB1a2UifQ.U2yAZ2tdf05PJMkHcmyxYwLrZSbRaf5iR3xx6ELXmpU",
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoibGx5eCJ9.Lkz-OjKYjTiuXLUOhxjNcvzMXozaUR91l3SYmR5t2fc",
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidGVhbXB4cCJ9.8w8MoiRzY1PbmJTu-iiCN9A_b9LAeFo2kpa8zfh_8v0",
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiaGlnYXNoaW5vIn0.U_Jk15dyltmyAec3rbuGaIyXE6YoeuAa5Qxqyn7-YYo",
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoibG1pbmppbiJ9.RvZuqRA5b_Rs212Z6z1e4XryhdcCoA-6xcMa04OGVJU",
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiY2hvb3ZlciJ9.XCtkDFCul2nNMn5MHQwEVBIulUofN3f0r1Gnd_yS8wA",
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYWNocmlzdGllIn0.wcfHrLiHRHc7NY6XF7Z-9neAN7I1LUHAJLK7viidv8M",
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiY3NsZXdpcyJ9.i7DAUpqhqpdP75E2V8C22-eM8IV2A2Jj5L2LZq8IPWE"
  ];
  for (int i = 0; i < usernames.length; i++) {
    await client.setUser(User(id: usernames[i]), Token(tokens[i]));

    await client.user(usernames[i]).delete();
  }
  print('success');
}

Future<void> ezDelete() async {
  for (int i = 0; i < 16; i++) {
    await http.delete(Uri.parse(url + 'users/$i'));
  }
  print('success');
}

// final pfpBody = json.encode({
//   "filename": "pusheen2.jpg",
//   "mime_type": "image/jpeg",
//   "bucket": "pxp-demo2",
//   "tag": "pfp",
//   "url": "https://pxp-demo2.s3.amazonaws.com/pusheen2.jpg"
// });

// http.post(Uri.parse('http://localhost:5000/api/v1/blobs/'),
//     headers: jsonHeaders, body: pfpBody);

class _MiscDemoState extends State<MiscDemo> {
  Future<void> deleteUser() async {
    try {
      await delete();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {}
  }

  @override
  Widget build(BuildContext context) => RawMaterialButton(
        onPressed: () async {
          ezDelete();
        },
        fillColor: pxpColors.accent,
        child: const Text('2', style: TextStyle(fontWeight: FontWeight.bold)),
        padding: const EdgeInsets.all(15.0),
        shape: const CircleBorder(),
      );
}
