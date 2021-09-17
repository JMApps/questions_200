import 'package:flutter/material.dart';
import 'package:questions_200/pages/question_chapters_a.dart';
import 'package:questions_200/pages/question_favorites_a.dart';

class MainPageA extends StatefulWidget {
  const MainPageA({Key? key}) : super(key: key);

  @override
  _MainPageAState createState() => _MainPageAState();
}

class _MainPageAState extends State<MainPageA> {
  int _selectedIndex = 0;

  var _listWidgets = [
    QuestionChaptersA(),
    QuestionFavoritesA(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidgets[_selectedIndex],
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