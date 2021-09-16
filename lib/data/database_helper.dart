import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initializeDatabase();
    return _db!;
  }

  DatabaseHelper.internal();

  Future<Database> initializeDatabase() async {
    Directory? documentDirectory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();
    String path = join(documentDirectory!.path, 'questions.db');

    // Проверяем, существует ли база данных
    var exists = await databaseExists(path);

    if (!exists) {
      // Должно произойти только первый раз, когда вы запускаете свое приложение
      print('Создание новой копии из актива');
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {
        Exception('Invalid database');
      }
      // Копировать из актива
      ByteData data =
          await rootBundle.load(join('assets/databases', 'questions.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print('Открытие существующей базы данных');
    }
    // Открываем базу данных
    var bomDataTable =
        await openDatabase(path, version: 1, onUpgrade: _onUpgrade);
    return bomDataTable;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {}
}
