import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questions_200/application/state/main_app_state.dart';
import 'package:questions_200/application/strings/app_strings.dart';
import 'package:questions_200/presentation/pages/question_chapters.dart';
import 'package:questions_200/presentation/pages/question_favorites.dart';
import 'package:questions_200/presentation/pages/settings_page.dart';

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
    final MainAppState mainAppState = context.watch<MainAppState>();
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
            icon: GestureDetector(
                onDoubleTap: () {
                  context.read<MainAppState>().getItemScrollController.scrollTo(
                        index: 0,
                        duration: const Duration(milliseconds: 500),
                      );
                },
                child: const Icon(CupertinoIcons.collections)),
          ),
          const BottomNavigationBarItem(
            label: AppStrings.bookmarks,
            icon: Icon(CupertinoIcons.bookmark),
          ),
          const BottomNavigationBarItem(
            label: AppStrings.settings,
            icon: Icon(CupertinoIcons.settings),
          ),
        ],
        currentIndex: mainAppState.getSelectedIndex,
        onTap: context.read<MainAppState>().changeSelectedIndex,
      ),
    );
  }
}
