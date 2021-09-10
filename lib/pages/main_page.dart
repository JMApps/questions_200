import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:questions_200/pages/question_chapters.dart';
import 'package:questions_200/pages/question_favorites.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    FocusScopeNode _currentFocus = FocusScope.of(context);
    return GestureDetector(
      child: CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        child: _buildTabScaffold(),
      ),
      onTap: () {
        if (!_currentFocus.hasPrimaryFocus) {
          _currentFocus.unfocus();
        }
      },
    );
  }

  Widget _buildTabScaffold() {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.square_stack_3d_up,
              color: CupertinoColors.black,
            ),
            activeIcon: Icon(
              CupertinoIcons.square_stack_3d_up,
              color: Colors.teal,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.square_stack_3d_up_fill,
              color: CupertinoColors.black,
            ),
            activeIcon: Icon(
              CupertinoIcons.square_stack_3d_up_fill,
              color: Colors.teal,
            ),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        CupertinoTabView? returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(
              builder: (context) {
                return QuestionChapters();
              },
            );
            break;
          case 1:
            returnValue = CupertinoTabView(
              builder: (context) {
                return QuestionFavorites();
              },
            );
            break;
        }
        return returnValue!;
      },
    );
  }
}
