import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../core/strings/app_constraints.dart';

class AppSettingsState extends ChangeNotifier {
  final _contentSettingsBox = Hive.box(AppConstraints.keyAppSettingsBox);

  AppSettingsState() {
    _fontIndex = _contentSettingsBox.get(AppConstraints.keyFontIndex, defaultValue: 0);
    _textSizeIndex = _contentSettingsBox.get(AppConstraints.keyTextSizeIndex, defaultValue: 1);
    _textAlignIndex = _contentSettingsBox.get(AppConstraints.keyTextAlignIndex, defaultValue: 0);
    _lightTextColor = _contentSettingsBox.get(AppConstraints.keyLightTextColor, defaultValue: Colors.blueGrey.shade900.value);
    _darkTextColor = _contentSettingsBox.get(AppConstraints.keyDarkTextColor, defaultValue: Colors.blueGrey.shade50.value);
    _appThemeIndex = _contentSettingsBox.get(AppConstraints.keyAppThemeIndex, defaultValue: 2);
    _appThemeColor = _contentSettingsBox.get(AppConstraints.keyAppThemeColor, defaultValue: Colors.green.value);
    _wakeLockState = _contentSettingsBox.get(AppConstraints.keyWakeLockState, defaultValue: false);
    _wakeLockState ? WakelockPlus.enable() : WakelockPlus.disable();
    _dailyNotificationsState = _contentSettingsBox.get(AppConstraints.keyDailyNotifications, defaultValue: false);
    _dailyNotificationsTime = _contentSettingsBox.get(AppConstraints.keyDailyNotificationsTime, defaultValue: DateTime(2024, 12, 31, 11, 00).toIso8601String());
  }

  late int _fontIndex;

  int get getFontIndex => _fontIndex;

  set setFontIndex(int index) {
    _fontIndex = index;
    _contentSettingsBox.put(AppConstraints.keyFontIndex, _fontIndex);
    notifyListeners();
  }

  late int _textSizeIndex;

  int get getTextSizeIndex => _textSizeIndex;

  set setTextSizeIndex(int index) {
    _textSizeIndex = index;
    _contentSettingsBox.put(AppConstraints.keyTextSizeIndex, _textSizeIndex);
    notifyListeners();
  }

  late int _textAlignIndex;

  int get getTextAlignIndex => _textAlignIndex;

  set setTextAlignIndex(int index) {
    _textAlignIndex = index;
    _contentSettingsBox.put(AppConstraints.keyTextAlignIndex, _textAlignIndex);
    notifyListeners();
  }

  late int _lightTextColor;

  int get getLightTextColor => _lightTextColor;

  set setLightColor(int color) {
    _lightTextColor = color;
    _contentSettingsBox.put(AppConstraints.keyLightTextColor, _lightTextColor);
    notifyListeners();
  }

  late int _darkTextColor;

  int get getDarkTextColor => _darkTextColor;

  set setDarkColor(int color) {
    _darkTextColor = color;
    _contentSettingsBox.put(AppConstraints.keyDarkTextColor, _darkTextColor);
    notifyListeners();
  }

  late int _appThemeIndex;

  int get getAppThemeIndex => _appThemeIndex;

  set setThemeIndex(int index) {
    _appThemeIndex = index;
    _contentSettingsBox.put(AppConstraints.keyAppThemeIndex, _appThemeIndex);
    notifyListeners();
  }

  ThemeMode get getThemeMode {
    late ThemeMode currentTheme;
    switch(_appThemeIndex) {
      case 0:
        currentTheme = ThemeMode.light;
        break;
      case 1:
        currentTheme = ThemeMode.dark;
        break;
      case 2:
        currentTheme = ThemeMode.system;
        break;
      default: currentTheme = ThemeMode.system;
    }
    return currentTheme;
  }

  late int _appThemeColor;

  int get getAppThemeColor => _appThemeColor;

  set setAppThemeColor(int color) {
    _appThemeColor = color;
    _contentSettingsBox.put(AppConstraints.keyAppThemeColor, _appThemeColor);
    notifyListeners();
  }

  late bool _wakeLockState;

  bool get getWakeLockState => _wakeLockState;

  set changeWakeLock(bool state) {
    _wakeLockState = state;
    _wakeLockState ? WakelockPlus.enable() : WakelockPlus.disable();
    _contentSettingsBox.put(AppConstraints.keyWakeLockState, _wakeLockState);
    notifyListeners();
  }

  late bool _dailyNotificationsState;

  bool get getDailyNotificationsState => _dailyNotificationsState;

  set setDailyNotificationsState(bool state) {
    _dailyNotificationsState = state;
    _contentSettingsBox.put(AppConstraints.keyDailyNotifications, _dailyNotificationsState);
    notifyListeners();
  }

  late String _dailyNotificationsTime;

  DateTime get getDailyNotificationsTime => DateTime.parse(_dailyNotificationsTime);

  set setDailyNotificationsTime(DateTime dateTime) {
    _dailyNotificationsTime = dateTime.toIso8601String();
    _contentSettingsBox.put(AppConstraints.keyDailyNotificationsTime, _dailyNotificationsTime);
    notifyListeners();
  }
}
