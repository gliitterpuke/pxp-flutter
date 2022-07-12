import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pxp_flutter/pages/book_detail.dart';
import 'package:http/http.dart' as http;
import 'package:pxp_flutter/pages/ig/app/app.dart';

class AddReview extends StatefulWidget {
  const AddReview({Key? key}) : super(key: key);

  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  bool isAdvanced = false;
  late double overall;
  late double style;
  late double grammar;
  late double plot;
  late double character;

  final url = 'http://localhost:5000/api/v1/';
  final jsonHeaders = {"Content-type": "application/json"};

  @override
  void initState() {
    super.initState();
  }

  Future<void> createReview() async {
    final reviewURL = Uri.parse(url + 'book_reviews/');
    final simple = json.encode({
      "style": 0,
      "plot": 0,
      "grammar": 0,
      "character": 0,
      "chapter": 0,
      "title": "Truly amazing",
      "text": "phenomenal tell me more"
    });
    final advanced = json.encode({
      "style": style.toStringAsFixed(1),
      "plot": plot.toStringAsFixed(1),
      "grammar": grammar.toStringAsFixed(1),
      "character": character.toStringAsFixed(1),
      "chapter": 0,
      "title": "Truly amazing",
      "text": "phenomenal tell me more"
    });

    try {
      // if (isAdvanced == false) {
      // final response =
      //     await http.post(reviewURL, headers: jsonHeaders, body: simple);
      // if (kDebugMode) {
      //   print('Status code: ${response.statusCode}');
      //   print('Body: ${response.body}');
      // }

      // if (response.statusCode != 200) {
      //   var error = json.decode(response.body);
      //   context.removeAndShowSnackbar(error['detail']);
      // } else {
      //   context.removeAndShowSnackbar('Success!');
      // }
      // } else {
      final advResp =
          await http.post(reviewURL, headers: jsonHeaders, body: advanced);
      if (kDebugMode) {
        print('Status code: ${advResp.statusCode}');
        print('Body: ${advResp.body}');
      }

      if (advResp.statusCode != 200) {
        var error = json.decode(advResp.body);
        context.removeAndShowSnackbar(error['detail']);
      } else {
        context.removeAndShowSnackbar('Success!');
      }
      // }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final book = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: getBody(book));
  }

  Widget getBody(book) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Write a review",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 115,
                      height: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          image: DecorationImage(
                              image: AssetImage(book['img']),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Overall",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 5,
                    ),
                    RatingBar.builder(
                      itemSize: 15,
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() => overall = rating);
                      },
                    ),
                    SizedBox(height: 20),
                    isAdvanced == false
                        ? TextButton(
                            style: TextButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.zero)),
                            ),
                            child: const Text('Advanced Review',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                            onPressed: () =>
                                setState(() => isAdvanced = !isAdvanced),
                          )
                        : TextButton(
                            style: TextButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.zero)),
                            ),
                            child: const Text('Simple Review',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                            onPressed: () =>
                                setState(() => isAdvanced = !isAdvanced),
                          ),
                    // GestureDetector(
                    //     onTap: () {
                    //       setState(() {
                    //         isAdvanced = !isAdvanced;
                    //       });
                    //       print(isAdvanced);
                    //     },
                    //     child: const Text('Advanced Search',
                    //         style: TextStyle(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.grey))),
                    isAdvanced == true
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      const Text("Style",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      RatingBar.builder(
                                        itemSize: 15,
                                        initialRating: 3,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          setState(() => style = rating);
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text("Story",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      RatingBar.builder(
                                        itemSize: 20,
                                        initialRating: 3,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          setState(() => plot = rating);
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      const Text("Grammar",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      RatingBar.builder(
                                        itemSize: 15,
                                        initialRating: 3,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          setState(() => character = rating);
                                        },
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text("Content",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      RatingBar.builder(
                                        itemSize: 15,
                                        initialRating: 3,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          setState(() => plot = rating);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                        : SizedBox(height: 0),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 5,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Be heard by your author (optional)',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        side: const BorderSide(
                            color: Color.fromARGB(255, 193, 193, 193)),
                      ),
                      onPressed: () {
                        // print(overall.toStringAsFixed(1));
                        createReview();
                      },
                      child: const Text('Post review'),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Icon> _ratingCount(int count) {
  return List.generate(count,
          (i) => const Icon(AntDesign.star, size: 10, color: Color(0xFFFFD700)))
      .toList(); // replace * with your rupee or use Icon instead
}
