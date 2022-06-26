import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pxp_flutter/constants/Theme.dart';

class ReviewPage extends StatefulWidget {
  Map<String, dynamic> reviewObj;
  ReviewPage({Key? key, required this.reviewObj}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  bool isAdvanced = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
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
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(99),
                            image: DecorationImage(
                                image: AssetImage(widget.reviewObj['img']),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.reviewObj['display'],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            if (widget.reviewObj['award'] == true)
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Icon(
                                      FontAwesome.diamond,
                                      size: 20,
                                      color: pxpColors.secondaryT,
                                    ),
                                  ),
                                ],
                              ),
                          ]),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.reviewObj['date'] +
                            " at Chapter " +
                            widget.reviewObj['location'].toString(),
                        style: const TextStyle(
                            color: pxpColors.secondaryT,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text("Overall",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _ratingCount(widget.reviewObj['overall'])),
                      const SizedBox(
                        height: 10,
                      ),
                      if (isAdvanced == true)
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text("Style",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: _ratingCount(
                                            widget.reviewObj['style'])),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("Story",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: _ratingCount(
                                            widget.reviewObj['story'])),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text("Grammar",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: _ratingCount(
                                            widget.reviewObj['grammar'])),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("Content",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: _ratingCount(
                                            widget.reviewObj['content'])),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      Text(widget.reviewObj['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.reviewObj['review'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton.icon(
                              label: Text(
                                "Report",
                                style: const TextStyle(
                                    color: pxpColors.secondaryT,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              icon: Icon(
                                MaterialIcons.report_problem,
                                size: 15,
                                color: pxpColors.secondaryT,
                              ),
                              onPressed: () {},
                            ),
                            OutlinedButton.icon(
                              label: Text(
                                widget.reviewObj['helpful'].toString() +
                                    " Helped",
                                style: const TextStyle(
                                    color: pxpColors.secondaryT,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              icon: Icon(
                                Feather.thumbs_up,
                                size: 15,
                                color: pxpColors.secondaryT,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
