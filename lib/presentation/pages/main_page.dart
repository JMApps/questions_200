import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../core/strings/app_strings.dart';
import '../../core/styles/app_styles.dart';
import '../settings/pages/app_settings_page.dart';
import '../state/main_app_state.dart';
import '../widgets/about_us_column.dart';
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
          resizeToAvoidBottomInset: true,
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            switchInCurve: Curves.easeInToLinear,
            switchOutCurve: Curves.easeInToLinear,
            child: _mainPages[mainAppState.getSelectedIndex],
          ),
          bottomNavigationBar: Padding(
            padding: AppStyles.mainPaddingMini,
            child: SalomonBottomBar(
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
              currentIndex: mainAppState.getSelectedIndex,
              onTap: (int index) {
                if (index == 3) {
                  showModalBottomSheet(
                    context: context,
                    useSafeArea: true,
                    isScrollControlled: true,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom + MediaQuery.of(context).padding.bottom,
                        ),
                        child: const AboutUsColumn(),
                      );
                    },
                  );
                } else {
                  mainAppState.setSelectedIndex = index;
                }
              },
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
