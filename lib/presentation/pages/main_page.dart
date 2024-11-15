import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../core/strings/app_strings.dart';
import '../../core/styles/app_styles.dart';
import '../state/main_app_state.dart';
import '../widgets/about_us_column.dart';
import '../settings/pages/app_settings_page.dart';
import 'favorite_questions_page.dart';
import 'main_questions_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _mainPages = [
    const MainQuestionsPage(),
    const FavoriteQuestionsPage(),
    const AppSettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    return Consumer<MainAppState>(
      builder: (context, mainAppState, _) {
        return Scaffold(
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeInToLinear,
            switchOutCurve: Curves.easeInToLinear,
            child: _mainPages[mainAppState.getSelectedIndex],
          ),
          bottomNavigationBar: Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            shape: AppStyles.mainShapeTop,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: Padding(
                padding: AppStyles.mainPaddingTopMini,
                child: Consumer<MainAppState>(
                  builder: (context, mainState, _) {
                    return SalomonBottomBar(
                        selectedItemColor: appColors.primary,
                        unselectedItemColor: appColors.secondary,
                        items: [
                          SalomonBottomBarItem(
                              icon: const Icon(Icons.question_answer_rounded),
                              title: _itemText(title: AppStrings.questions),
                          ),
                          SalomonBottomBarItem(
                              icon: const Icon(Icons.bookmark),
                              title: _itemText(title: AppStrings.bookmarks),
                          ),
                          SalomonBottomBarItem(
                              icon: const Icon(Icons.settings),
                              title: _itemText(title: AppStrings.settings),
                          ),
                          SalomonBottomBarItem(
                            icon: const Icon(Icons.account_box),
                            title: _itemText(title: AppStrings.aboutUs),
                          ),
                        ],
                        currentIndex: mainState.getSelectedIndex,
                        onTap: (int index) {
                          if (index == 3) {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => AboutUsColumn(),
                            );
                          } else {
                            mainState.setSelectedIndex = index;
                          }
                        },
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Text _itemText({required String title}) {
    return Text(title, style: AppStyles.mainTextStyle17);
  }
}
