// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class TableCellSettings extends StatelessWidget {
  final String? title;
  final void Function()? onTap;
  TableCellSettings({this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title!, style: TextStyle(color: Colors.white)),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child:
                  Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
            )
          ],
        ),
      ),
    );
  }
}
