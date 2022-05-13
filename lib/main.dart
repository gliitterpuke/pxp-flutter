import 'package:flutter/material.dart';
import 'package:pxp_flutter/pages/root_app.dart';
import 'package:pxp_flutter/pages/onboarding.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: Onboarding(),
  ));
}
