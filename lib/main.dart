import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marvel_task/provider/character_provider.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'screens/characters_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ),
  );
  runApp( MyApp());
}

