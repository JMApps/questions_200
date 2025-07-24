import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/strings/app_constraints.dart';

class ScrollPageState extends ChangeNotifier {
  final _mainScrollStates = Hive.box(AppConstraints.keyAppSettingsBox);

  double _previousScrollPosition = 0.0;

  final String _saveProgressKey;

  final ScrollController _scrollController;

  ScrollController get getScrollController => _scrollController;

  final ValueNotifier<double> _scrollProgressNotifier = ValueNotifier(0.0);

  ValueNotifier<double> get getScrollProgress => _scrollProgressNotifier;

  final ValueNotifier<double> _buttonOpacityNotifier = ValueNotifier(0.0);

  ValueNotifier<double> get getButtonOpacity => _buttonOpacityNotifier;

  ScrollPageState(this._scrollController, this._saveProgressKey) {
    _scrollProgressNotifier.value = _mainScrollStates.get(_saveProgressKey, defaultValue: 0.0);
    _scrollController.addListener(_onScroll);
    _scrollTo();
  }

  void get getScrollTo => _scrollTo();

  void _scrollTo() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollProgressNotifier.value * _scrollController.position.maxScrollExtent);
      }
    });
  }

  void get getToTop => _toTop();

  void _toTop() {
    _scrollController.animateTo(0, duration: const Duration(milliseconds: 360), curve: Curves.easeIn).then((_) {
      _buttonOpacityNotifier.value = 0.0;
    });
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final currentPixels = _scrollController.position.pixels;
      final maxScroll = _scrollController.position.maxScrollExtent;
      if (maxScroll > 0) {
        _scrollProgressNotifier.value = currentPixels / maxScroll;
        if (currentPixels < _previousScrollPosition) {
          _buttonOpacityNotifier.value = 1.0;
        } else {
          _buttonOpacityNotifier.value = 0.0;
        }
        _previousScrollPosition = currentPixels;
      }
    }
  }

  @override
  void dispose() {
    _mainScrollStates.put(_saveProgressKey, _scrollProgressNotifier.value);
    super.dispose();
  }
}