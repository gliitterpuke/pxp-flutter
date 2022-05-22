import 'package:flutter/material.dart';
import 'package:pxp_flutter/pages/book_detail.dart';
import 'package:pxp_flutter/pages/profile/follow.dart';

class NumbersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, '35', 'Following', 0),
          buildButton(context, '50', 'Followers', 1),
          buildButton(context, '2', 'Subscribed', 2),
        ],
      );

  Widget buildButton(
          BuildContext context, String value, String followState, int page) =>
      GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => followState == "Following"
                      ? FollowPage(
                          page: 0,
                        )
                      : followState == "Followers"
                          ? FollowPage(
                              page: 1,
                            )
                          : BookDetail(),
                ));
          },
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          value,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(followState,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12.0))
                      ],
                    ),
                  ])));
}
