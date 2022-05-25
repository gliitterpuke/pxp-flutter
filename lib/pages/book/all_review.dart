import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pxp_flutter/json/book_detail_json.dart';
import 'package:pxp_flutter/constants/Theme.dart';
import 'package:readmore/readmore.dart';

class AllReview extends StatefulWidget {
  @override
  _AllReviewState createState() => _AllReviewState();
}

class _AllReviewState extends State<AllReview> {
  int _page = 0;
  final int _perPage = 5;

  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose(); // dispose the controller
    super.dispose();
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    controller.animateTo(0,
        duration: const Duration(seconds: 3), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    final dataToShow =
        reviewList.sublist((_page * _perPage), ((_page * _perPage) + _perPage));
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              ListView.builder(
                controller: controller,
                // physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: dataToShow.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(99),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            dataToShow[index]['img']),
                                        fit: BoxFit.cover)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      dataToShow[index]['display'],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    if (dataToShow[index]['award'] == true)
                                      SizedBox(width: 5),
                                    if (dataToShow[index]['award'] == true)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Icon(
                                          FontAwesome.diamond,
                                          size: 20,
                                          color: pxpColors.secondaryT,
                                        ),
                                      ),
                                  ]),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                dataToShow[index]['date'] +
                                    " at Chapter " +
                                    dataToShow[index]['location'].toString(),
                                style: const TextStyle(
                                    color: pxpColors.secondaryT,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 10,
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
                                  children: _ratingCount(
                                      dataToShow[index]['overall'])),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                              dataToShow[index]['style'])),
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
                                              dataToShow[index]['story'])),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                              dataToShow[index]['grammar'])),
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
                                              dataToShow[index]['content'])),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              ReadMoreText(
                                dataToShow[index]['review'],
                                textAlign: TextAlign.center,
                                trimLines: 3,
                                colorClickableText: Colors.pink,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: 'Show less',
                                lessStyle: (TextStyle(
                                    color: Colors.pink,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                                moreStyle: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Feather.thumbs_up,
                                  size: 20,
                                  color: pxpColors.secondaryT,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  dataToShow[index]['helpful'].toString(),
                                  style: const TextStyle(
                                      color: pxpColors.secondaryT,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                if (dataToShow[index]['award'] == true)
                                  Spacer(),
                                if (dataToShow[index]['award'] == true)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(
                                      FontAwesome.diamond,
                                      size: 20,
                                      color: pxpColors.secondaryT,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Divider(color: pxpColors.secondaryT),
                          SizedBox(height: 10)
                        ],
                      ),
                    ),
                  );
                },
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                if (_page > 0)
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      primary: Colors.white,
                      side:
                          BorderSide(color: Color.fromARGB(255, 193, 193, 193)),
                    ),
                    onPressed: () => {
                      setState(() {
                        _page -= 1;
                        scrollUp;
                      })
                    },
                    child: const Text('Prev'),
                  ),
                if (_page > 0 && _page > (reviewList.length / 5).floor() - 1)
                  SizedBox(width: 10),
                if (_page < (reviewList.length / 5).floor() - 1)
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      primary: Colors.white,
                      side:
                          BorderSide(color: Color.fromARGB(255, 193, 193, 193)),
                    ),
                    onPressed: () => {
                      setState(() {
                        _page += 1;
                        controller.jumpTo(
                          0,
                        );
                      })
                    },
                    child: const Text('Next'),
                  )
              ]),
              SizedBox(height: 60)
            ]),
          ),
        ));
  }

  void scrollUp() {
    final double start = 0;
    controller.animateTo(0,
        duration: const Duration(seconds: 3), curve: Curves.linear);
  }
}

List<Icon> _ratingCount(int count) {
  return List.generate(
          count, (i) => Icon(AntDesign.star, size: 10, color: Colors.amber))
      .toList(); // replace * with your rupee or use Icon instead
}
