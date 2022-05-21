import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, '35', 'Following'),
          buildButton(context, '50', 'Followers'),
          buildButton(context, '2', 'Subscribed'),
        ],
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Column(
              children: [
                Text(
                  value,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(text,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8), fontSize: 12.0))
              ],
            ),
          ]));
}
