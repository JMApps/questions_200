import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/state/main_app_state.dart';
import '../../application/strings/app_strings.dart';
import 'question_chapters.dart';
import 'question_favorites.dart';
import 'settings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _listWidgets = [
    const QuestionChapters(),
    const QuestionFavorites(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final MainAppState mainAppState = Provider.of<MainAppState>(context);
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        switchInCurve: Curves.easeInToLinear,
        switchOutCurve: Curves.easeInToLinear,
        child: _listWidgets[mainAppState.getSelectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        useLegacyColorScheme: false,
        items: [
          BottomNavigationBarItem(
            label: AppStrings.heads,
            tooltip: AppStrings.heads,
            icon: GestureDetector(
              onDoubleTap: () {
                mainAppState.getItemScrollController.scrollTo(
                  index: 0,
                  duration: const Duration(milliseconds: 500),
                );
              },
              child: const Icon(CupertinoIcons.collections),
            ),
          ),
          const BottomNavigationBarItem(
            label: AppStrings.bookmarks,
            tooltip: AppStrings.bookmarks,
            icon: Icon(CupertinoIcons.bookmark),
          ),
          const BottomNavigationBarItem(
            label: AppStrings.settings,
            tooltip: AppStrings.settings,
            icon: Icon(CupertinoIcons.settings),
          ),
        ],
        currentIndex: mainAppState.getSelectedIndex,
        onTap: mainAppState.changeSelectedIndex,
      ),
    );
  }
}
