import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:questions_200/application/strings/app_constraints.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class ContentSettingsState extends ChangeNotifier {
  final _contentSettingsBox = Hive.box(AppConstraints.keyAppSettingsBox);

  int _fontIndex = 0;

  int get getFontIndex => _fontIndex;

  set changeFontIndex(int index) {
    _fontIndex = index;
    _contentSettingsBox.put(AppConstraints.keyFontIndex, index);
    notifyListeners();
  }

  int _textAlignIndex = 0;

  int get getTextAlignIndex => _textAlignIndex;

  set changeTextAlignIndex(int index) {
    _textAlignIndex = index;
    _contentSettingsBox.put(AppConstraints.keyTextAlign, index);
    notifyListeners();
  }

  double _textSize = 18.0;

  double get getTextSize => _textSize;

  set changeTextSize(double size) {
    _textSize = size;
    _contentSettingsBox.put(AppConstraints.keyTextSize, size);
    notifyListeners();
  }

  Color _lightTextColor = Colors.grey.shade900;

  Color get getLightTextColor => _lightTextColor;

  set changeLightColor(Color color) {
    _lightTextColor = color;
    _contentSettingsBox.put(AppConstraints.keyLightTextColor, color.value);
    notifyListeners();
  }

  Color _darkTextColor = Colors.grey.shade50;

  Color get getDarkTextColor => _darkTextColor;

  set changeArabicDarkColor(Color color) {
    _darkTextColor = color;
    _contentSettingsBox.put(AppConstraints.keyDarkTextColor, color.value);
    notifyListeners();
  }

  bool _adaptiveTheme = true;

  bool get getAdaptiveTheme => _adaptiveTheme;

  set changeAdaptiveTheme(bool onChanged) {
    _adaptiveTheme = onChanged;
    _contentSettingsBox.put(AppConstraints.keyAdaptiveTheme, onChanged);
    notifyListeners();
  }

  bool _darkTheme = false;

  bool get getDarkTheme => _darkTheme;

  set changeDarkTheme(bool onChanged) {
    _darkTheme = onChanged;
    _contentSettingsBox.put(AppConstraints.keyDarkTheme, onChanged);
    _darkTheme ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  bool _wakeLock = true;

  bool get getWakeLock => _wakeLock;

  set changeWakeLock(bool onChanged) {
    _wakeLock = onChanged;
    _wakeLock ? WakelockPlus.enable() : WakelockPlus.disable();
    _contentSettingsBox.put(AppConstraints.keyWakeLock, onChanged);
    notifyListeners();
  }

  ContentSettingsState() {
    _fontIndex = _contentSettingsBox.get(AppConstraints.keyFontIndex, defaultValue: 0);
    _textAlignIndex = _contentSettingsBox.get(AppConstraints.keyTextAlign, defaultValue: 0);
    _textSize = _contentSettingsBox.get(AppConstraints.keyTextSize, defaultValue: 18.0);
    _lightTextColor = Color(_contentSettingsBox.get(AppConstraints.keyLightTextColor, defaultValue: Colors.grey.shade900.value));
    _darkTextColor = Color(_contentSettingsBox.get(AppConstraints.keyDarkTextColor, defaultValue: Colors.grey.shade50.value));
    _adaptiveTheme = _contentSettingsBox.get(AppConstraints.keyAdaptiveTheme, defaultValue: true);
    _darkTheme = _contentSettingsBox.get(AppConstraints.keyDarkTheme, defaultValue: false);
    _wakeLock = _contentSettingsBox.get(AppConstraints.keyWakeLock, defaultValue: true);
    _wakeLock ? WakelockPlus.enable() : WakelockPlus.disable();
  }
}
