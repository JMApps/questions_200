import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'core/strings/app_constraints.dart';
import 'data/repositories/questions_data_repository.dart';
import 'data/services/database_service.dart';
import 'data/services/notification_service.dart';
import 'domain/usecases/questions_use_case.dart';
import 'presentation/pages/root_page.dart';
import 'presentation/state/app_settings_state.dart';
import 'presentation/state/main_app_state.dart';
import 'presentation/state/questions_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final DatabaseService databaseService = DatabaseService();
  await databaseService.initializeDatabase();

  await NotificationService().setupNotification();

  await Hive.initFlutter();
  await Hive.openBox(AppConstraints.keyAppSettingsBox);
  await Hive.openBox(AppConstraints.keyFavoritesList);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MainAppState(),
        ),
        ChangeNotifierProvider(
          create: (_) => QuestionsState(
            QuestionsUseCase(
              QuestionsDataRepository(databaseService),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AppSettingsState(),
        ),
      ],
      child: const RootPage(),
    ),
  );
}
