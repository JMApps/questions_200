import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../core/strings/app_constraints.dart';

class MainAppState extends ChangeNotifier {
  final _contentSettingsBox = Hive.box(AppConstraints.keyAppSettingsBox);

  MainAppState() {
    _questionId = _contentSettingsBox.get(AppConstraints.keyLastQuestion, defaultValue: 1);
  }

  final ItemScrollController _itemScrollController = ItemScrollController();

  ItemScrollController get getItemScrollController => _itemScrollController;

  void randomQuestion() {
    int randomValue = Random().nextInt(201);
    _itemScrollController.scrollTo(index: randomValue, duration: Duration(milliseconds: 500), alignment: 0.5);
  }

  int _selectedIndex = 0;

  int get getSelectedIndex => _selectedIndex;

  set setSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  late int _questionId;

  int get getQuestionId => _questionId;

  set setQuestionId(int questionId) {
    _questionId = questionId;
    _contentSettingsBox.put(AppConstraints.keyLastQuestion, questionId);
    notifyListeners();
  }
}