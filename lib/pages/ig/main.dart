import 'package:flutter/material.dart';
import 'package:pxp_flutter/pages/ig/app/stream_agram.dart';

import 'app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final theme = AppTheme();
  runApp(StreamagramApp(appTheme: theme));
}
