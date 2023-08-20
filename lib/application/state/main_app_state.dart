import 'package:flutter/material.dart';
import 'package:questions_200/data/database_query.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MainAppState extends ChangeNotifier {
  final DatabaseQuery _databaseQuery = DatabaseQuery();

  DatabaseQuery get getDatabaseQuery => _databaseQuery;

  final ItemScrollController _itemScrollController = ItemScrollController();

  ItemScrollController get getItemScrollController => _itemScrollController;

  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();

  ItemPositionsListener get getItemPositionsListener => _itemPositionsListener;

  int _questionId = 1;

  int get getQuestionId => _questionId;

  set changeQuestionId(int questionId) {
    _questionId = questionId;
    notifyListeners();
  }

  String _questionContent = 'Что является первостепенной обязанностью рабов Аллаха?';

  String get getQuestionContent => _questionContent;

  set changeQuestionContent(String questionContent) {
    _questionContent = questionContent;
    notifyListeners();
  }

  int _selectedIndex = 0;

  int get getSelectedIndex => _selectedIndex;

  changeSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  Future<void> addRemoveBookmark(int favoriteState, int questionId) async {
    _databaseQuery.addRemoveFavorite(favoriteState, questionId);
    notifyListeners();
  }
}
