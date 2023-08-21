import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:questions_200/application/strings/app_constraints.dart';
import 'package:questions_200/data/database_query.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MainAppState extends ChangeNotifier {
  final _contentSettingsBox = Hive.box(AppConstraints.keyAppSettingsBox);

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

  int _selectedIndex = 0;

  int get getSelectedIndex => _selectedIndex;

  changeSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  int _lastQuestion = -1;

  int get getLastQuestion => _lastQuestion;

  set saveLastLesson(int questionId) {
    _lastQuestion = questionId;
    _contentSettingsBox.put(AppConstraints.keyLastHead, questionId);
    notifyListeners();
  }

  Future<void> addRemoveBookmark(int favoriteState, int questionId) async {
    _databaseQuery.addRemoveFavorite(favoriteState, questionId);
    notifyListeners();
  }

  MainAppState() {
    _lastQuestion = _contentSettingsBox.get(AppConstraints.keyLastHead, defaultValue: -1);
  }
}
