import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pxp_flutter/constants/Theme.dart';
import 'package:pxp_flutter/json/profile.dart';

class MyStorePage extends StatefulWidget {
  MyStorePage({Key? key}) : super(key: key);

  @override
  _MyStorePageState createState() => _MyStorePageState();
}

class _MyStorePageState extends State<MyStorePage> {
  Widget build(BuildContext context) {
    final coin = ModalRoute.of(context)!.settings.arguments as int;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Ionicons.md_close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('STORE',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Center(
                  child: Text(coin.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold)))),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(Icons.generating_tokens_outlined),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Top PxP Deals",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Read more episodes for less!',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'FOR YOU',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: pxpColors.darkCard,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10),
                    child: Column(
                        children: List.generate(
                      specialOffer.length,
                      (index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/nekobox.png'),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Starter Pack',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Text(specialOffer[index]['coins'].toString() +
                                      ' coins'),
                                ],
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Column(
                                  children: [
                                    TextButton(
                                      child: Text('\$' +
                                          (specialOffer[index]['final'])
                                              .toString()),
                                      style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 15),
                                          primary: Colors.white,
                                          backgroundColor: pxpColors.accent
                                              .withOpacity(0.75),
                                          onSurface: Colors.grey,
                                          textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      onPressed: () {},
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: Text(
                                                '\$' +
                                                    specialOffer[index]['og']
                                                        .toString(),
                                                style: TextStyle(
                                                    color: pxpColors.secondaryT,
                                                    fontSize: 10,
                                                    decoration: TextDecoration
                                                        .lineThrough))),
                                        Text(
                                            (((specialOffer[index]['og'] -
                                                                specialOffer[
                                                                        index]
                                                                    ['final']) /
                                                            specialOffer[index]
                                                                ['og']) *
                                                        100)
                                                    .toStringAsFixed(0) +
                                                '\% OFF',
                                            style: TextStyle(
                                              color: pxpColors.accent,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ))),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'SUBSCRIBE & SAVE',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: pxpColors.darkCard,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10),
                    child: Column(
                        children: List.generate(
                      specialOffer.length,
                      (index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 10),
                                child: Icon(Icons.generating_tokens_outlined),
                              ),
                              Text(subscribeSave[index]['coins'].toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text(' coins / month',
                                  style: TextStyle(
                                    fontSize: 16,
                                  )),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Column(
                                  children: [
                                    TextButton(
                                      child: Text('\$' +
                                          (subscribeSave[index]['final'])
                                              .toString()),
                                      style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 15),
                                          primary: Colors.white,
                                          backgroundColor: pxpColors.accent
                                              .withOpacity(0.75),
                                          onSurface: Colors.grey,
                                          textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      onPressed: () {},
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: Text(
                                                '\$' +
                                                    subscribeSave[index]['og']
                                                        .toString(),
                                                style: TextStyle(
                                                    color: pxpColors.secondaryT,
                                                    fontSize: 10,
                                                    decoration: TextDecoration
                                                        .lineThrough))),
                                        Text(
                                            (((subscribeSave[index]['og'] -
                                                                subscribeSave[
                                                                        index]
                                                                    ['final']) /
                                                            subscribeSave[index]
                                                                ['og']) *
                                                        100)
                                                    .toStringAsFixed(0) +
                                                '\% OFF',
                                            style: TextStyle(
                                              color: pxpColors.accent,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ))),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'ONE-TIME PURCHASE',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Container(
                          color: pxpColors.darkCard,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 10),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 10),
                                  child: Icon(Icons.generating_tokens_outlined),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        oTP[index]['coins'].toString() +
                                            ' coins',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    if ((((oTP[index]['og'] -
                                                    oTP[index]['final']) /
                                                oTP[index]['og']) *
                                            100) >
                                        1)
                                      Text(
                                          (((oTP[index]['og'] -
                                                              oTP[index]
                                                                  ['final']) /
                                                          oTP[index]['og']) *
                                                      100)
                                                  .toStringAsFixed(0) +
                                              '\% OFF',
                                          style: TextStyle(
                                            color: pxpColors.accent,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                          )),
                                  ],
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Column(
                                    children: [
                                      TextButton(
                                        child: Text('\$' +
                                            (oTP[index]['final']).toString()),
                                        style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 15),
                                            primary: Colors.white,
                                            backgroundColor: pxpColors.accent
                                                .withOpacity(0.75),
                                            onSurface: Colors.grey,
                                            textStyle: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () {},
                                      ),
                                      if (oTP[index]['og'] !=
                                          oTP[index]['final'])
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: Text(
                                                '\$' +
                                                    oTP[index]['og'].toString(),
                                                style: TextStyle(
                                                    color: pxpColors.secondaryT,
                                                    fontSize: 10,
                                                    decoration: TextDecoration
                                                        .lineThrough))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
