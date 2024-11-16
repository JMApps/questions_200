import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/strings/app_strings.dart';
import '../lists/favorite_questions_list.dart';
import '../lists/main_questions_list.dart';
import '../state/main_app_state.dart';
import 'content_question_page.dart';

class TabletPage extends StatefulWidget {
  const TabletPage({super.key});

  @override
  State<TabletPage> createState() => _TabletPageState();
}

class _TabletPageState extends State<TabletPage> {
  final List<Widget> _listWidgets = [
    const MainQuestionsList(),
    const FavoriteQuestionsList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainAppState>(
      builder: (context, mainAppState, _) {
        return Material(
          child: Row(
            children: [
              Expanded(
                child: Scaffold(
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
                          onDoubleTap: () {},
                          child: const Icon(CupertinoIcons.collections),
                        ),
                      ),
                      const BottomNavigationBarItem(
                        label: AppStrings.bookmarks,
                        tooltip: AppStrings.bookmarks,
                        icon: Icon(CupertinoIcons.bookmark),
                      ),
                    ],
                    currentIndex: mainAppState.getSelectedIndex,
                    onTap: (index) => mainAppState.setSelectedIndex = index,
                  ),
                ),
              ),
              VerticalDivider(),
              Expanded(
                flex: 2,
                child: ContentQuestionPage(),
              ),
            ],
          ),
        );
      },
    );
  }
}
