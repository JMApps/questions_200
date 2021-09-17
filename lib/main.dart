import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:questions_200/pages/main_page.dart';
import 'package:questions_200/pages/main_page_a.dart';
import 'package:questions_200/router/app_router.dart';
import 'package:questions_200/router/app_router_a.dart';

void main() {
  runApp(Platform.isAndroid ? MyAppA() : MyApp());
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
          brightness: Brightness.light,
          primaryColor: CupertinoColors.systemTeal,
          textTheme: CupertinoTextThemeData(
              primaryColor: Colors.teal,
              textStyle: TextStyle(fontFamily: 'Gilroy'))),
      home: MainPage(),
    );
  }
}

class MyAppA extends StatelessWidget {
  final _appRouterA = AppRouterA();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _appRouterA.onGenerateRoute,
      initialRoute: '/',
      title: '200 вопросов',
      theme: ThemeData(fontFamily: 'Gilroy'),
      home: MainPageA(),
    );
  }
}
