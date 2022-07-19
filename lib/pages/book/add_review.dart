import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pxp_flutter/pages/book_detail.dart';
import 'package:http/http.dart' as http;
import 'package:pxp_flutter/pages/ig/app/app.dart';
import '../../constants/Theme.dart';

class AddReview extends StatefulWidget {
  const AddReview({Key? key}) : super(key: key);

  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isPosted = false;
  bool isAdvanced = false;
  late double overall = 0;
  late double style = 0;
  late double grammar = 0;
  late double plot = 0;
  late double character = 0;

  final url = 'http://localhost:5000/api/v1/';
  final jsonHeaders = {"Content-type": "application/json"};

  @override
  void initState() {
    super.initState();
  }

  Future<void> createReview(val) async {
    final reviewURL = Uri.parse(url + 'book_ratings/');

    final simple = json.encode({
      "rating": overall.toInt(),
      "reviewer_id": 1,
      "book_id": 1,
      "review": {
        "style": style.toInt(),
        "plot": plot.toInt(),
        "grammar": grammar.toInt(),
        "character": character.toInt(),
        "chapter": 1,
        "title": "${val['title']}",
        "text": "${val['text']}"
      }
    });
    final advanced = json.encode({
      "rating": overall.toInt(),
      "reviewer_id": 1,
      "book_id": 1,
      "review": {
        "style": style.toInt(),
        "plot": plot.toInt(),
        "grammar": grammar.toInt(),
        "character": character.toInt(),
        "chapter": 1,
        "title": "${val['title']}",
        "text": "${val['text']}"
      }
    });

    try {
      print(advanced);
      if (isAdvanced == false) {
        final response =
            await http.post(reviewURL, headers: jsonHeaders, body: simple);
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
          setState(() {
            isPosted = true;
          });
          context.removeAndShowSnackbar('Success!');
        }
      }
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
          title: const Text(
            "Write a review",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        body: getBody(book));
  }

  Widget getBody(book) {
    return FormBuilder(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() => overall = rating);
                          },
                        ),
                        const SizedBox(height: 20),
                        isAdvanced == false
                            ? TextButton(
                                style: TextButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.zero)),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.zero)),
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
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
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
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
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
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              setState(() => grammar = rating);
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
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              setState(
                                                  () => character = rating);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : const SizedBox(height: 0),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FormBuilderTextField(
                                name: 'title',
                                keyboardType: TextInputType.multiline,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Title (required)',
                                ),
                                validator: FormBuilderValidators.required()),
                            const SizedBox(height: 10),
                            FormBuilderTextField(
                              name: 'text',
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              minLines: 5,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              decoration: const InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: 'Be heard by your author (optional)',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        TextButton(
                          child: isPosted == false
                              ? const Text('Post review')
                              : const Text('Posted!'),
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              primary: Colors.white,
                              backgroundColor:
                                  pxpColors.accent.withOpacity(0.9),
                              onSurface: Colors.grey,
                              textStyle: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          onPressed: () async {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                              createReview(_formKey.currentState!.value);
                            }
                          },
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

List<Icon> _ratingCount(int count) {
  return List.generate(count,
          (i) => const Icon(AntDesign.star, size: 10, color: Color(0xFFFFD700)))
      .toList(); // replace * with your rupee or use Icon instead
}
