import 'package:flutter/material.dart';

import 'package:workapp/pages/home.dart';
import 'package:workapp/pages/loading.dart';
import 'package:workapp/pages/settings.dart';



void main() => runApp(MaterialApp(

  initialRoute: '/',

  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/settings': (context) => Settings(),
  },
));
