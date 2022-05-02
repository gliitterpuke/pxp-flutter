import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          side: BorderSide(color: Colors.white.withOpacity(0.5), width: 1),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 5),
        ),
        label: Text(text),
        icon: Icon(Feather.user_plus),
        onPressed: onClicked,
      );
}
