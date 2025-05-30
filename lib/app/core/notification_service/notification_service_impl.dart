import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../models/list_options_enum.dart';
import '../../models/notification_model.dart';
import 'notification_service.dart';

class NotificationServiceImpl implements NotificationService {
  late FlutterLocalNotificationsPlugin _localNotificationsPlugin;
  late AndroidNotificationDetails _androidDetails;

  NotificationServiceImpl() {
    _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotification();
  }

  _setupNotification() async {
    await _initialNotification();
  }

  _initialNotification() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _localNotificationsPlugin.initialize(
      const InitializationSettings(android: android),
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
  }

  _onDidReceiveNotificationResponse(NotificationResponse details) {
    if (details.payload != null && details.payload!.isNotEmpty) {
      Modular.to
          .pushNamed("/details/details?name=${ListOptionsEnum.Rebaixa.name}");
    }
  }

  @override
  Future<void> showNotification(NotificationModel notificationsModel) async {
    _androidDetails = AndroidNotificationDetails(
      "channelId",
      "channelName",
      importance: Importance.max,
      priority: Priority.high,
      enableLights: true,
      enableVibration: true,
      playSound: true,
      color: notificationsModel.color,
      icon: '@mipmap/ic_launcher',
      ticker: 'ticker',
      colorized: true,
    );
    await _localNotificationsPlugin.show(
      notificationsModel.id,
      notificationsModel.title,
      notificationsModel.body,
      payload: notificationsModel.payload,
      NotificationDetails(
        android: _androidDetails,
      ),
    );
  }
}
