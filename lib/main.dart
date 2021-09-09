import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:questions_200/pages/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      title: '200 вопросов',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.systemTeal,
      ),
      home: MainPage(),
    );
  }
}