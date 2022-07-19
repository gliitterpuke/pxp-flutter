import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/Theme.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class BookDemo extends StatefulWidget {
  const BookDemo({Key? key}) : super(key: key);

  @override
  _BookDemoState createState() => _BookDemoState();
}

const url = 'http://localhost:5000/api/v1/';
final jsonHeaders = {"Content-type": "application/json"};
final mimeHeaders = {"Content-type": "image/jpeg"};

Future<File> getImageFileFromAssets(String path) async {
  var bytes = await rootBundle.load(path);
  String tempPath = (await getTemporaryDirectory()).path;
  File file = File('$tempPath/image.jpeg');
  await file.writeAsBytes(
      bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

  return file;
}

Future<void> tag() async {
  List tags = [
    {"category": "genre", "name": "mystery"},
    {"category": "genre", "name": "romance"},
    {"category": "genre", "name": "historical fiction"},
    {"category": "genre", "name": "fantasy"},
    {"category": "plot", "name": "classics"},
    {"category": "plot", "name": "cultural"},
    {"category": "plot", "name": "literature"},
  ];

  for (int i = 0; i < tags.length; i++) {
    final tagURL = Uri.parse(url + 'tags/');
    final tagBody = json.encode({
      "category": tags[i]['category'],
      "name": tags[i]['name'],
      "description": "string"
    });
    final resp = await http.post(tagURL, headers: jsonHeaders, body: tagBody);
    print(resp.body);
  }
}

Future<void> cover() async {
  List<String> cover = [
    'assets/images/midnightsun.jpg',
    'assets/images/pachinko.jpg',
    'assets/images/endswithus.jpg',
    'assets/images/none.jpg',
    'assets/images/narnia.jpg',
  ];

  for (int i = 0; i < cover.length; i++) {
    final blobURL = Uri.parse(url + 'blobs/');
    final s3post = Uri.parse(url +
        'sign-s3-post?bucket=pxp-demo2&key=cover$i.jpeg&mime_type=image%2Fjpeg');
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
    var coverImg = await getImageFileFromAssets(cover[i]);

    var coverReq = http.MultipartRequest(
        "POST", Uri.parse("${json.decode(s3.body)['data']['url']}"));
    coverReq.fields.addAll(reqBody);
    coverReq.files.add(http.MultipartFile.fromBytes(
        'file', await File.fromUri(Uri.parse(coverImg.path)).readAsBytes()));
    await coverReq.send();

    final coverBlob = json.encode({
      "filename": basename(cover[i]),
      "mime_type": "image/jpeg",
      "bucket": "pxp-demo2",
      "tag": "string",
      "url": "${json.decode(s3.body)['data']['url']}cover$i.jpg"
    });
    print("${json.decode(s3.body)['data']['url']}cover$i.jpg");
    await http.post(blobURL, headers: jsonHeaders, body: coverBlob);
  }
}

class _BookDemoState extends State<BookDemo> {
  Future<void> createBook() async {
    final langURL = Uri.parse(url + 'languages/');

    final bookURL = Uri.parse(url + 'books/');

    final langBody = json.encode({
      "code": "eng",
      "name": "English",
    });

    try {
      // create language, tags
      await http.post(langURL, headers: jsonHeaders, body: langBody);

      // upload book cover
      await tag();
      await cover();

      final sunBody = json.encode({
        "title": "Under the Midnight Sun",
        "series": "Under the Midnight Sun",
        "number": "1",
        "summary":
            "When a man is found murdered in an abandoned building in Osaka in 1973, unflappable detective Sasagaki is assigned to the case. He begins to piece together the connection of two young people who are inextricably linked to the crime; the dark, taciturn son of the victim and the unexpectedly captivating daughter of the main suspect. Over the next twenty years we follow their lives as Sasagaki pursues the case - which remains unsolved - to the point of obsession.",
        "completed": true,
        "mature": true,
        "author_id": 1,
        "cover_id": 9,
        "language_id": 1,
        "tag_ids": [1],
      });

      final pachBody = json.encode({
        "title": "Pachinko",
        "series": "Pachinko",
        "number": "1",
        "summary":
            "In the early 1900s, teenaged Sunja, the adored daughter of a crippled fisherman, falls for a wealthy stranger at the seashore near her home in Korea. He promises her the world, but when she discovers she is pregnant — and that her lover is married — she refuses to be bought. Instead, she accepts an offer of marriage from a gentle, sickly minister passing through on his way to Japan. But her decision to abandon her home, and to reject her son's powerful father, sets off a dramatic saga that will echo down through the generations.",
        "completed": true,
        "mature": true,
        "author_id": 1,
        "cover_id": 10,
        "language_id": 1,
        "tag_ids": [1],
      });

      final endsBody = json.encode({
        "title": "It Ends With Us",
        "series": "Under the Midnight Sun",
        "number": "1",
        "summary":
            "Lily hasn’t always had it easy, but that’s never stopped her from working hard for the life she wants. She’s come a long way from the small town in Maine where she grew up — she graduated from college, moved to Boston, and started her own business. So when she feels a spark with a gorgeous neurosurgeon named Ryle Kincaid, everything in Lily’s life suddenly seems almost too good to be true.",
        "completed": true,
        "mature": true,
        "author_id": 1,
        "cover_id": 11,
        "language_id": 1,
        "tag_ids": [1],
      });

      final noneBody = json.encode({
        "title": "And Then There Were None",
        "series": "And Then There Were None",
        "number": "1",
        "summary":
            "First, there were ten—a curious assortment of strangers summoned as weekend guests to a little private island off the coast of Devon. Their host, an eccentric millionaire unknown to all of them, is nowhere to be found. All that the guests have in common is a wicked past they're unwilling to reveal—and a secret that will seal their fate. For each has been marked for murder. A famous nursery rhyme is framed and hung in every room of the mansion:\n\nTen little boys went out to dine; One choked his little self and then there were nine. Nine little boys sat up very late; One overslept himself and then there were eight. Eight little boys traveling in Devon; One said he'd stay there then there were seven. Seven little boys chopping up sticks; One chopped himself in half and then there were six. Six little boys playing with a hive; A bumblebee stung one and then there were five. Five little boys going in for law; One got in Chancery and then there were four. Four little boys going out to sea; A red herring swallowed one and then there were three. Three little boys walking in the zoo; A big bear hugged one and then there were two. Two little boys sitting in the sun; One got frizzled up and then there was one. One little boy left all alone; He went out and hanged himself and then there were none.\n\nWhen they realize that murders are occurring as described in the rhyme, terror mounts. One by one they fall prey. Before the weekend is out, there will be none. Who has choreographed this dastardly scheme? And who will be left to tell the tale? Only the dead are above suspicion.",
        "completed": true,
        "mature": true,
        "author_id": 1,
        "cover_id": 12,
        "language_id": 1,
        "tag_ids": [1],
      });

      final lionBody = json.encode({
        "title": "The Lion, the Witch, and the Wardrobe",
        "series": "The Lion, the Witch, and the Wardrobe",
        "number": "1",
        "summary":
            "Narnia… the land beyond the wardrobe door, a secret place frozen in eternal winter, a magical country waiting to be set free.\n\nLucy is the first to find the secret of the wardrobe in the professor's mysterious old house. At first her brothers and sister don't believe her when she tells of her visit to the land of Narnia. But soon Edmund, then Peter and Susan step through the wardrobe themselves. In Narnia they find a country buried under the evil enchantment of the White Witch. When they meet the Lion Aslan, they realize they've been called to a great adventure and bravely join the battle to free Narnia from the Witch's sinister spell.",
        "completed": true,
        "mature": true,
        "author_id": 1,
        "cover_id": 13,
        "language_id": 1,
        "tag_ids": [1],
      });

      // create book
      await http.post(bookURL, headers: jsonHeaders, body: sunBody);
      await http.post(bookURL, headers: jsonHeaders, body: pachBody);
      await http.post(bookURL, headers: jsonHeaders, body: endsBody);
      await http.post(bookURL, headers: jsonHeaders, body: noneBody);
      await http.post(bookURL, headers: jsonHeaders, body: lionBody);
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
