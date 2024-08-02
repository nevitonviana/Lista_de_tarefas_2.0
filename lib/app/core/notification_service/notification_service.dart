import '../../models/notification_model.dart';

abstract class NotificationService {
  void showNotification(NotificationModel notificationModel);
}
