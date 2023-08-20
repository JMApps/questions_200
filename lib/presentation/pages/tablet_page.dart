import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questions_200/application/state/main_app_state.dart';
import 'package:questions_200/application/strings/app_strings.dart';
import 'package:questions_200/presentation/pages/answer_content_page.dart';
import 'package:questions_200/presentation/pages/question_chapters.dart';
import 'package:questions_200/presentation/pages/question_favorites.dart';

class TabletPage extends StatefulWidget {
  const TabletPage({super.key});

  @override
  State<TabletPage> createState() => _TabletPageState();
}

class _TabletPageState extends State<TabletPage> {
  final List<Widget> _listWidgets = [
    const QuestionChapters(),
    const QuestionFavorites(),
  ];

  @override
  Widget build(BuildContext context) {
    final MainAppState mainAppState = Provider.of<MainAppState>(context);
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
                ],
                currentIndex: mainAppState.getSelectedIndex,
                onTap: context.read<MainAppState>().changeSelectedIndex,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: AnswerContentPage(
              questionId: mainAppState.getQuestionId,
              questionContent: mainAppState.getQuestionContent,
            ),
          ),
        ],
      ),
    );
  }
}
