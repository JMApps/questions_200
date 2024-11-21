import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questions_200/data/services/notification_service.dart';

import '../../../core/strings/app_strings.dart';
import '../../../core/styles/app_styles.dart';
import '../../state/app_settings_state.dart';

class DailyNotificationsListTile extends StatefulWidget {
  const DailyNotificationsListTile({super.key});

  @override
  State<DailyNotificationsListTile> createState() => _DailyNotificationsListTileState();
}

class _DailyNotificationsListTileState extends State<DailyNotificationsListTile> {
  final NotificationService _notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsState>(
      builder: (context, appSettingsState, _) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
          shape: AppStyles.mainShapeMini,
          onTap: () {
            appSettingsState.setDailyNotificationsState = !appSettingsState.getDailyNotificationsState;
            if (appSettingsState.getDailyNotificationsState) {
              _notificationService.timeNotifications(id: NotificationService.dailyNotificationId, title: AppStrings.appName, body: AppStrings.notificationBody, dateTime: appSettingsState.getDailyNotificationsTime);
            } else {
              _notificationService.cancelNotificationWithId(NotificationService.dailyNotificationId);
            }
          },
          title: const Text(
            AppStrings.dailyNotification,
            style: AppStyles.mainTextStyle17,
          ),
          leading: IconButton(
            padding: EdgeInsets.zero,
            onPressed: appSettingsState.getDailyNotificationsState ? () async {
              final notificationTime = await showTimePicker(
                cancelText: AppStrings.close,
                confirmText: AppStrings.select,
                helpText: AppStrings.selectTime,
                context: context,
                initialTime: TimeOfDay(hour: appSettingsState.getDailyNotificationsTime.hour, minute: appSettingsState.getDailyNotificationsTime.minute),
              );
              if (notificationTime != null) {
                appSettingsState.setDailyNotificationsTime = DateTime(2024, 12, 31, notificationTime.hour, notificationTime.minute);
                if (appSettingsState.getDailyNotificationsState) {
                  _notificationService.timeNotifications(id: NotificationService.dailyNotificationId, title: AppStrings.appName, body: AppStrings.notificationBody, dateTime: appSettingsState.getDailyNotificationsTime);
                }
              }
            } : null,
            icon: Icon(
              Icons.access_time_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            iconSize: 35,
          ),
          trailing: Switch(
            value: appSettingsState.getDailyNotificationsState,
            onChanged: (onChanged) {
              appSettingsState.setDailyNotificationsState = onChanged;
              if (onChanged) {
                _notificationService.timeNotifications(id: NotificationService.dailyNotificationId, title: AppStrings.appName, body: AppStrings.notificationBody, dateTime: appSettingsState.getDailyNotificationsTime);
              } else {
                _notificationService.cancelNotificationWithId(NotificationService.dailyNotificationId);
              }
            },
          ),
        );
      },
    );
  }
}
