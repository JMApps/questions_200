import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../data/database_query.dart';
import '../strings/app_constraints.dart';

class MainAppState extends ChangeNotifier {
  final _contentSettingsBox = Hive.box(AppConstraints.keyAppSettingsBox);

  final _favoritesBox = Hive.box(AppConstraints.keyFavoritesList);

  final DatabaseQuery _databaseQuery = DatabaseQuery();

  DatabaseQuery get getDatabaseQuery => _databaseQuery;

  final ItemScrollController _itemScrollController = ItemScrollController();

  ItemScrollController get getItemScrollController => _itemScrollController;

  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();

  ItemPositionsListener get getItemPositionsListener => _itemPositionsListener;

  List<int> _favoriteQuestions = [];

  List<int> get getFavoriteList => _favoriteQuestions;

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

  late int _lastQuestion;

  int get getLastQuestion => _lastQuestion;

  set saveLastLesson(int questionId) {
    _lastQuestion = questionId;
    _contentSettingsBox.put(AppConstraints.keyLastHead, questionId);
    notifyListeners();
  }

  toggleFavorite(int id) {
    final exist = _favoriteQuestions.contains(id);
    if (exist) {
      _favoriteQuestions.remove(id);
    } else {
      _favoriteQuestions.add(id);
    }
    _favoritesBox.put(AppConstraints.keyFavoritesList, _favoriteQuestions);
    notifyListeners();
  }

  bool supplicationIsFavorite(int id) {
    final exist = _favoriteQuestions.contains(id);
    return exist;
  }

  MainAppState() {
    _lastQuestion = _contentSettingsBox.get(AppConstraints.keyLastHead, defaultValue: 0);
    _favoriteQuestions = _favoritesBox.get(AppConstraints.keyFavoritesList, defaultValue: <int>[]);
  }
}
