import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:questions_200/pages/main_page.dart';
import 'package:questions_200/router/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _appRouter.onGenerateRoute,
      initialRoute: '/',
      title: '200 вопросов',
      theme: CupertinoThemeData(
          primaryColor: CupertinoColors.systemTeal,
          textTheme: CupertinoTextThemeData(
              primaryColor: Colors.teal,
              textStyle: TextStyle(fontFamily: 'Gilroy'))),
      home: MainPage(),
    );
  }
}
