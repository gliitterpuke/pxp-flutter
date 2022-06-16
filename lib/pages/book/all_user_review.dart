import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pxp_flutter/json/book_detail_json.dart';
import 'package:pxp_flutter/constants/Theme.dart';
import 'package:readmore/readmore.dart';
import 'package:number_paginator/number_paginator.dart';

class AllUserReview extends StatefulWidget {
  @override
  _AllUserReviewState createState() => _AllUserReviewState();
}

class _AllUserReviewState extends State<AllUserReview> {
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
    controller.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    controller.animateTo(0,
        duration: const Duration(milliseconds: 250), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    var _numPage = (reviewList.length / _perPage).floor();
    final dataToShow = userReviewList.sublist(
        (_page * _perPage), ((_page * _perPage) + _perPage));
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
            controller: controller,
            scrollDirection: Axis.vertical,
            child: Column(children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
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
                              Text(dataToShow[index]['title'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(
                                height: 15,
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
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  );
                },
              ),
              NumberPaginator(
                numberPages: _numPage,
                buttonSelectedForegroundColor: Colors.white,
                buttonUnselectedForegroundColor: pxpColors.secondaryT,
                buttonUnselectedBackgroundColor: Colors.transparent,
                buttonSelectedBackgroundColor: Colors.transparent,
                onPageChange: (int index) {
                  setState(() {
                    _page = index;
                    _scrollToTop();
                  });
                },
              ),
              SizedBox(height: 60),
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
      .toList();
}
