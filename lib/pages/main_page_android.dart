import 'package:flutter/material.dart';
import 'package:questions_200/pages/question_chapters_android.dart';
import 'package:questions_200/pages/question_favorites_android.dart';

class MainPageAndroid extends StatefulWidget {
  const MainPageAndroid({Key? key}) : super(key: key);

  @override
  _MainPageAndroidState createState() => _MainPageAndroidState();
}

class _MainPageAndroidState extends State<MainPageAndroid> {
  int _selectedIndex = 0;

  var _containerWidgets = [
    QuestionChapterAndroid(),
    QuestionFavoritesAndroid(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _containerWidgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: 'Главы',
            icon: Icon(Icons.format_list_bulleted),
          ),
          BottomNavigationBarItem(
            label: 'Избранное',
            icon: Icon(Icons.bookmark),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
      ),
    );
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
